---
title: Axios全局异常拦截与个性化异常处理
abbrlink: 4936274f
date: 2019-12-29 14:50:20
tags:
- Axios
- Redux-Saga
---
> 当前项目中部分通用异常比如500，400希望全局统一处理，而部分的请求异常比如400，又希望具体的功能块个性化处理。这样就存在冲突，于是开始了解决之路

![](https://static.1991421.cn/2019-12-29-064701.jpg)

## 部分技术栈
### 背景
> 全局使用了Axios拦截器来实现，具体的请求代码，我们一般是在saga中进行的处理，所以个性化异常也会在这里。

- Redux-Saga
- Axios

## 当前的方案

### Axios

```javascript
import axios from 'axios';

const onResponseSuccess = response => {
  return response;
};
const onResponseError = err => {
  const status = err.status || err.response.status;
  if (status === 403 || status === 401) {
    alert('no auth');
  }

  if (status >= 500 || status === 400) {
    console.error('[axios-global]invalid request');
  }
  return Window.Promise.reject(err);
};

axios.interceptors.response.use(onResponseSuccess, onResponseError);

```

### Saga-effects

```javascript
function* testExceptionEffects() {
  try {
    yield call(getBadRequest);
  } catch (e) {
    console.error('saga exception');
  }
}
```
### 存在问题

假如`getBadRequest `返回400，两个地方都会做异常处理，axios拦截器和saga中均会处理。并且，执行顺序会是axios全局拦截器=>saga

#### 异常信息

![](https://static.1991421.cn/2019-12-28-111333.png)

## 期望
假如一刀切全局不处理400，那么就会导致每个地方都需要个性化自己处理，这样并不是我的目的。我希望全局依然可以对于400等通用异常进行处理，但部分请求也具备可以个性化处理的能力，

## 解决
axios的拦截器到saga进行异常捕捉，这个执行顺序一定是不可修改的，所以能做的就是在axios上增加个性化配置项，进而来区分个性化与通用异常处理策略。

### Axios

```javascript
const onResponseError = err => {
  const config = err.config; // axios config
  const status = err.status || err.response.status;
  if (status === 403 || status === 401) {
    alert('no auth');
  }

  if (status >= 500) {
    console.error('[axios-global]server error');
  }
  if (status === 400 && (config.errorHandle === undefined || config.errorHandle === false)) {
    console.error('[axios-global]bad request');
  }
  return Window.Promise.reject(err);
};
```

### API

```javascript
export const getBadRequest = () => axios.get('http://mock-api.com/wz2wL5gL.mock/test/bad-request', {
  errorHandle: true
});
```

###  效果
假如我们设定了`errorHandle=true`,则拦截器不会对该400错误进行处理，直接抛出，saga中紧接着进行个性化处理，所以不会出现如上的冲突处理。

![](https://static.1991421.cn/2019-12-29-064305.png)

这样假如还是想走全局400异常的请求，我们不加这个配置，同时不需要在做个性化的异常处理即可。

## 写在最后
1. 方案本身较简单，但解决了特定的业务场景下希望个性化处理异常的需求。与直接一刀切，全部个性化处理相比，这样更显灵活。
2. 这里描述的是saga中的异常处理，但也适用于组件中异常处理，道理一样。
