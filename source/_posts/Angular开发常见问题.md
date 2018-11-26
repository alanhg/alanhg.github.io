---
title: Angular开发常见问题
abbrlink: dc22bcd7
date: 2017-10-26 20:31:06
tags:
- Angular
---
> Angular开发总会遇到诸多的问题，这里我将自己在开发中遇到的主要问题总结一番，方便自己偶尔翻查，也兴许能够帮大家解决些问题。

说明:`*本文持续更新*`,所贴代码由于篇幅限制，有些只是部分，建议直接去[GitHub-ISSUE](https://github.com/alanhg/angular-demo/issues)中去看

## 目录

1.  [[innerHTML]中的JavaScript不能执行吗？](#[innerHTML]中的JavaScript不能执行吗？)
2.  [同时订阅路由参数和查询参数即params和queryParams](#同时订阅路由参数和查询参数即params和queryParams)
3.  [多异步请求并行处理](#多异步请求并行处理)
4.  [*ngFor遍历对象属性](#*ngFor遍历对象属性)
5.  [组件类的继承性](#组件类的继承性)
6.  [如何使组件样式超出组件作用域](#如何使组件样式超出组件作用域)
7.  [下拉列表选项布尔类型转换](#下拉列表选项布尔类型转换)
8.  [模板标签<ng-container>、<ng-template>](#模板标签<ng-container>、<ng-template>)
9.  [CLI下index.html页面未模板化，如何动态更改内容](#CLI下index.html页面未模板化，如何动态更改内容)
10. [CLI下如何添加第三方CSS](#CLI项目如何添加第三方CSS)
11. [httpclient下的拦截器使用](#httpclient下的拦截器使用)

## [innerHTML]中的JavaScript不能执行吗？

答案：`YES`,不行的，这个牵扯到Angular的安全机制，官方介绍看[这里](https://angular.io/guide/security)
Angular官方的意思是倘若支持了这个，便存在攻击性，本身就是很可怕的，试想，Angular本身就是个JS框架，倘若支持了html代码块可执行JS，本身就会打破这个框架，带来致命的安全问题。

另外对于HTML，想让NG支持解析，需要注入DomSanitizer服务，将HTML标记位可信任。如果web中常用，建议做成管道，例子[看这里](https://github.com/alanhg/angular-demo/blob/master/src/app/security/safe.pipe.ts)

另外使用`bypassSecurityTrustHtml`,经测试，情况如下

+  页内CSS正常
+  外链CSS正常
+  执行JS不可以
+  嵌入媒体正常

如果我们还是希望能够执行HTML代码块中的JS，其实就需要换个角度去解决，比如iframe?对吧，总是有办法的。

## 同时订阅路由参数和查询参数即params和queryParams

进入一个视图页面时候，我们经常需要订阅参数，参数是有很多类型的，路径参数、查询参数,锚点参。我们如果利用嵌套形式写的话，会是这样子:
```typescript
    this.route.queryParams.subscribe(qparams => {
            alert(qparams['title']);
            this.route.params.subscribe(params => {
                alert(params['id']);
            });
        })
```

但是这样子的代码是极难维护的，其实RXJS有对应的解决办法，可以这样子实现

```typescript
 let obsCombined = Observable.combineLatest(this.route.params, this.route.queryParams, (params, qparams) => ({
            params,
            qparams
        }));
        obsCombined.subscribe(ap => {
            console.log(ap);
            let params = ap['params'];
            let qparams = ap['qparams'];
            alert(qparams['title']);
            alert(params['id']);
        });
```
这样子减少了嵌套，代码直接清爽不少。

注意一个细节:`import {Observable} from "rxjs/Rx";`
写成`import {Observable} from "rxjs/Observable";`会报错误`Property 'combineLatest' does not exist on type 'typeof Observable'.`

## *ngFor遍历对象属性
有时需要遍历对象属性，但是Angular的ngFor指令是只支持遍历数组的，所以需要转换对象，这个时候可以考虑封装个管道，代码如下
```typescript

import {Pipe, PipeTransform} from "@angular/core";
/**
 * 对象返回数组
 */
@Pipe({
  name: 'keys'
})
export class KeysPipe implements PipeTransform {

  transform(value: any, args?: any): any {
    return Object.keys(value);
  }
}

```
实际上，就是用了JS的`Object.keys()`方法，该方法作用如下
> 
The Object.keys() method returns an array of a given object's own enumerable properties, in the same order as that provided by a for...in loop (the difference being that a for-in loop enumerates properties in the prototype chain as well).

管道做好后，使用方法如下:
```html
<div *ngFor="let key of facetFields|keys">
key:{{key}},
value:{{facetFields[key]}}
      </div>
```

## 多异步请求并行处理
有时需要多请求结果同时进行处理，嵌套去做的话，会是如此
```typescript
this.http.get('/api/test1')
      .subscribe(res1 => {
        this.http.get('/api/test2').subscribe(res2 => {
          this.res1 = res1;
          this.res2 = res2;
        });
      });
```
这种结构臃肿，难以维护，使用Rxjs的`forkJoin`操作符
```typescript
const req1 = this.http.get('/api/test1');
const req2 =this.http.get('/api/test2');

Rx.Observable.forkJoin(req1, req2).subscribe(
res => {
 this.res1 = res[0];
 this.res2 = res[1];
)) 

```
只有当多请求结果都得到时，才会通知我们

## 组件类的继承性
`ng-v2.3`版本加入了对于组件继承性的支持，这样进一步的提升代码的复用性。

组件继承性说明:
+ meta注解，比如@input,@output
+ 构造函数
+ 组件生命周期

以上三者均支持复用，官方说明看这里，[链接](https://github.com/angular/angular/commit/f5c8e09)
![image](https://user-images.githubusercontent.com/9245110/32786687-9d9776ee-c98f-11e7-972e-79e47e713e9f.png)

## 如何使组件样式超出组件作用域

### 如何使得A组件的样式在A的子组件比如B中能够使用的

除了将样式写外链CSS即全局CSS之外，其实还可以修改视图封装模式即**view encapsulation mode**达到组件样式可以出去，使得其他组件可以使用。只需要配置比如A组件的视图模式，如下配置
```
@Component({
    selector: 'app-css',
    templateUrl: './css.component.html',
    styleUrls: ['./css.component.css'],
    encapsulation: ViewEncapsulation.None
})
```

如上，则该组件下的各级组件dom元素均可使用该样式。


### 注意

`组件继承不支持模板和样式，任何操作dom的行为都应该物理分离。`

[实际Demo看这里](https://github.com/alanhg/angular-demo/issues/10)

## 下拉列表选项布尔类型转换

> 当我们对下拉列表进行ngModel双向绑定，如果我们的对象是非字符串类型，比如boolean,当用户选择选项后，会变成字符串。

如果下拉选项被提供了非字符串类型，缺省value是会进行字符串类型转换，如果使用ngValue，就可以保持类型不变。

```html
<select [(ngModel)]="isList" (ngModelChange)="viewTypeChanged()">
    <option [ngValue]="true">列表浏览</option>
    <option [ngValue]="false">分组浏览</option>
</select>
```

## 模板标签<ng-container>、<ng-template>

`ng-template`我们经常搭配ngIf指令等使用，如下:
```html
<div *ngIf="isList;else elseBlock">
    <ul>
        <li *ngFor="let item of items">
            <a routerLink='../detail/{{item.id}}' [queryParams]="{title:item.title}">
                {{item.title}}
            </a>
        </li>
    </ul>
</div>
<ng-template #elseBlock>
    <div>
        分组浏览
    </div>
</ng-template>

```
但是，这样子，比如为true时候，我们生成的code中是会多了个if所谓的标签`div`，有时候我们是不需要这个的，如何不额外增加`div`标签呢,答案是使用ng-container标签。

```html
<ng-container *ngIf="isList;else elseBlock">
    <ul>
        <li *ngFor="let item of items">
            <a routerLink='../detail/{{item.id}}' [queryParams]="{title:item.title}">
                {{item.title}}
            </a>
        </li>
    </ul>
</ng-container>
<ng-template #elseBlock>
    <div>
        分组浏览
    </div>
    <div *ngFor="let i of [1,2,3]">
        <h3> {{i}}</h3>
    </div>
</ng-template>
```

## CLI下index.html页面未模板化，如何动态更改内容

> Angular开发，多数还是使用官方的CLI构建工具，但是官方CLI构建下的前端，index页面是死的，比如希望构建打包的index页面中是无法追加部分内容的，那么只能自己手动去实现了。

以下就是场景和对应的解决思路
### 场景
> 生产部署，我是希望构建打包出来的index.html页面中增加<meta name="releaseDate" content="${releaseDate}"/>，这样通过看源码的标记位，我能知晓，这是何时发布的新版前端。

### 解决方案
#### 增加脚本文件

```javascript
const fs = require('fs');
const cheerio = require('cheerio');
const moment = require('moment');
const indexFilePath = 'dist/index.html';

fs.readFile(indexFilePath, 'utf8', function (err, data) {
  if (err) {
    return console.log(err);
  }
  const $ = cheerio.load(data, {decodeEntities: false});
  const releaseDate = moment().format('YYYY-MM-DD HH:mm');
  $('meta').last().append(`<meta name="releaseDate" content="${releaseDate}"/>`);
  // now write that file back
  fs.writeFile(indexFilePath, $.html(), function (err) {
    if (err) return console.log(err);
    console.log('Successfully rewrote index html');
  });
});

```

#### package.json
```json
    "build:prod": "ng build --prod && node scripts/after-build.js",
```

这样，当我们执行`npm run build:prod`时，就会在前端构建成功后，执行修改内容脚本。

## CLI项目如何添加第三方CSS
> 对于第三方CSS，由于考虑未来升级可能，及避免被开发人员直接强行篡改源码，所以一般不放在assets下。

对于第三方的CSS
### 如果是要打包直接进入styles.css中，有两个办法:
1. json配置文件里配置
```json
 "styles": [
        "../node_modules/ngx-bootstrap/datepicker/bs-datepicker.css",
        "styles.css"
      ],

```
2. css中直接import

```css
/* You can add global styles to this file, and also import other style files */
@import '~ngx-bootstrap/datepicker/bs-datepicker.css';


```

单纯就这两个方案，建议使用第一个，CLI下面的项目优先考虑使用CLI的方式

### 如果还是物理分离，直接在index.html中导入即可
```html
<link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
```

## httpclient下的拦截器使用


ng4.3推出拦截器功能,支持对于请求和回复的改变，也就是在发起请求前和收到回复后可以预先处理下。

官网原话:
> A major feature of /http is interception, the ability to declare interceptors which sit in between your application and the backend. When your application makes a request, interceptors transform it before sending it to the server, and the interceptors can transform the response on its way back before your application sees it. This is useful for everything from authentication to logging.

### 场景
> 在实际开发做用户认证的时候，我的前端需要在请求头部加入令牌，然后再收到后端回复的时候，对于特定状态，执行相应动作。
  
### CODE

token.interceptor.service.ts

```typescript
import {Injectable} from '@angular/core';
import {AuthService} from './auth.service';
import {HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Observable} from 'rxjs/Observable';
import {AlertService} from './alert.service';
import 'rxjs/add/operator/do';

/**
 * Created by He on 10/01/18.
 * 令牌拦截器
 */
@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  constructor(public authService: AuthService, private alertService: AlertService) {
  }

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    if (this.authService.getToken()) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${this.authService.getToken()}`
        }
      });
    }
    return next.handle(request).do((event) => {
        return event;
      },
      (err: any) => {
        if (err instanceof HttpErrorResponse) {
          if (err.status === 401) {
            this.alertService.showAlert({type: 'danger', msg: err.error['err']});
            this.authService.removeToken();
            location.reload();
          }
        }
        return Observable.throw(err);

      }
    );
  }
}

```

## 仍有疑问???不够详细???

![仍有疑问???](//static.1991421.cn/blog/2017-10-26-question_72px_1094871_easyicon.net.png)

### 欢迎在GitHub/angular-demo上提票和查看以上问题的最新解答[点击这里](https://github.com/alanhg/angular-demo/issues)
