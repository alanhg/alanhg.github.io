---
title: Git团队开发流程规范-MR冲突
abbrlink: 814ab47c
date: 2020-02-27 19:06:54
tags:
- Git
- Gitflow

---
> 最近Team前端在合并代码中，出现了多次的代码丢失问题，于是，开始基于这个现象分析，最后制定了冲突处理流程

## 冲突处理流程

![](https://i.imgur.com/Wso19as.png)

__举个栗子__

feat/xxx=>sprint出现了冲突。

1. 基于新建冲突处理分支 `resolve-conflict`名字表明是处理冲突，便于以后追溯即可，`feat/xxx`MR指向 `resolve-conflict`
2. 冲突代码相关人一块处理冲突
3. `resolve-conflict`分支MR到`sprint`,delete`resolve-conflict`


## 原则

MR其实 不是很紧急的，都应该集中去做，同时冲突的 就相关人都一块看下，处理下，避免代码丢失。

## 为什么这么做
1. 本地处理冲突，对于保护分支，不希望存在push，新建分支可以绕开这个问题
2. 直接在sprint处理了冲突，但存在提交时拉取到新的节点冲突，进而又需要再处理一次，而整个git历史线会很难看懂，不便于后期追溯问题

