---
title: Alfred实现一键连接蓝牙设备
date: 2020-06-01 22:45:35
tags:
- Alfred
- WorkFlow
---
> 个人是AirPods等无线设备的强烈支持者，很多年不曾使用过有线鼠标，耳机了。但日常使用存在这样一个场景，平时AirPods是连接的iPhone，但有时比如要开会，我需要快速连接到Mac上去。当前的操作是，滚动鼠标到屏幕右上角蓝牙图标=》点击蓝牙图标，选择AirPods=》选择连接。OK，操作繁琐，于是我想做个workflow来快速连接断开蓝牙设备吧。


## 当前效果


![](http://static.1991421.cn/2020/2020-06-01-225038.gif)


当你选中一个断开连接的设备，则设备就会连接，反之，则会断开。妈妈再也不用繁琐的操作蓝牙连接了。



下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/bluetooth-manager)

## 使用注意

1. 配对还是需要自己手动在系统蓝牙面板中操作，这里只列出配对的蓝牙设备 
2. 选中一个蓝牙设备，回车即可连接或断开蓝牙设备

## 如何实现的呢

这里不再详细去说，因为也无话可说。主要借助的是第三方类库[`blueutil`](https://github.com/toy/blueutil)，本身workflow只是执行了该命令进行设备展示和连接而已。


##  当前的不足

留心的同学会注意到，Apple自己的设备，或者部分第三方的蓝牙设备在系统蓝牙popup中是显示电量的，那么workflow中可以做到吗？

经过一番调研，发现可以做到。大致的思路是`/Library/Preferences/com.apple.Bluetooth.plist`中会存储蓝牙连接设备的ID，电量等信息，所以有戏。上面提到的`blueutil`并不支持该功能。

so,最近有空就会实现下。
