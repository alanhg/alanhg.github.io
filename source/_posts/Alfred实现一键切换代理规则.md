---
title: Alfred实现一键切换Whistle代理规则
date: 2021-06-17 22:32:59
tags:
- Whistle
- Alfred
- Workflow
---

> 当前工作中经常使用Whistle代理来进行Web模块开发，因为环境不同，项目不同，经常需要切换代理Rule。采用网页GUI操作还是过于低效，于是决定做个workflow来提升切换效率。

## 效果



![](https://static.1991421.cn/2021/2021-06-17-223531.gif)



### 操作指南

- ⌥ ⏎ 访问WEB管理页面
- ⏎ 切换rule选择状态
- ⌘ C拷贝当前Rule具体配置项
- ⌘ Y或者⌘ L进行Rule预览



Workflow下载地址，[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/whistle)

##  实现细节

这里贴下实现的关键点

1. 为了实现⇧进行预览，我将规则本地文件化，因为quicklook必须指向HTTP网络文件URL或者本地资源URI。因为整体速度很快，所以用户无感。不过相比较⇧，我更喜欢⌘L进行放大预览，效果更赞
2. Workflow本质只是换了个方式调用API，只要whistle关键规则获取及规则选中/反选API通过GUI请求捕获找到即可。



## 写在最后

实现较为简单，但是着实提高了平时开发效率，nice。
