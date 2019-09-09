---
title: Redux-Saga中的异常处理
tags:
  - Redux
  - Redux-Saga
abbrlink: 6c2890d4
date: 2019-09-07 22:18:17
---
> `Redux-Saga`是一个用于管理应用程序 Side Effect（副作用，例如异步获取数据，访问浏览器缓存等）的 library，它的目标是让副作用管理更容易，执行更高效，测试更简单，在处理故障时更容易。
> 
> 不可避免的是，effects中可能会出现异常，比如一个call API请求，对于异常我们又该如何处理呢。这篇文章聚焦于将这点。
  
![](http://static.1991421.cn/2019-09-03-143949.png)
  
## 异常不处理的结果?

贴一个effects，连续`三次`call后端。

![](http://static.1991421.cn/2019-08-04-141523.jpg)

假如`第二次`请求即getBooks出错，还会打印step 2吗？

![](http://static.1991421.cn/2019-08-04-141608.jpg)

事实是不会，也就是请求异常，整个程序effects执行就会中断。

## 单个请求异常处理
在effects中对于异常，我们需要使用trycatch

![](http://static.1991421.cn/2019-08-11-041815.jpg)

![](http://static.1991421.cn/2019-08-11-041733.jpg)

如上，getBooks请求进行了异常捕捉，这样做就可以吞掉这个错误，进而可以正常执行接下来的请求了。


### 什么算异常？
对于一个后端请求，200，400，404，500都是常见response code，那么什么请求才会在异常中要捕获？

Demo中我使用的Axios，so这里要看它了。开启源码阅读，源码中有个validateStatus函数，具体实现如下。可以看出200到300之间的正常，其它的抛出异常，300段的浏览器在接收后都会自行重定向。就是说我们400，500的错误才会在catch中捕获。


```javascript
validateStatus: function validateStatus(status) {
    return status >= 200 && status < 300;
  }
```

```javascript
module.exports = function settle(resolve, reject, response) {
  var validateStatus = response.config.validateStatus;
  if (!validateStatus || validateStatus(response.status)) {
    resolve(response);
  } else {
    reject(createError(
      'Request failed with status code ' + response.status,
      response.config,
      null,
      response.request,
      response
    ));
  }
```

要看axios相关源码 [戳这里](https://github.com/axios/axios/blob/master/lib/defaults.js)


## 单个Effects异常处理
单个请求报错，effetcts也会挂掉，进而整个Saga树挂掉，整个App可能崩溃，那么为了确保WEB安全，我们需要让effects健壮些，so我们来做个wrapper。



```javascript
import { call } from 'redux-saga/effects';

export function safe(sagaFn) {
  return function* (action) {
    try {
      return yield call(sagaFn, action);
    } catch (e) {
      console.error('[react-demo | Saga Unhandled Exception] This error should be fixed or do some pre check in saga effects function.');
      console.error(e);
    }
  };
}

```

### effects上挂载wrapper

![](http://static.1991421.cn/2019-09-03-145341.png)

![](http://static.1991421.cn/2019-09-03-145306.png)

### 单个effects异常，整个saga都不会继续run

![](http://static.1991421.cn/2019-08-11-124904.jpg)

如上，我们增加saga 打印信息，在组件中，我们连续调用两次同一个action

![](http://static.1991421.cn/2019-08-11-125002.jpg)

查看日志，会发现其实，打印信息只有一个

![](http://static.1991421.cn/2019-08-11-125044.jpg)


### 造个捕捉异常轮子
很多时候，我们为了确保系统的健壮性，需要保证，单个effects执行出现故障后，不影响其它的执行，so，增加wrapper。

```javascript
import { call } from 'redux-saga/effects';

export function safe(sagaFn) {
  return function* (action) {
    try {
      return yield call(sagaFn, action);
    } catch (e) {
      console.error('[react-demo | Saga Unhandled Exception] This error should be fixed or do some pre check in saga effects function.');
      console.error(e);
    }
  };
}
```

然后在effects中调用

```javascript
function* mySaga() {
    yield takeEvery('USER_FETCH', fetchUserEffects);
    yield takeEvery('TEST_SAGA', safe(testSagaEffects));
    yield takeEvery('TEST_SAGA', testSagaEffects2);
}

```

#### 效果
即使第一个effects出现问题，并不会影响第二个的执行

![](http://static.1991421.cn/2019-09-03-150305.png)

## effects统一处理?

如上，对于单个effect增加safe函数，挺方便。但有没有一劳永逸的办法呢？毕竟safe很多的话，一眼望去不都是重复代码嘛！说好的[DRY](http://www.ruanyifeng.com/blog/2013/01/abstraction_principles.html)！

经过询问大神及查看Saga源码，找到了办法

```javascript
const effectMiddleware = next => effect => {
    if (effect.type === 'FORK') {
        effect.payload.args[1] = safe(effect.payload.args[1]);
    }
    return next(effect);
};

export const sagaMiddleware = createSagaMiddleware({
    effectMiddlewares: [effectMiddleware]
});
```

如上进行设定，对于单个effect就不需要加safe了，一劳永逸。

### 注意！
`effectMiddlewares`这个配置项是`1.0.0`引入的新特性，假如要用，就需要升级了。

1.0.0新特性查看，[戳这里](https://github.com/redux-saga/redux-saga/releases/tag/v1.0.0)

## 写在最后
1. 我们是可以增加safe确保报错不影响其它saga执行，但是想想，为什么会报错，异常就一定是不安全，而不报错就是安全了吗？我们容错的同时，其实是掩盖了问题，从而降低了应用的安全性，假如不加safe，我们利用程序解决了这个不该爆发的错误不是更好吗？这点值得我们想想。

2. 不论是saga还是其它类库，轮子虽好，但都有这样那样的问题，我们除了熟悉轮子解决我们的业务问题外，更多的是思考其背后的原理和适当造些更趁手的轮子吧。加油！

## 相关文档

- [redux-saga github](https://github.com/redux-saga/redux-saga)
- [HTTP Status Codes](https://restfulapi.net/http-status-codes/)
- [HTTP 请求和脱单过程很像，不信你看这个漫画](https://zhuanlan.zhihu.com/p/33821692)
- [axios github](https://github.com/axios/axios)

