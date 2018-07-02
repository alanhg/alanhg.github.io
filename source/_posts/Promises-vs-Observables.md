---
title: 【译】Promises vs Observables
date: 2018-07-01 11:16:47
tags:
- RxJS
- Promise
---
> Observables持续在发展。Angular2将其作为缺省的异步处理方案。你可以用它们的中间件在你的React-Redux APP中。但是为什么，何时应该使用它们呢?这篇文章将深入解释两者之间的最大差异。理解了这些，可以帮助你决定在这两者之前如何选择。即使到了最后，你可能不选择Observables，但也衷心希望能够了解更多关于Promises的只是。

需要注意的是，这篇文章描述了Observables再RxJS下如何工作，如果是其它的响应式编程类库，可能会有不同。

假定你已经掌握了Promises的基础，另一方面，如果Observables对你是足够的新奇，那么这篇文章可以作为一个介绍。但不要止步于此，Observables还有很多知识。尤其，我们几乎没有提到操作符，在RxJS与响应式编程中，这些都大量使用。

## 单值 vs 多值
Promises被广泛用于处理HTTP请求。在这个模型了，你发起了一个请求，然后等待一个回复。你可以确定，同一个请求不会有多个回复。

```javascript
const numberPromise = new Promise((resolve) => {
    resolve(5);
});

numberPromise.then(value => console.log(value));
// will simply print 5
```
但用另一个值再次处理Promise将会失败。Promise总是处理首个resolve函数调用的值。忽视了之后的调用。
```javascript
const numberPromise = new Promise((resolve) => {
    resolve(5);
    resolve(10);
});

numberPromise.then(value => console.log(value));
// still prints only 5
```
与此相反，Observables允许你去处理(或者我们叫"emit")多值，看下面代码
```javascript
const numberObservable = new Observable((observer) => {
    observer.next(5);
    observer.next(10);
});

numberObservable.subscribe(value => console.log(value));
// prints 5 and 10
```
注意，语法熟悉吧，我们将Promise变成Observable,revolve改成observer.next,then改成subscribe，多么相似。

这个行为实际上也是Observables的最大卖点。当你考虑浏览器异步源的时候，你很快会想到单个请求-单个回复，这种模型能在单个请求下，或者setTimeout定时器下OK。但还有这些情况:
- setInterval
- webSockets
- DOM事件(鼠标click 等等)
- 任何其它种类事件，这个问题(也存在于Node.js)

尽管后来，我们再Promises上取得了一些进步，但我们仍然会继续使用魔鬼回调。没人意识到我们只是解决了部分问题吗?谢谢RxJS作者所做的。
让我们看下，如何用Observable包裹setInterval.
```javascript
const secondsObservable = new Observable((observer) => {       
    let i = 0;
    setInterval(() => {
        observer.next(i++);
    }, 1000);
});

secondsObservable.subscribe(value => console.log(value));
// logs:
// 0
// 1
// 2
// and so on, every second
```
为了不触发匿名的undefined值，我们初始化了计数器`i`,然后每秒，我们执行下`observer.next`来传递i值。

这是一个Observable的例子，实际上它从来没停止触发值，所以你不是得到了promise的单值，而是你得到了一个输入，这个输入可能是任何数字值。

## 好奇 vs 懒惰
让我们假设，Promises支持触发多值，我们用Promise来重写`setInterval`这个例子。
```javascript
const secondsPromise = new Promise((resolve) => {       
    let i = 0;
    setInterval(() => {
        resolve(i++);
    }, 1000);
});
```
我们这里有个问题，即使没有人去监听这些数值(我们甚至都没去记录它)，`setInterval`仍然在Promise创建时立即被调用。我们浪费了资源，触发了这些值，因为根本没人去监听这些。发生这种情况的原因是

