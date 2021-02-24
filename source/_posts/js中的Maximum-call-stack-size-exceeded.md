---
title: js中的Maximum call stack size exceeded
date: 2021-02-24 22:32:37
tags:
- JavaScript
- Chrome
---

> 在实际开发中有时会遇到`Maximum call stack size exceeded`错误，顾名思义即栈溢出。但认知仅限于此是不够的，这里就针对这个话题总结下。

## 栈

栈是一种数据结构，特征是后进先出，在JS中函数调用存在A函数调用B函数，B函数又调用C函数的复杂情况，对于多个执行上下文就涉及如何管理，JS引擎就是采用栈来进行管理。

举个例子

```javascript
      function sayA() {
        console.log('sayA');
        sayB();
      }
      function sayB() {
        console.log('sayB');
        sayC();
      }
      function sayC() {
        console.log('sayC');
        debugger;
      }
      sayA();
```

当在Chrome开发者工具下打断点查看时，即可看出当C函数执行时的调用栈情况。即C最后入栈，在最顶部，符合栈的特征。

![](https://static.1991421.cn/2021/2021-02-24-230520.jpeg)

既然是栈，那么栈深度是多少，于是做了个测试。

## 栈的最大调用深度

```javascript
  function runStack(n) {
        if (n === 0) return 100;
        return runStack(n - 1);
      }
      runStack(20000);
```

如上递归程序如果浏览器运行即会报栈溢出，但是调整n值又可以让其不报错，于是就可以借此快速确定栈的深度

- 测试结果`Chrome 88.0.4324.192`的栈深度为`11383`，超出比如11384即报错。

- 不同浏览器，不同版本，栈深度会不同。
- 栈深度是不可修改的。
- 调用栈有两个指标，最大栈容量和最大调用深度，满足其中任意一个就会栈溢出。个人认为最大栈容量指的是存储上下文本身占用的容量

针对`调用栈溢出`控制台都会报错，根本错误行可以追溯出问题代码，进行修复，但有时我们可以面对代码还没有报错但出现了性能问题，如何快速找到开销较大的函数呢



## Chrome DevTools辅助分析

Chrome开发者工具中的Performance及Memory工具可以辅助进行内存占用分析。

- Performance可以记录一段时间内页面所有操作的内存占用情况
- Memory可以快照一时刻执行栈内存情况

仍然是runStack，通过Performance可以发现runStack一直在执行直到内存溢出。

![](https://static.1991421.cn/2021/2021-02-24-233144.jpeg)

这里为了快照记录下内存溢出前，runStack占用情况，这里故意在n=11383的时候加入断点，从而可以快照下。可以看出内存占用确实很高。

![](https://static.1991421.cn/2021/2021-02-24-234950.jpeg)



注意：size单位为字节。

## 写在最后

善用Chrome开发者工具，可以更好的了解WEB，更高效的排查解决问题。

