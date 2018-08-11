---
title: 聊聊Babel与TSC
tags:
  - Babel
  - Polyfill
  - Compiler
abbrlink: 55eb7b77
date: 2018-08-11 20:31:35
---
> React项目一般使用Babel进行编译，Angular【不是AngularJS】项目则会使用TSC进行编译。之前都只是肤浅的使用这些，未尝深入，so在开发中总是不小心踩坑，比如Object.assign方法，Promise对象，正则零宽度正回顾后发断言等等不支持。

![](http://or0g12e5e.bkt.clouddn.com/2018-08-11-112400.jpg)
因此有必要搞明白些。

## 编译器编译什么
### 上定义
- _Babel is a JavaScript compiler.Use next generation JavaScript, today._
- _TypeScript is a superset of JavaScript that compiles to clean JavaScript output._

定义取自各自的官网，言简意赅，编译器是将我们书写的代码，编译成目标代码。
但是**`编译实际上只是编译语法糖，并不转换新的API，比如Promise,Symbol等，又或者全局对象上的方法(比如Object.assign)，这些都不会转码`**,因为无中生有他们做不到

那。。。不支持的浏览器怎么解决呢，必须加Polyfill【兼容文件】，说到底就是将新的API和全局对象方法等也放在JS里，这样浏览器就可以支持了。怎么放呢?
### React+Babel项目
#### babel-polyfill
1. 安装[Babel-polyfill](https://github.com/babel/babel/tree/master/packages/babel-polyfill)
	```
	npm i babel-polyfill --save-dev
	```
2. Webpack下增加入口文件
	```javascript
	module.exports = {
  entry: ["babel-polyfill", "./app/js"]
};
	```
这种方式简单，但坏处是一股脑导入，增大了整体JS体积

#### babel-runtime
1. 安装babel-plugin-transform-runtime和core-js

	```
	npm i babel-plugin-transform-runtime --save-dev

	npm i core-js --save-dev
	```

2. Babel配置

	```
	query: {
  plugins: [
    "transform-runtime"
  ],
  presets: ['es2015', 'stage-0']

	```
假如我们在开发中用了Promise对象，则构建打包就会自动把Promise对象打包进去，这样整体体积就不会很大。但构建性能开销就相比较上一种方法大些。

#### `按需加载`
假如我们开发的系统目标浏览器可能不止一种，版本也参差不齐，那么我们的兼容文件对于支持的浏览器请求就是不必要的开销。比如Chrome是支持Promise，我们这个时候的返回就很不必要。

以下是我做的Angular+ExpressJS项目的一段兼容文件加载策略
![](http://or0g12e5e.bkt.clouddn.com/2018-08-11-121039.png)

### Angular项目下使用TSC
兼容脚本的使用与上面措施都是大同小异，比如可以直接在Polyfill.ts中导入core-js对象，或者如上按需加载，都可。

## 编译器的好处
明白了编译器的作用其实也就明白了编译器的好处。因为有了编译器，我们无惧当前浏览器的现状而嘚瑟的使用新特性，从而提升工程的开发效率，可维护性等等。要知道ES6开始，ES一年一更新。

## 写在最后
我们可能对于TypeScript,React这些新兴，大热门学习热情高些。比如Babel,TSC却不那么明显，很多时候它们似乎是透明的，比如在Angular开发环境下，我们只是正常去书写TS，构建的话执行build命令，TS配置文件可能就只是脚手架给出的缺省文件，丝毫不用修改，所以它的存在基本都是透明的。但它们作用却一点也不小，没有编译器，也谈不上我们可以使用这些新特性了，所以有必要搞懂它，明白它，否则坑不断，掌握了它们，没坏处。