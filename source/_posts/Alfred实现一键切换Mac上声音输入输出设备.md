---
title: Alfred实现一键切换Mac上声音输入输出设备
date: 2020-12-06 00:44:03
tags:
- Mac
- Alfred
- Workflow
---
>  随着围绕着Mac生态的外设越来越多，经常需要切换声音输入输出设备，GUI操作效率太低，于是借着周末时间，做个workflow来提升切换效率。


## 实现基础
调研了一番方案，最终选择了这个工具模块。

https://github.com/deweller/switchaudio-osx

### 当前的不足
当前不支持获取AirPlay类型的输出设备，目前看来作者没意向去增加支持，立个Flag，找时间研究解决下，提个PR。

## 当前效果


![](https://static.1991421.cn/2020/2020-12-06-004446.gif)

下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/switch-audio)

## 写在最后
程序员的高效，其中一个标志就是手不离开键盘，有了这个workflow加持，切换声音设备就不需要动用鼠标了，nice！