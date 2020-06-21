---
title: query-string@5 vs 6
tags:
  - query-string
  - Browser Compatibility
abbrlink: fb6a3cda
date: 2020-02-09 19:13:58
---
> query-string是前端常用的类库，用于为URL中的查询参的正反向解析。正常来说，我们使用的话，直接安装用最新版6.x即可。但之前曾遇到一次白屏事故，最后定位到是因为v6版的兼容问题。于是这篇文章就聚焦于清晰v5,v6的区别，及对WEB的影响。


## 官网对于5 vs 6差异的说法
> This module targets Node.js 6 or later and the latest version of Chrome, Firefox, and Safari. If you want support for older browsers, or, if your project is using create-react-app v1, use version 5: npm install query-string@5.

翻看Git提交记录，注意到这个第一次的v6提交信息。现代浏览器具体是什么，哪个版呢？

![](https://i.imgur.com/pk3lX06.png)

结论:_文档写的含糊不清，有坑。_

## 代码
想准确的知道5与6的差异，只能具体看代码了

### ChangeLog
这里列举下从源码上看到的6的主要变化

1. 去掉[object-assign第三方实现](https://github.com/sindresorhus/object-assign#readme)，使用原生`Object.assign`
2. 使用const进行常量声明
3. 使用箭头函数语法糖

- const的兼容性到IE11+【包含11】
- Object.assign的兼容性是IE不支持。

## 结论
- 不加入兼容文件的前提下，v6不支持IE，v5支持
- React框架在不加入兼容文件的前提下，也不支持IE，如果想支持IE11，需要加入以下文件
		
	```js
	import 'react-app-polyfill/ie11';
	import 'react-app-polyfill/stable';
	```
	
	polyfill解决的问题之一就是`Object.assign`，所以加入我们的Web目标是支持IE11，本身增加的兼容文件完全可以解决query-string的问题，如果不需要支持IE11，那更不需要担心，直接升级即可。
- 因为query-string v6改为使用原生`Object.assign`，所以体积肯定是进一步的缩小，当然这只是微乎其微而已，但你要知道。

## 写在最后

随着浏览器的大一统，在不考虑IE这个猪队友的前提下，似乎Safari，Edge，Chrome，Firefox的兼容性不是问题，但知悉兼容性仍然是前端必修课。
