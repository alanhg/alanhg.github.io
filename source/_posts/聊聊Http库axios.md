---
title: 聊聊Http库Axios
abbrlink: 4106e01e
date: 2019-12-14 12:55:04
tags:
- XMLHttpRequest
- HTTP
- JavaScript
- Axios
---

>  项目前端技术栈对于Http请求这块经常使用Axios类库，在使用中也会遇到一些细节问题，这里就简单聊聊


![](http://static.1991421.cn/2019-12-14-045615.jpg)

## Axios的定位

个人学习一个技术特别喜欢了解它的背景及使命【定位】，这样能够了解它的天花板【能做什么不能做什么】。Axios说白了只是二次封装了浏览器的XMLHttpRequests及Node的Request，提供了更为便捷的HTTP使用方式，仅此而已
了解了背景，来说几个常见的问题

### Axios官方介绍

Promise based HTTP client for the browser and node.js


## 几个问题

### 什么状态码会抛异常
   查看Axios源码会发现，`200<=status<300`为正常，其它均会抛错.

   ![](http://static.1991421.cn/2019-12-15-084119.png)

   ![](http://static.1991421.cn/2019-12-15-084249.png)

   注意，100段，我们平时不会使用,300段的重定向，浏览器会解析新的资源地址继续请求，如果是200即为正常，400，500会抛错误。所以对于请求我们捕捉异常，实际上只会捕获到400和500段的。

#### XHR的onerror
   上面说到了Axios只是基于XHR的二次包装，那这里看一下XHR的API,注意到XHR有onload和onError属性，那假如API返回了500，会触发onerror?

   大错特错，`onerror只会在网络层异常时触发该事件，比如网络突然断了，假如应用层级别的400，500还是会进入onload，也就是说axios的异常处理的时应用层的，而xhr的异常处理的是网络层。`

  ![](http://static.1991421.cn/2019-12-15-095018.png)

### 接口返回301，页面会跳转吗？
   `不会`，页面跳转即整个页面会刷新，而XHR技术的到来是为了解决交互数据的同时无需让整个页面刷新，所以异步返回301, 浏览器会继续请求新地址资源，但因为是异步，所以只是拿到了返回结果，但整个页面所以不会刷新。

### 数组参数传递

    这个实现方式很多元，其中一种办法是这么做

   ```javascript
   axios.defaults.paramsSerializer = params => {
    return qs.stringify(params, { arrayFormat: 'repeat' });
    };
   ```

   请求URL会是如此`https://bugs.chromium.org/p/chromium/issues/detail?id=1&id=2&id=3`

   注意，URL的key是允许重复的

## 写在最后

讨论的问题很简单，也很基础，但值得总结于学习。
