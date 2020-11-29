---
title: Alfred实现一键Airdrop
tags:
  - Alfred
  - Workflow
  - 效率
abbrlink: 794cf6d9
date: 2020-11-29 10:26:10
---
> Airdrop算是Apple生态一个重要的体验了，便携的在各个设备之间传输文件，但是呢，离高效还差些，比如总是需要鼠标移动，点击share->airdrop，效率为王的时代，我还是选择自动化这个流程。

## 当前效果

选择文件或链接，唤起Airdrop进行分享

![](https://static.1991421.cn/2020/2020-11-29-102819.gif)


下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/airdrop)

## 使用注意
- 需要先终端下安装依赖工具库，执行`sudo gem install terminal-share`

## 实现基础

- AppleScript支持脚本化形式操作App，部分没有函数直接支持的App，可以自动化
	- 吐槽下[Apple Script](https://developer.apple.com/library/archive/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)官方文档过时且不友好
- Mac内置了共享工具函数，借助第三方[terminal-share](https://github.com/mattt/terminal-share)库实现脚本化


## 当前不足

airdrop share窗体没有置顶，造成有时候会觉得没唤起，其实在浏览器后面

## 写在最后
利用这个workflow又可以提升些许效率了，nice！
