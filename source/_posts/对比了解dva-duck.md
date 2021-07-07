---
title: '对比了解dva,duck'
date: 2021-06-27 16:52:05
tags:
- 
---

> 公司项目比较多，有些用到了`saga-duck`，有些用到了`DvaJS`，两者什么区别呢，这里就学习总结下。



## 概述

## saga-duck/duck



- Duck

  > A proposal for bundling reducers, action types and actions when using Redux

- saga-duck/duck

  > extensible and composable duck for redux-saga



可以看出duck这种模式是规定actionTyps，actions，reducers在一个独立文件夹下，saga-duck解决的是围绕redux的数据流转，采用的设计模式是即duck。



## DvaJS

> React and redux based, lightweight and elm-style framework.
>
> dva 首先是一个基于 redux 和 redux-saga 的数据流方案，然后为了简化开发体验，dva 还额外内置了 react-router 和 fetch，所以也可以理解为一个轻量级的应用框架。



可以看出dva主要解决的也是围绕redux的数据流转，同时补充了react-router，fetch，因此比saga-duck就更为丰富了些。但主责一致即数据流转。因为View层还是react。



## 源码



## 相关文档

- [dva 介绍](https://github.com/dvajs/dva/issues/1)
- [一文彻底搞懂 DvaJS 原理](https://github.com/venaissance/myBlog/issues/20)

