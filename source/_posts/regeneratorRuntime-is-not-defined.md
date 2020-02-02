---
title: regeneratorRuntime is not defined
date: 2020-02-02 14:19:50
tags:
- TypeScript
---
> 今天前端在引入@adobe/redux-saga-promise包时，启动报这个错。于是开始了解决，这里记录下

![](https://i.imgur.com/jmQxpPr.png)

## regenerator-runtime是什么
> Source transformer enabling ECMAScript 6 generator functions in JavaScript-of-today

也就是说编译后的JS提供generator及async函数的支持。

官方介绍[戳这里](https://github.com/facebook/regenerator/tree/master/packages/regenerator-runtime)

## @adobe/redux-saga-promise包依赖分析
- 查看包依赖，在开发依赖中看到了`"regenerator-runtime": "^0.13.3"`,所以确实跟加入这个包有关
- `regenerator-runtime"`只在测试时需要

## TS编译设定

![](https://i.imgur.com/pSVfw6G.png)

项目中当前我的编译设定是`es6`，Generator及Async属于ES6的新特性，并且WEB本来就正常运行了redux-saga,要知道saga的effects就是使用的generator写法。但为什么加入`redux-saga-promise`就报这个错了呢？？？

看了下`redux-saga-promise`源码，发现包含了regeneratorRuntime的使用，结论就是该包是编译成了ES5，同时其实regeneratorRuntime是生产依赖，所以即使配置成ES6，但是为了支持该包，也需要引入regeneratorRuntime。

## 解决办法

### Webpack配置修改

```javascript
 new webpack.ProvidePlugin({
      'regeneratorRuntime': 'regenerator-runtime/runtime'
    })
```

### Jest配置修改
启动文件中配置，比如 enzyme-setup.ts

```typescript
import 'regenerator-runtime/runtime';

```

### 体积因此会大吗？
会，但影响很小，`A small runtime library (less than 1KB compressed)`

## 写在最后
遇到问题，冷静分析，敲定原因，解决也就简单了。
