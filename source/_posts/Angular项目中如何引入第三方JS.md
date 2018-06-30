---
title: Angular项目中如何引入第三方JS
date: 2018-06-30 09:29:50
tags:
- Angular
---
> 在实际进行Angular项目开发时，会需要引入第三方JS，比如`base64.js`，一个关键词检索高亮的类库。

如何去做呢?

## 引入JS
```
npm install --save js-base64
```

### 安装类型声明文件
```bash
npm install --save-dev @types/js-base64

```
### 组件中导入
```typescript
import {Base64} from 'js-base64';

export class HomeComponent implements OnInit {
    constructor() {
        console.log(Base64.encode('dankogai'));
    }
...
}
```
如上，即可正常使用js-base64。并不难，但有几个点要说明下，弄明白为止。

## @types/js-base64是什么
> TypeScript 是 JavaScript 的超集，相比 JavaScript，其最关键的功能是静态类型 检查 (Type Guard)。然而 JavaScript 本身是没有静态类型检查功能的，TypeScript 编译器也仅提供了 ECMAScript 标准里的标准库类型声明，只能识别 TypeScript 代码 里的类型。
TypeScript 的声明文件是一个以 .d.ts 为后缀的 TypeScript 代码文件， 但它的作用是描述一个 JavaScript 模块（广义上的）内所有导出接口的类型信息.
我们这里安装这个就是js-base64的声明文件，*也正因为有了这个,js-base64这个对象类型可以被识别，我们可以看到IDE会识别它的函数比如encode()*.

## 导入js-base64,打包js-base64去哪了
这种导入方式，构建打包，js-base64会进入ng项目的文件，如果系统没做懒加载，则会在main中，如果做了懒加载，则会进入导入使用的模块对应chunk.js文件中。
## @types这种方式是唯一方案吗?
NO！我们也可以这样
1. index.html文件中导入对应的JS资源
2.在使用的组件头部进行声明`declare const Base64: any;`
这样也可以，但坏处就是实际上发挥不了TS的静态类型检查，算是有利有弊吧。