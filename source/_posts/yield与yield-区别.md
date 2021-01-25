---
title: yield与yield*区别
tags:
  - JavaScript
  - generator
  - Redux-Saga
abbrlink: 3fc5544f
date: 2021-01-15 23:45:57
---

> JS生成器函数认识不足，最近开发中碰了壁，于是梳理学习，Mark下。

## yield vs yield*

### yield      

The yield keyword is used to pause and resume a generator function  or legacy generator function.

yield 关键字用来暂停和恢复一个生成器函数（([function*](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/function*) 或[遗留的生成器函数](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/Legacy_generator_function)）。

### yield*

The **`yield*` expression** is used to delegate to another [`generator`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*) or iterable object.

**`yield*` 表达式**用于委托给另一个[`generator`](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/function*) 或可迭代对象。

### 举个例子

```javascript
 function* sub() {
        for (let i = 65; i < 70; i++) {
          yield String.fromCharCode(i);
        }
      }
      function* main() {
        yield 'begin';
        yield sub();
        yield '---------';
        yield* sub();
        yield 'end';
        return 'main end';
      }

      for (const i of main()) {
        console.log(i);
      }
```



![](https://static.1991421.cn/2021/2021-01-22-164934.jpeg)



控制台打印可以看出

1. yield与yield*`不同`
2. yield返回的sub迭代器，而yield*是sub迭代器中的每个yield元素



我是这么理解*是通配，即所有，yield\*将表达式中的每个项都委托了出去，而yield是整体委托。

另外，注意到上述main生成器函数是有返回值，但却没有打印，这是为什么呢？这是因为forof遍历无法获取返回值，假如改造下，即可正常获取。

```javascript
const res = main();
      let value = null;
      while (value !== undefined) {
        value = res.next().value;
        if (value !== undefined) {
          console.log(value);
        }
      }
```



![image-20210122170503864](/Users/qhe/Library/Application Support/typora-user-images/image-20210122170503864.png)

## Redux-Saga中使用场景

- 当前，在实际开发中，与生成器打交道最多的地方是Redux-Saga写effects时就要用到，从效果来说yield还是yield*效果一致

- 官网对于yield，yield*的使用diff说明很粗糙，只是告诉你不一样。。。。

  You can use the builtin `yield*` operator to compose multiple Sagas in a sequential way. This allows you to sequence your *macro-tasks* in a procedural style.

  你可以使用内置的 `yield*` 操作符来组合多个 Sagas，使得它们保持顺序。 这让你可以一种简单的程序风格来排列你的 *宏观任务（macro-tasks）*。
  
  

### 个人理解

- saga中我们编排的这些副作用处理大多是异步【宏任务】，异步即有顺序存在
  - 如果我们需要确保A effects所有的异步【包括A调用B effects，B中的异步】都按照既定的顺序进行执行，那么就要使用yield*，如果A effects中只有一个B effects，那么yield，还是yield\* 结果均相同

### 举个例子



## 与Promise

promise的出现是为了解决异步编程-callback方案带来的回调地狱。



## 迭代器与生成器

1. 





## 写在最后



## 参考

- https://segmentfault.com/q/1010000006657002
- https://stackoverflow.com/questions/47533738/when-should-i-use-yield-vs-yield-in-redux-saga
- https://redux-saga.js.org/docs/advanced/SequencingSagas.html

