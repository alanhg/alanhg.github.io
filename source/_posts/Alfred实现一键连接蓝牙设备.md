---
title: Alfred实现一键连接蓝牙设备
tags:
  - Alfred
  - WorkFlow
abbrlink: 3d021756
date: 2020-06-01 22:45:35
---
> 个人是AirPods等无线设备的强烈支持者，很多年不曾使用过有线鼠标，耳机了。但日常使用存在这样一个场景，平时AirPods是连接的iPhone，但有时比如要开会，我需要快速连接到Mac上去。当前的操作是，滚动鼠标到屏幕右上角蓝牙图标=》点击蓝牙图标，选择AirPods=》选择连接。OK，操作繁琐，于是我想做个workflow来快速连接断开蓝牙设备吧。


## 当前效果


![](https://static.1991421.cn/2020/2020-06-01-225038.gif)


当你选中一个断开连接的设备，则设备就会连接，反之，则会断开。妈妈再也不用繁琐的操作蓝牙连接了。


下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/bluetooth-manager)

## 使用注意

1. 配对还是需要自己手动在系统蓝牙面板中操作，这里只列出配对的蓝牙设备 
2. 选中一个蓝牙设备，回车即可连接或断开蓝牙设备
3.  __支持AirPods左右耳机电量显示__

## 实现基础

1. 第三方类库[`blueutil`](https://github.com/toy/blueutil)，本身workflow只是执行了该命令进行设备展示和连接而已。
2. `hammerspoon`读取系统蓝牙设备电量信息，用于AirPods电量显示，假如不需要电量信息展示，不安装即可，我做了容错处理。


## 当前的不足
- 为了确保及时显示蓝牙设备的电量信息，只能依赖了hammerspoon，毕竟Alfred本身是不具备访问系统信息能力的，都需要借助AppleScript，Shell，等。
- 局限在Alfred的Script Filter设计，我必须要确保显示设备前拿到最新的电量信息。所以设定了2个关键词，用户必须要多回车一次，这也是没办法的办法。
