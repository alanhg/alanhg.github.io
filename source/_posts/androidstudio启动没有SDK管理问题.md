---
title: androidstudio启动没有SDK管理问题
date: 2017-07-30 20:12:40
tags:
- ide
- android
- 环境配置
---

## 问题
虽然搞得是混合开发，但是最终打包安卓应用的话还是需要安卓环境的，安卓SDK可以单独下载配置，但是利用AndroidStudio进行管理配置更为方便，但是当我启动软件，发现没有SDK配置选项。

![fail](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-30-121637.jpg)

查看官网介绍，发现理论上应该是下图的界面
![official](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-30-121910.jpg)

## 解决
搜了半天，终于找到解决方案，进入插件管理
`Configuration > Plugin > Android Support Plugin`,该插件处于enable状态，点击OK，重启IDE即可
![successful](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-30-121403.jpg)

## 分析

AndroidStudio是Jetbrains公司在idea基础上开发出来的，idea是java开发，而安卓是在java之上，所以这里是以插件形式做到了安卓支持，也就是AndroidStudio完全可以不做安卓开发也没问题。
