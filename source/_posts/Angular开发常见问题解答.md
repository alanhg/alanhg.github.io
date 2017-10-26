---
title: Angular开发常见问题解答
abbrlink: dc22bcd7
date: 2017-10-26 20:31:06
tags:
- Angular
---
> Angular开发总会遇到诸多的问题，这里我将自己在开发中遇到的主要问题总结一番，方便自己偶尔翻查，也兴许能够帮大家解决些问题。

说明:`*本文持续更新*`

## 目录

+ [[innerHTML]中的JavaScript不能执行吗？](#[innerHTML]中的JavaScript不能执行吗？)
+ [同时订阅路由参数和查询参数即params和queryParams](#同时订阅路由参数和查询参数即params和queryParams)
+ [*ngFor遍历对象属性](#*ngFor遍历对象属性)

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

## 仍有疑问???

![仍有疑问???](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-26-question_72px_1094871_easyicon.net.png)

### 欢迎在GitHub/angular-demo上提票[点击这里](https://github.com/alanhg/angular-demo/issues)