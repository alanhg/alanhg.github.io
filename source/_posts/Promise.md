---
title: JS下的Promise
tags:
  - JavaScript
  - 异步编程
abbrlink: fd66732e
date: 2021-03-07 13:33:57
---

> 很多教程把Promise搞的过于简单或复杂，这里梳理下，强化下个人理解。

![](https://static.1991421.cn/2021/2021-03-07-151758.jpeg)

## Promise产生的原因

promise是异步编程范畴内为了解决回调地狱的产物。

```
A.then(B).then(C)
```

这种写法相对回调明显是好些的。

## Promise使用注意

1. Promise有三种状态`pending`，`fulfilled`，`rejected`

2. Promise.then产生的任务是微任务，需要知道`微任务的执行优先级是高于宏任务`

   - 微任务即微观任务，宏任务即宏观任务，如果是宿主环境发起的比如window.setTimeout，JS事件均是宏观任务，但比如JS自己发起的比如promise，即是微观任务

   - 根据JS事件循环，消息队列的原理，当一个宏观任务执行结束后，还需要去看下该宏观任务包含的微观任务是否还有未执行的，如果没执行就继续执行，如果都执行完了，才继续下一个宏观任务。

## 手写Promise

这里实现个简易版的Promise

```javascript

 function Bromise(executor) {
        var onResolve_ = null;
        var onReject_ = null;
        this.then = function (onResolve, onReject) {
          onResolve_ = onResolve;
        };
        function resolve(value) {
          window.setTimeout(() => {
            onResolve_(value);
          }, 0);
        }
        executor(resolve, null);
      }

      function executor(resolve, reject) {
        resolve(100);
      }

      var demo = new Bromise(executor);
      function onResolve(value) {
        console.log(value);
      }
      demo.then(onResolve);
```

## Async/Await

聊到Promise，就接着聊聊Async/Await，Promise虽然解决了回调地狱，但书写起来还是不够简单，于是就有了Async/Await，它们出现后，异步代码将可以同步方式进行书写，使得代码的可读性更高，更符合人的线性思维。

async/await 的基础技术使用了生成器和 Promise，生成器是协程的实现，利用生成器能实现生成器函数的暂停和恢复。

## 事件循环/消息队列

JS是单线程模型，也就是单一时刻只能执行一件事情，当然我们有时候会看到比如Networks中能够同时处理多个请求，那是因为JS发起这批请求确实是按照顺序的，但发起后，网络进程并非只有一个线程，且Chrome本身是多进程模型，所以可以做到多个请求同时处理，这与JS单线程模型并不矛盾。

回归正题，单线程决定了单一时刻只能做一件事，那么每个时刻都做什么呢，如何保证所有的任务都可以执行呢，于是浏览器就有个事件循环，这里可以简单理解为一个while循环，然后浏览器维护了一个消息队列，消息队列里存储了一堆的任务，当然这些任务是宏任务，队列这种基本模型的特征是先进先出，于是浏览器的一个渲染进程中的主线程就一个个任务的执行，但是如果只按照这个单一的任务队列进行执行会有问题，比如有些异步操作需要及时性，那么就需要有个微任务的概念，即队列的总任务数还是这么多，但是单个宏任务需要临时加点活，于是也就有了微任务的概念。微任务的出现是考虑了部分操作的及时性。

当然消息队列并非只有一个，以上只是最普通的一个消息队列，除此之外还有延迟队列，当程序遇到了定时器函数，即会将定时器函数的回调时间，回调函数等信息放入延迟队列，当定时器到期时，将该回调函数作为一个宏任务推出推入到正常的消息队列中去。



## 举2个例子

基于以上的理论知识，来结合2个例子看

### Q1

```javascript
      async function foo() {
        console.log('foo');
      }

      async function bar() {
        console.log('bar start');
        await foo();

        console.log('bar end');
      }

      console.log('script start');

      setTimeout(function () {
        console.log('setTimeout');
      }, 0);

      bar();

      new Promise(function (resolve) {
        console.log('promise executor');
        resolve();
      }).then(function () {
        console.log('promise then');
      });

      console.log('script end');
```



执行过程分析如下

1. 首先执行console.log('script start');打印出script start
2. 遇到定时器，创建一个新任务，放在`延迟队列`
3. 接着执行bar函数，由于bar函数被async标记，所以进入该函数时，JS引擎会保存当前调用栈等信息，然后执行bar函数中的console.log('bar start');语句，打印出`bar start`
4. 接下来执行到bar函数中的await foo();语句，执行foo函数，也由于foo函数被async标记的，所以进入该函数时，JS引擎会保存当前调用栈等信息，然后执行foo函数中的console.log('foo');语句，打印foo。
5. 执行到await foo()时，会默认创建一个Promise对象
6. 在创建Promise对象过程中，调用了resolve()函数，且JS引擎将该任务交给当前宏任务下的微任务队列
7. 然后JS引擎会暂停当前协程的执行，将主线程的控制权交给父协程，同时将创建的Promise对象返回给父协程
8. 主线程的控制权交给父协程后，父协程就调用该Promise对象的then()方法监控该Promise对象的状态改变
9. 接下来继续父协程的流程，执行new Promise()，打印输出`promise executor`，其中调用了 resolve 函数，JS引擎将该任务添加到微任务队列队尾
10. 继续执行父协程上的流程，执行console.log('script end');，打印出来`script end`
11. 随后父协程将执行结束，在结束前，会进入微任务检查点，然后执行微任务队列，微任务队列中有两个微任务等待执行，先执行第一个微任务，触发第一个promise.then()中的回调函数，将主线程的控制权交给bar函数的协程，bar函数的协程激活后，继续执行后续语句，执行 console.log('bar end');，打印输出`bar end`
12. bar函数协程执行完成后，执行微任务队列中的第二个微任务，触发第二个promise.then()中的回调函数，该回调函数被激活后，执行console.log('promise then');，打印输出`promise then`
13. 执行完之后，将控制权归还给主线程，当前任务执行完毕，取出延迟队列中的任务，执行console.log('setTimeout');，打印输出`setTimeout`

## Q2

实现一个红绿灯，把一个圆形 div 按照绿色 3 秒，黄色 1 秒，红色 2 秒循环改变背景色

贴出个人的实现代码

```javascript
 var lightEl = document.getElementsByClassName('light')[0];

      function sleep(second) {
        return new Promise(function (resolve, reject) {
          window.setTimeout(function () {
            resolve();
          }, second * 1000);
        });
      }

      async function trafficLight() {
        lightEl.style.backgroundColor = 'green';
        await sleep(3);
        lightEl.style.backgroundColor = 'yellow';
        await sleep(1);
        lightEl.style.backgroundColor = 'red';
        await sleep(2);
      }

      async function main() {
        while (true) {
          await trafficLight();
        }
      }
      main();
```



关键点

1. 利用await暂停
2. 利用while循环实现循环执行



## 参考资料

- [浏览器工作原理与实践-李兵](https://time.geekbang.org/column/intro/216)
- [重学前端-winter](https://time.geekbang.org/column/intro/154)
- https://github.com/LuckyWinty/blog/blob/master/markdown/Q%26A/Chrome%E6%B5%8F%E8%A7%88%E5%99%A8setTimeout%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86%E5%92%8C%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F.md