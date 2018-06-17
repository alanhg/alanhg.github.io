---
title: ionicv4介绍
abbrlink: 48764c9e
date: 2017-05-06 23:37:41
tags:
- ionic
- hybrid
- app
---
## 还有ionicv4？

ionic官方仓库已经创建了v4分支，也给出了v4的介绍及愿景，这里我翻一下，想看原文[点击这里](https://github.com/driftyco/ionic/blob/v4/README.md)

## 翻译

ionic组件向着以下目标发展
+ 用户继续用angular组件开发APP和组件
+ 开发和构建不会有变化
+ 用户使用上的改变将会最小化
+ 减少构建时间
+ 减少启动时间
+ ionic组件的异步加载将会成为缺省配置

对于大多数部分，`ionic-angular`将会按照同样的方式继续工作，想之前的版本一样使用所有的API，然而少量复杂的组件比如`ion-badge`,将会使用标准的web组件规范V1，这些规范在主流浏览器中已经实现且运行，
除此之外，对于那些不支持web组件的浏览器，`polyfills`将会按需添加，这点已经在v4项目中实现。

我们将会继续开发维护v3主干分支，根本上来说，v3与v4的差异性是内在的，外在来说，v3，v4等同。

### 变化

### @NgModule Updates

What's great is that Angular already supports and works with web components! In order to enable them simply add CUSTOM_ELEMENTS_SCHEMA to the schemas property of @NgModule, such as:

import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';

@NgModule({
  ...
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule {}
### ion-label Required

Previously an ion-label would automatically get added to ion-item if one wasn't provided. Now an ion-label must always be added if the item is used to display text.

  <ion-item>
    <ion-label>Item's Text!</ion-label>
  </ion-item>


## 未来的目标
ionic集成web组件标准，我们的目标之一是让ionic组件能够轻易的在所有主流的框架中运行。