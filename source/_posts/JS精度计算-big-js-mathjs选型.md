---
title: JS精度计算-big.js&mathjs选型
date: 2020-04-01 23:38:11
tags:
- JavaScript
- 精度计算
---

> 最近项目中牵扯到精度计算，原生number类型的小数计算有精度损失，比如0.1+0.2可不是等于0.3。于是需要进行轮子选择。找到了以下的2个方案予以考虑，这里简单列下
>
> 当然我最终选择了`mathjs`

![](https://i.imgur.com/Ywkg9Jy.jpg)

## big.js
> A small, fast JavaScript library for arbitrary-precision decimal arithmetic.

`体积: 5.9 KB minified and 2.7 KB gzipped`


![](https://i.imgur.com/Q8XQdw8.jpg)

以上体积为CDN访问下情况

### 优势

1. 体积

[戳这里](https://github.com/MikeMcl/big.js)

## mathjs
> Math.js is an extensive math library for JavaScript and Node.js. It features a flexible expression parser with support for symbolic computation, comes with a large set of built-in functions and constants, and offers an integrated solution to work with different data types like numbers, big numbers, complex numbers, fractions, units, and matrices. Powerful and easy to use.

体积：Unpacked Size 10.2 MB

![](https://i.imgur.com/rlltCY0.jpg)

### 优势
1. 表达式解析

### 兼容性

Math.js works on any ES5 compatible JavaScript engine: node.js, Chrome, Firefox, Safari, Edge, and IE11.

[戳这里](https://github.com/josdejong/mathjs)


## 个人看法

如果计算极其简单，就是简单的A*B，确实big.js足够，但是假如是比较复杂的计算，实际上如果使用big.js,丧失可读性。但是mathjs却可以。


### 举个例子
比如有以下一个公示，假如使用mathjs可以这么去写

![](https://i.imgur.com/zJWBP2y.jpg)

但是换成big.js呢,哪个更易读呢，显而易见，单纯的体积完全可以通过CDN，缓存等消化掉，所以我最终选择mathjs

![](https://i.imgur.com/U9pQ2EC.jpg)

## 写在最后

方案都行，合适即可。

