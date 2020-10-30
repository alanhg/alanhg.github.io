---
title: JS题-修改代码不造成死循环
date: 2020-10-29 21:30:43
tags:
- 每日一题
- JavaScript
---
如下为一道前端试题，要求是`修改代码不造成死循环`。

```javascript
while (1) {
  console.log(Math.random());
}
```

## 分析

首先要知道

- JS是`单线程`
- JS不存在真正意义的`并行`，但存在`并发`

因此，如上循环如果正常执行必然死循环。如果想不死循环，不block，肯定是异步或者多线程

## 答案
根据分析的结果就好想到解决办法了。

### Web Worker

- Web Workfer是真正意义上的多线程，所以利用它就可以做到不阻止主线程
- IE逐步被Edge代替，而worker非IE浏览器下均得到完美支持，因此可以放开使用


```javascript
//main.js
const worker = new Worker('worker.js');
worker.onmessage = function (e) {
  // 接收worker传过来的数据
};

// worker.js
while (1) {
  const n = Math.random();
  console.log(n);
  if (n > 0.9) {
    postMessage(n);
    break;
  }
}

```

### Concurrent.Thread.js库

如果不使用web worker，可以使用该库来模拟多线程。原理即是利用异步。


```javascript
Concurrent.Thread.create(function () {
        while (1) {
          console.log(Math.random());
        }
      });
```

库链接-[戳这里](https://github.com/penghuwan/concurrent-thread.js)
