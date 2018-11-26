---
title: Windows常用命令
tags:
  - bash
  - command
  - windows
abbrlink: 843f3569
date: 2017-09-12 09:35:51
---
![command-shot](//static.1991421.cn/blog/2017-12-07-135536.png)
> windows下的cmd对比Linux下的bash及OSX下的terminal都相差深远，但平时还是会用到，这里将常用命令记录下。

## 环境变量

+ 显示环境变量`NODE_ENV`

`$ set $NODE_ENV`

+ 设置环境变量`NODE_ENV`

`$ set NODE_ENV="production"`

***

## 网络操作
+ 查看端口占用情况
`$ netstat -ano`
+ 查看hiding端口的占用情况
`$ netstat -ano|findstr "3001"`
+ 查看PID对应的进程
`$ tasklist|findstr "22222"`
+ 结束该进程
`$ taskkill /f /t /im node.exe`
