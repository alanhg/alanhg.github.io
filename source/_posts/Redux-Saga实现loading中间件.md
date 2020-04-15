---
title: Redux Saga实现loading中间件
date: 2020-04-15 23:34:00
tags:
- Redux-Saga
---
> 当前项目中很多处理耗时较长，单个API请求我们可以加拦截器做到loading的开启和关闭，但是假如是一个effects中包含了多个请求，同时夹杂了一些其它的逻辑，那么单纯靠API层的loading控制是不行的，并且还会出现抖动开关。so，我们需要做到saga-effects这层的loading控制。


## 目标效果
当发起一个saga监听的action时，loading遮罩开启，当effects执行结束时，关闭。

## 实现

```typescript

import { call, put } from 'redux-saga/effects';
import * as is from '@redux-saga/is';


const LOADING_BLACKLIST = [UserActionTypes.GET_USERS];

function isForkEffect(eff) {
  return is.effect(eff) && eff.type === 'FORK';
}

function loading(sagaFn) {
  return function* (action) {
    function* loadingWrapper() {
      yield put(loadingStatusAction(true));
      yield call(sagaFn, action);
      yield put(loadingStatusAction(false));
    }

    if (LOADING_BLACKLIST.includes(action.type)) {
      return yield call(sagaFn, action);
    } else {
      // @ts-ignore
      return yield call(loadingWrapper, action);
    }
  };
}

const effectMiddleware = next => eff => {
  if (isForkEffect(eff)) {
    eff.payload.args[1] = safe(eff.payload.args[1]);
    eff.payload.args[1] = loading(eff.payload.args[1]); // loading
  }
  return next(eff);
};

export const sagaMiddleware = createSagaMiddleware({
  effectMiddlewares: [effectMiddleware],
  onError: sagaEffectUnhandled
});
```

## 大致说明
1. loading是个高阶函数，在sagaFn执行前后，分别加入loading的开启和关闭。
2. sagaFn是个生成器函数，这里包装完还是个生成器函数


## 写在最后

- 假如不利用中间件，就需要在很多地方重复的loading开启和关闭逻辑，违反了DRY原则。so，这么做还是有价值的。
