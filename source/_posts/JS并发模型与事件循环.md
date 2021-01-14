---
title: JavaScript并发模型与事件循环
tags:
  - EventLoop
  - JavaScript
  - Concurrency
  - Task
  - Microtask
abbrlink: 8a863d27
date: 2020-09-26 16:31:03
---

> 最近看到一道基础题，沉痛打脸，发现对于JS的事件循环机制理解不扎实，于是梳理下，巩固基础。

## 基础题

先上原题

```js
console.log('start');
setTimeout(() => {
  console.log('children2');
  Promise.resolve().then(() => {
    console.log('children3');
  });
}, 0);

new Promise(function (resolve, reject) {
  console.log('children4');
  setTimeout(function () {
    console.log('children5');
    resolve('children6');
  }, 0);
}).then((res) => {
  console.log('children7');
  setTimeout(() => {
    console.log(res);
  }, 0);
});

```

### 正确答案
```
start
children4
children2
children3
children5
children7
children6
```
### 解析
- 宏任务打印`start `
- 定时器settimeout进入EventTable并注册，计时开始
- 遇到promise直接执行executor，打印`children4 `，遇到settimeout，进入EventTable，此时第一轮任务执行完毕
- 第一定时器先进入队列，取出任务执行，打印`children2`，promise.then加入微队列，执行打印`children3`
- 第二定时器开始执行，打印`children5 `，promise.then加入微队列，打印`children7 `
- 定时器到时见，添加到宏任务，取出任务，打印`children6 `

## 背后知识点

1. JS是单线程语言，事件循环是JS的执行机制，但其它语言与之有所不同，比如`Java本身就支持多线程`
2.  同步与异步任务分别进入不同的`执行场所`

	![](https://static.1991421.cn/2020/2020-09-26-193331.jpeg)
3. 异步任务又可以分为宏任务和微任务
 	
    举个例子，银行柜台员为每个客户办理业务，即是宏任务，但是客户可能突然需要增加办理任何一个业务，那么这些业务就可以看作是微任务
    
    每个宏任务内都维持了一个微任务堵截，为了让高优先级及任务及时执行。也即是每取出一个宏任务，执行完毕之后。检查当前宏任务是否有微任务可执行。

	![](https://static.1991421.cn/2020/2020-09-26-191836.jpeg)
4. 宏任务一般是：包括整体代码script，setTimeout，setInterval、setImmediate。
	
	微任务：原生Promise(有些实现的promise将then方法放到了宏任务中)、process.nextTick、Object.observe(已废弃)、 	MutationObserver
	
1. setTimeout即使设置的是0，并非理解执行回调函数。只有主线程执行栈内的任务全部执行完成，栈为空才从Event Queue中顺序取出执行。
2. Promise 对象用于表示一个异步操作的最终完成 (或失败), 及其结果值.
4. 事件循环的组成由主线程和任务队列，执行方式就是主线程不停从任务队列一个一个取出任务进行执行


## 测试题

搞清楚后，来两道题测试下

### 题1

_注意：nodejs下执行_

```js
console.log('1');

setTimeout(function() {
    console.log('2');
    process.nextTick(function() {
        console.log('3');
    })
    new Promise(function(resolve) {
        console.log('4');
        resolve();
    }).then(function() {
        console.log('5')
    })
})
process.nextTick(function() {
    console.log('6');
})
new Promise(function(resolve) {
    console.log('7');
    resolve();
}).then(function() {
    console.log('8')
})

setTimeout(function() {
    console.log('9');
    process.nextTick(function() {
        console.log('10');
    })
    new Promise(function(resolve) {
        console.log('11');
        resolve();
    }).then(function() {
        console.log('12')
    })
})

```
#### 正确答案

```
1
7
6
8
2
4
9
11
3
10
5
12

```

#### 解析
- 宏任务执行打印`1`
- 遇到定时器放入event table
- promise.nextTick微任务，暂不执行
- promise executor立即执行，打印`7`,.then微任务，暂不执行
- 遇到定时器放入event table
- 依次执行微任务,打印`6`,`8`
- 任务栈清空了，定时器时间也已经到了，从event queue中取回调函数，开始执行
- 打印`2`,`4`,nextTick,then均为微任务，暂时不执行
- 打印`9`，`11`，nextTick,then均为微任务，暂时不执行
- 宏任务执行完毕，开始执行微任务，打印`3`,`10`，`5`,`12`

### 题2
```js
console.log('script start');

setTimeout(function () {
  console.log('setTimeout');
}, 0);

Promise.resolve()
  .then(function () {
    console.log('promise1');
  })
  .then(function () {
    console.log('promise2');
  });

console.log('script end');
```

#### 正确答案

```
script start
script end
promise1
promise2
setTimeout
```

#### 解析
- 宏任务打印`script start`
- 定时器放入event table，开始计时
- promise.then是微任务，暂时先不执行，等待该任务队列宏任务执行结束
- 宏任务打印`script end `
- 宏任务执行完毕，查看微任务，依次打印`promise1 `,`promise1 `
-  微任务执行完毕，定时器到时，放入event queue,取出任务，开始执行，打印`setTimeout `

## 非阻塞？
搞清楚了JS的事件循环，并发模型，有必要再提下非阻塞。谈起nodejs，就经常会提起异步非阻塞。

要知道，异步非阻塞实际上是两个概念，`异步`，`非阻塞`，正如上面所说JS是单线程的，同一时间只能做一件事，因为设计之初的考虑，所以JS被定成了单线程。在此设计基础上，为了提高响应能力，就注定了异步的存在价值。同时，异步保证了不需要等待某些方法的执行结果可以继续执行其它的操作，所以才说非阻塞。

什么叫阻塞呢？比如浏览器端我们写上alert，如果用户不点击确认，根本不能进行其它任何操作，这就叫阻塞。


注意，异步非阻塞是JS的特性，浏览器端JS实际上也有。


## 写在最后
文章粗糙，如有问题，敬请斧正。

## 参考文档
- [Concurrency model and the event loop
](https://developer.mozilla.org/en-US/docs/Web/JavaScript/EventLoop)
- [JS事件循环机制（event loop）之宏任务/微任务
](https://juejin.im/post/6844903638238756878#heading-8)
- [微任务、宏任务与Event-Loop](https://juejin.im/post/6844903657264136200)
- [You don’t know JavaScript until you can beat this game](https://medium.com/javascript-in-plain-english/you-dont-know-javascript-until-you-can-beat-this-game-aa7fd58befb)
- [What the heck is the event loop anyway? | Philip Roberts | JSConf EU](https://www.youtube.com/watch?v=8aGhZQkoFbQ&feature=youtu.be&ab_channel=JSConf)