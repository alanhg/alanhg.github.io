---
title: 【译】Promises vs Observables
tags:
  - RxJS
  - Promise
  - JavaScript
abbrlink: a0e965b1
date: 2018-07-01 11:16:47
---
> 在做Angular2+项目开发中，对于异步处理，一直使用的RxJS,Angular与RxJS已经高度耦合，并且紧跟rxjs的脚步，在Angular6的时候，依赖的RxJS也已经升级到6。
诚然，开发中并非RxJS不可，Promise也行，但使用会发现RxJS会更为灵活，丰富和优雅。不过RxJS不好学，需要明白RxJS学习曲线异常陡峭，在<<深入浅出RxJS>>一书中更是被称之为悬崖。

![](http://or0g12e5e.bkt.clouddn.com/2018-07-02-035724.png)
配图来自此书。

如何了解和学习RXJS，我觉得横向对比Promise是一个重要的方法，最近看了篇好文章，兴许能帮助大家窥其一二。

------
原文链接:[Promises vs Observables](https://medium.com/@mpodlasin/promises-vs-observables-4c123c51fe13)

> Observables一直在发展。Angular2将其作为缺省的异步处理方案。你可以用它们的中间件在你的React-Redux APP中。但是为什么，何时应该使用它们呢?这篇文章将深入解释两者之间的最大差异。理解了这些，可以帮助你决定在这两者之前如何选择。即使到了最后，你可能不选择Observables，但也衷心希望能够了解更多关于Promises的知识。

需要注意的是，这篇文章描述了Observables在RxJS下如何工作，如果是其它的响应式编程类库，可能会有不同。

文章中假定你已经掌握了`Promises`的基础，另一方面，如果`Observables`对你是足够的新奇，那么这篇文章也可以作为一个介绍。但不要止步于此，Observables还有很多知识。尤其，我们几乎没有提到操作符，在RxJS与响应式编程中，这些都大量使用。

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

尽管后来，我们在Promises上取得了一些进步，但我们仍然会继续使用魔鬼回调。没人意识到我们只是解决了部分问题吗?谢谢RxJS作者所做的。
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

## 立即 vs 懒惰
让我们来假设，Promises支持emit(弹射)多值，我们用Promise来重写`setInterval`这个例子。
```javascript
const secondsPromise = new Promise((resolve) => {       
    let i = 0;
    setInterval(() => {
        resolve(i++);
    }, 1000);
});
```
我们这里有个问题，即使没有人去监听这些数值(我们甚至都没去记录它)，`setInterval`仍然在Promise创建时立即被调用。我们浪费了资源，触发了这些值，因为根本没人去监听这些。发生这种情况的原因是Promises是立即被调用的，你可以很简单测试出这点
```javascript
const promise = new Promise(() => {
    console.log('I was called!');
});
```
上述代码将立即打印出`"I was called"`到终端。相反，基于Observable的代码如下:
```javascript
const observable = new Observable(() => {
    console.log('I was called!');
});
```
这件事情没有发生。这是因为Promises是不懒，而Observables是懒惰。函数传递到Observable构造函数，但只有某人实际订阅到一个Observable，才能唤起。
```javascript
observable.subscribe();
// just now "I was called!" gets printed
```
这个似乎是一个小的变动，但我们回到Observable包装下的`setInterval`:
```javascript
const secondsObservable = new Observable((observer) => {       
    let i = 0;
    setInterval(() => {
        observer.next(i++);
    }, 1000);
});
```
因为懒惰，`setInterval`没有在这个时候唤起，甚至`i`变量都没初始化。函数传递到Observable仅仅是在等，直到有人真正订阅了这个Observable。

总结这点：初始化Promise代表着已经开启了这个进程(HTTP请求已经发出)，我们只是等着返回结果。这是因为Prmise被创建的那刻，函数就发布了这个请求。另一方面，初始化的Observable代表着可能发生的请求，但是只会在我们实际订阅才回触发，这样潜在的节省了浏览器的资源，因为有可能会做一些没人关心的工作。

## 不可取消 vs 可取消的
我们假设Promises是懒惰的。想象下在我们Promise的例子中，我们只有在有人监听这个结果的时候调用`setInterval`。但这时如果有人停止监听了呢？你可以能知道，setInterval返回令牌，这个可以被用于取消这个定时器。当消费者已不再希望监听这个事件的时候，我们能够这么做，因为当没人监听的时候，这些资源不能被浪费。

实际上，一些Promise类库支持这些。Bluebird Promises支持取消方法，你可以在一个Promise身上用，去停止里面发生的。让我们看下如何去做，从而取消掉这些。

```javascript
const secondsPromise = new Promise((resolve, reject, onCancel) => {
    let i = 0; 
    const token = setInterval(() => {
        resolve(i++);
    }, 1000);
    onCancel(() => clearInterval(token));
});
```

主要我们传递了`onCancel`函数，一个特殊的回调。当用户决定取消Promise时，可以被调用。取消操作基本就这样。
```javascript
const logSecondsPromise = 
    secondsPromise.then(value => console.log(value));
// we print values every second 
// (in our imaginary version of Promises), 
// but at some point user calls:
logSecondsPromise.cancel();
// from this moment numbers are no longer logged
```
注意，我们取消的承诺来自于then，副作用是值会打印到控制台。

我们看下Observable下如何去取消：
```javascript
const secondsObservable = new Observable((observer) => {
    let i = 0;
    const token = setInterval(() => {
        observer.next(i++);
    }, 1000);
    return () => clearInterval(token);
});
```
跟可以取消的promise相比，并没有改变很多东西相对传递函数到`onCancel`，我们只是返回了。
取消(或者，我们叫取消订阅)，Observables看起来类似。
```javascript
const subscription = 
    secondsObservable.subscribe(value => console.log(value));
subscription.unsubscribe();
```
看起来，subscribe不返回Observable！这意味着你不能像promise中的then一样，链路多个subscribe，subscribe只是返回给定Observable的一个订阅。这个订阅只有一个方法就是，取消订阅。你当你决定不再监听这个Observable的时候，取消订阅。

你如果担心缺少链式观察，使得Observable不能复用，请记得有一堆的操作符呢，操作符是支持链式。

另一方面，Subscribtion的冗长处理使你担心，有一些操作符能够让你优雅的处理这些。事实上，每个操作符都可以让你聪明的处理这些，确保你不会订阅不需要的事务。

说了一堆空话，我们继续。虽然有一些Promise类库支持取消，ES6的Promises是不支持的。有一个添加取消功能到Promise的提议，但被拒绝了。仍然有其它方法去取消Promise，但倘若你对比语言本身的话，你会发现Observable赢了，因为设计之初，就具备了取消。

## 多播 vs 单播或多播
然而还有另外一个问题，懒惰Promise，即使函数传到了构造函数中，也只会在有人hten的时候被调用。如果有人在几分钟后调用then。我们应该再调用这个函数，或者说分享之前的结果?

因为Promises是不懒的，他们自然实现了第二个方法-函数传递到Promise构造函数，置灰在Promise创建时调用。这个行为在HTTP请求时表现良好。考虑下面这个简单的例子，延迟1秒执行结果返回。
```javascript
const waitOneSecondPromise = new Promise((resolve) => {
    setTimeout(() => resolve(), 1000);
});
```
当然真正的Promise将立马开始计算，但如果它是懒惰的话，应该再用户实际要用的时候，再去计算。

```javascript
waitOneSecondPromise.then(doSomething);
```
doSomething将会在1秒等待后被调用。每件事都挺好，除非另一个用户也要使用同一个Promise:
```javascript
waitOneSecondPromise.then(doSomething);

// 500ms passes

waitOneSecondPromise.then(doSomethingElse);
```
用户自然希望doSomethingElse能够被调动也在1秒之后，但是半秒之后就会被调用。为什么?因为有人之前已经用过了，函数传递到了Promise构造函数就会被调用，因此setTimeout启动，1秒倒计时开始。当我们调用第二个函数的时候，时间已经过去一半。因为我们共享了计时器，所以他们同一时刻会被调用，并非过1秒后。
我们修改下Promise，记录一些东西。
```javascript
const waitOneSecondPromise = new Promise((resolve) => {
    console.log('I was called!');
    setTimeout(() => resolve(), 1000);
});
```
在之前的例子，即使then被第二次调用，你也只会看到一个"I was called!",这点就可以证明只有一个setTimeout定时器实例。

在一个特殊情况下，这点会更明显。如果一个Promise函数在每个用户调用时都分开调用`then`，`setTimeout`将被分别调用。确保他们的回调能够如期执行。事实上，Observable正式这么做的。我们来重写下：

```javascript
const waitOneSecondObservable = new Observable((observer) => {
    console.log('I was called');
  
    setTimeout(() => observer.next(), 1000);
});
```
我们每次`subscribe`都会开始自己的时钟。
```javascript
waitOneSecondObservable.subscribe(doSomething);

// 500 ms

waitOneSecondObservable.subscribe(doSomethingElse);
```
`doSomething`和`doSomethingElse`函数将都在被订阅一秒后执行。如果你看控制台的话，你将会看到打印了"I was called"两次。这个表明实际上函数传递进Observable构造函数两次，setTimeout定时器也被创建了2次。

然而值得一提的是，这并不总是你所希望的行为。HTTP请求是你希望之执行一次的，但是你希望将结果共享给很多的订阅者。Observables并不缺省如此，但是却可以支持你这么做，并且非常简单，你只需要使用`share`这个操作符即可。

假设之前的例子，我们希望同时调用`doSomething`和`doSomethingElse`，不管我们合适传递到subscribe，大致如下:
```javascript
const sharedWaitOneSecondObservable = 
    waitOneSecondObservable.share();

sharedWaitOneSecondObservable.subscribe(doSomething);

// 500 ms passes

sharedWaitOneSecondObservable.subscribe(doSomethingElse);
```
如果Observable在订阅者之前共享了结果，我们说这是“多播”，因为它将单个值传递给了多个实体，缺省Observable是单播，即每个结果只传递给单个且唯一的订阅者。

因此我们明白，Observable在灵活性上又战胜了：Promises（因为它立即，不懒惰的特性）总是"多播"，然而Observable缺省单播，却又可以在必要时很轻易的转变为多播。

## 总是异步 vs 可能异步
我们回过头来看这个十分简单的例子：
```javascript
const promise = new Promise((resolve) => {
    resolve(5);
});
```
注意，在一个函数里，我们同步resolve。因为我们已经获取了这个值，我们立即执行这个Promise,确定当用户调用了then,回调函数就可以理解同步处理这个？额，不是的，事实上，我们总是异步的，这里可以清楚看到这点：
```
promise.then(value => console.log(value + '!'));
console.log('And now we are here.');
```
首先“And now we are here.”被打印，然后才是“5！”，虽然Promise已经处理了那个数字。
Observable与此相反，实际上它会同步弹射这个值：
```javascript
const observable = new Observable((observer) => {
    observer.next(5);
});
observable.subscribe(value => console.log(value + '!'));
console.log('And now we are here.');
```
“5”会先出现，然后是“And now we are here.”. 当然我们能够延迟触发这个值，例如setTimeout包裹了“observer.next(5)”。所以我们了解了，Observable更为灵活。你可能觉得，这个行为是危险的，因为“subscribe”没有按照预期的结果工作，但是我说了，RxJS中有很多的办法来异步实现事件监听（有兴趣的话，看下`observeOn`这个操作符）。
## 结论
就到这里！如果你有其它好的例子来说明Promises与Observable的不同之处的话，请在评论中告诉我。相似性如何？
我希望这篇文章读完后，你具备了能在项目中选择使用哪种方案的能力。
提示：可能都行!

