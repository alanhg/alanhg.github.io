---
title: query-string@5 vs 6
tags:
  - query-string
  - Browser Compatibility
abbrlink: fb6a3cda
date: 2020-02-09 19:13:58
---
> query-string是前端常用的类库，用于为URL中的查询参的正反向解析。正常来说，我们使用的话，直接安装用最新版6.x即可。但之前曾遇到一次白屏事故，最后定位到是因为v6版的兼容问题。于是这篇文章就聚焦于清晰化v5,v6的区别，及对WEB的影响。


## 官网对于5 vs 6差异的说法
> This module targets Node.js 6 or later and the latest version of Chrome, Firefox, and Safari. If you want support for older browsers, or, if your project is using create-react-app v1, use version 5: npm install query-string@5.

关键哪个版本的是旧浏览器呢？含糊不清，吐槽下。

翻看Git提交记录，注意到这个第一次的v6提交信息。傻傻看不懂，现代浏览器具体是什么，哪个版呢？

![](https://i.imgur.com/pk3lX06.png)

结论:_文档写的含糊不清，有坑。_

## 代码
想准确的知道5与6的差异，只能具体看代码了

### ChangeLog
这里列举下从源码上看到的6的主要变化

1. 去掉[object-assign](https://github.com/sindresorhus/object-assign#readme)，使用原生`Object.assign`
2. 使用const
3. 使用箭头函数语法糖

- const的兼容性到IE11+【包含11】
- Object.assign的兼容性是IE压根不支持。

_**那么两个版本对于兼容性的影响就清晰了，在不加入兼容文件的前提下，v6不支持IE，v5支持,注意React框架的兼容性也如此，对于IE支持需要导入polyfill。**_


`曾经的新浏览器--Edge浏览器`的首次发布时间是2015年，而query-string的v6最早是18年发布的，so把IE11当作旧浏览器不过分吧？

## 写在最后
随着浏览器的大一统，在不考虑IE这个猪队友的前提下，似乎Safari，Edge，Chrome，Firefox的兼容性不是问题，但知悉兼容性仍然是前端必修课。
