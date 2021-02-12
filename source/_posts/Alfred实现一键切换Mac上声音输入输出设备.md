---
title: Alfred实现一键切换Mac上声音输入输出设备
tags:
  - Mac
  - Alfred
  - Workflow
  - Sound
  - Mic
abbrlink: 986bb3dc
date: 2020-12-06 00:44:03
---
>  随着围绕着Mac生态的外设越来越多，经常需要切换声音输入输出设备，GUI操作效率太低，于是借着周末时间，做个workflow来提升切换效率。


## 实现基础
调研了一番方案， 发现选择不多



- 命令行模块有个方案是[switchaudio-osx](https://github.com/deweller/switchaudio-osx)，但不支持AirPlay，作者也不打算支持，改造的话需要C语言开发基础，为此放弃
- AppleScript+Shell，好处是环境Mac内置，无依赖，直接安装运行即可

最终选择了方案2，为此系统学习了下AppleScript，总算搞定，花费也就几个小时。

## 当前效果


![](https://static.1991421.cn/2020/2020-12-06-004446.gif)

下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/switch-audio)

## 写在最后
程序员的高效，其中一个标志就是手不离开键盘，有了这个workflow加持，切换声音设备就不需要动用鼠标了，nice！