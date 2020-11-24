---
title: 基于Surge Mac 4.0，我开发了Workflow
tags:
  - Surge
  - 网络调试
  - Alfred
  - Workflow
abbrlink: a12a6619
date: 2020-11-16 23:58:29
---
> 对Surge的使用一直有个痛点，就是比如我想切换系统代理开关状态，或者出站规则，我需要光标移动到右上角，点击，再点击，整个操作流程一点也不高效。之前曾考虑过Apple Script操作GUI来解决问题，但是编写较麻烦。
> 
> 最近刷推发现Surge Mac4.0发版了，并且提供了HTTP API支持，对于我这样一个Alfred爱好者，我看到了自动化的希望。于是快速入手，花了半小时，便实现了workflow。

![](https://static.1991421.cn/2020/2020-11-17-000725.jpeg)

## 资费

Surge Mac4.0，我这次没用之前的号升级license，而是选择全新购买了`单设备license 39.99刀，八折活动截止11月20日`

资费详情，请戳[官网](https://nssurge.com/)

## 实现基础
1. Surge Mac 4.0.0、Surge iOS 4.4.0开始提供HTTP API，[API详情戳这里](https://manual.nssurge.com/others/http-api.html)
2. Alfred Workflow，支持各种脚本语言操作，这里我使用nodejs来实现

## 实现细节

1. Surge开启HTTP API

 ```yml
 http-api = examplekey@0.0.0.0:6171
 ```
2. 利用JS请求API

## 效果

![](https://static.1991421.cn/2020/2020-11-17-000148.gif)

workflow下载地址-[戳这里](https://github.com/alanhg/alfred-workflows/blob/master/surge/Surge.alfredworkflow)

- 我想说妈妈再也不用担心我操作Surge抵消了，对于IT人来说，键盘一顿操作才是王道，才是高效。
- 据官方作者所说，后期还会开放更多API，期待ing


## 当前的不足

1. 因为API提供的还不够全面，比如没有获取所有Profile的API，所以灵活切换也就没办法实现
2. 当前workflow的安装需要自己手动安装yarn,及node_modules包，不方便装机，接下来封装成node包，实现一键安装方便些。

## 写在最后

如上实现后，即可高效切换Surge的功能模式了，perfect！
