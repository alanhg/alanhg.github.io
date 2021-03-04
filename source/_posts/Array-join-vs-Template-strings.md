---
title: Array.join vs Template strings vs String concatenation
tags:
  - JavaScript
  - performance
abbrlink: 99c1b920
date: 2021-02-28 18:01:04
---
> 最近Stackoverflow上看到一个问题，[Are ES6 template literals faster than Array join at constructing long strings](https://stackoverflow.com/questions/54352451/are-es6-template-literals-faster-than-array-join-at-constructing-long-strings)，这个问题被管理员直接关闭了，因此看不到有人给出答案，但问题确实有点意思，毕竟我不确定，于是这里就测试并记录下。

## Benchmark

测试数据及代码如下。

```javascript
var arr = Array(10000)
  .fill(1)
  .map(() => 'A' + Math.ceil(Math.random() * 100));


// array.join
var res=arr.join('; ');

// string literal
var finalString2 = arr.reduce((res, item) => {
  return `${res}; ${item}`;
}, '');

// string concatenation
var finalString3 = arr.reduce((res, item) => {
  return res + '; ' + item;
}, '');
```



测试结果如下，可以看出array.join的性能最佳，我尝试改变样本数据量即数组长度，但结果还是很固定。

<iframe src="https://measurethat.net/Embed?id=167479" width="100%" height="500px"></iframe>



## 分析

想了下，string literal及string concatenation之所以耗费性能更大点，原因在与都需要创建临时资源字符串赋值即上述函数中的回调函数，而string literal与string concatenation相对，相对性能开销小一点应该是回调中它只需要一个临时字符串，而string contactenation需要2个，即两次+。

## 写在最后

确实，性能有时不差这一点，毕竟程序员写出计算机能懂的程序很简单，但是写成程序员写出的程序却更难，有时不需要在乎这点performance差距。但当大数量处理逻辑时，我们就是要考虑这点，毕竟系统会崩不是吗。



由此至少我们知道了，当数据量较大时，array.join的性能还是相对最佳的。

