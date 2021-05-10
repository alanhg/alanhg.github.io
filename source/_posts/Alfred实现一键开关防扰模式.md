---
title: Alfred实现一键开关防扰模式
date: 2021-04-23 23:46:03
tags:
- Alfred
- Workflow
---

> 好久没更新过Alfred Workflow相关文章了，这里就贴下最近的一个小开发。



工作中为了聚焦码字，我经常开启Mac的防扰模式，这样不会被微信/或QQ等高频信息轰炸，但比如下班又需要关闭。鼠标移动到右侧去关闭显得低效，设置热键开关又需要记忆一组较为复杂的，这两种方式都很不程序员，于是，我决定做个workflow来快速开关。



## 效果

输入disturb,回车即可开关

![](https://static.1991421.cn/2021/2021-04-23-235021.gif)

Workflow下载地址，[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/do-not-disturb)

## 实现细节

网上查找半天，发现AppleScript/Shell都没有很好的口子支持，最终发现了这个包[@sindresorhus/do-not-disturb](https://github.com/sindresorhus/do-not-disturb)，于是简单几句代码调用即可实现。

翻了下源码，底层是swift实现的，对外只是JS形式调用其执行。

## 写在最后

如此一来，不离开键盘即可完成切换，nice。

