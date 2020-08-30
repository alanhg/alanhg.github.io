---
title: GitLab使用中的一些实践技巧
tags:
  - GitLab
  - VCS
abbrlink: 362a1c94
date: 2020-08-21 22:07:29
---
> 公司代码管理一直使用GitLab,在实际的使用中也有一些大大小小的使用技巧，实践，这里记录下。

![](https://static.1991421.cn/2020/2020-08-21-222322.jpeg)

## GitLab-丰富的API
善用这些API，可以做到很多事情，比如利用API+pipeline本身可以建立自动Merge Request。


比如我们利用Jenkins定时跑Changelog提交到仓库靠的也是GitLab API


[API介绍](https://docs.gitlab.com/ee/api/)，当然具体要确定你的安装版本

## Pipeline
GitLab 提供了CI+CD，当然Jenkins本身也是个CD化工具，当前Team的实践是GitLab只做为CI，跑UT，各个环境的CD部署，是利用Hook唤起Jenkins执行

注意，CI，CD的配置文件本身有指令支持，所以你可以在多个项目之间共享配置代码块。

## Template
对于MR，Issue等我们可以创建一些模版，比如我的团队，Merge Owner采用的轮流制，但是记忆今天是谁这件事是很无聊的，因此我们做了模版，这样每次，通过MR时候查看这个MR Guide
就知道今天是谁。


## Commit语法糖
开启Pipeline确实还是很爽的，确保了Merge代码的安全，但是假如有时我就是不想走Pipeline直接合并呢，OK，GitLab提供了语法糖`[skip ci]`,但一般情况请勿使用。

当然除此之外还有`Fixes #45`等


