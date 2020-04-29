---
title: Mac下拷贝文件路径
date: 2020-04-29 21:04:02
tags:
- Mac
- Automator
---
> 有这样一个需求，我希望在finder中快速拷贝选中的文件或者文件夹路径。

## 不怎么满意的方法
1. 当然有第三方的APP比如`Easy New File`可以，但是为了一点需求，而安装一个臃肿的APP，实在不愿意
2. Alfred解决也可以，选中文件，或者文件夹，一个热键触发，搞定路径。但Alfred是无法拓展右键菜单的，我需要记忆一个快捷键。

那么有没有办法可以自定义右键菜单，提供一个拷贝路径的操作呢。YES-Automator

## Automator介绍

> Automator是苹果公司为他们的Mac OS X系统开发的一款软件。只要通过点击拖拽鼠标等操作就可以将一系列动作组合成一个工作流程，从而帮助你自动的（可重复的）完成一些复杂的工作。Automator还能横跨很多不同种类的程序，包括：访达（Finder）、Safari网络浏览器、iCal、地址簿或者其他的一些程序。它还能和一些第三方的程序一起工作，如微软的Office、Adobe公司的Photoshop或者Pixelmator等。

初步了解后，我们就可以知道它的能力上限，和能力范围。


### Alfred的不足

Automator是可以节省很多重复操作，Alfred也类似，但是Alfred有先天的一些不足。

1. `定时任务不支持`，这点也与这款产品的设计理念有关。Alfred的唤起无非是关键词，或者快捷键，这些都是主动触发的
2. `不支持自定义菜单`

以上2点，Automator却可以，不得不说真香。

## 制作Workflow
知道了它能做什么，那就开搞。这里就不详细介绍了，因为官网写的很明白。[戳这里](https://support.apple.com/zh-mo/guide/automator/welcome/mac)


## 当前效果
选中文件夹或者文件，右键-service中即可看到自定义的菜单项-Copy Path，完美

![](http://static.1991421.cn/2020/2020-04-29-212749.png)

这里贴出我做的，[戳这里](https://github.com/alanhg/mac-automator),下载安装即可使用

## 写在最后

看似一小步，但类似的需求就知道了实现手段，所以值了。
