---
title: 浏览器原生支持JS Base64
date: 2020-07-02 14:21:32
tags:
- JavaScript
- Base64
- 
---
> 最近在MR代码时发现有人这么写`btoa`,郁闷了一下，原来这个是原生的Base64编码，好吧，个人JS基础存在盲区，这里补充下。

## 浏览器原生支持base64编码解码


```js
console.log(window.btoa('hello')); // aGVsbG8=
console.log(window.atob('aGVsbG8=')); // hello
```

## a to b如何记忆

- "a" for "ASCII"
-  "b" for "binary"
 
注意：ASCII只考虑了英文字符，具体可查看我之前的另一篇[文章](https://1991421.cn/2020/05/09/4d28b2a7/)

## 中文情况

```js
   console.log(window.btoa(encodeURIComponent('中文'))); // JUU0JUI4JUFEJUU2JTk2JTg3
   console.log(decodeURIComponent(window.atob('JUU0JUI4JUFEJUU2JTk2JTg3'))); // 中文
```
 如上，含有中文需要进行编码，直接btoa会报错，错误信息如下
 
> t2020-07-02-135210.html:14 Uncaught DOMException: Failed to execute 'btoa' on 'Window': The string to be encoded contains characters outside of the Latin1 range.
    at

Why？`ascii不支持中文啊。。。`

## 浏览器支持情况

![](https://static.1991421.cn/2020/2020-07-02-144126.jpeg)

IE10+都行了，没问题，假如真的想支持IE9？好的,勇士，搞个polyfill就行。

## 对js-base64 say good bye 
既然原生已经支持，那么完全可以不用依赖第三方库了，在了解到原生支持后，我就立即删除了[js-base64](https://github.com/dankogai/js-base64),随之而来的直接benefit是打包体积的变小，虽然变化不大，但仍然是个进步，不是吗？

*js-base64 未压缩版 8KB，压缩版是5KB*

## 写在最后
聊聊数语，强化记忆，填补认知空白。
