---
title: Git快照是什么
date: 2020-12-20 15:22:32
tags:
- Git
- VCS
---

> Git越玩越喜欢，但有些底层的认识还不全面，比如快照是什么，这里Mark下。



## 快照记录

Git在每次commit时会对仓库中所有文件进行扫描，如果某文件发生变化，则会将新文件生成一个Blob文件，记录当前Commit时文件的所有内容，如果文件没有变化，则记录一个链接指向之前存储的文件。



![](https://static.1991421.cn/2020/2020-12-20-153213.jpeg)



## 快照存储

这些快照存储在哪呢，还是在.git隐藏文件夹下。

如下，index，objects即是快照记录的位置。

![](https://static.1991421.cn/2020/2020-12-20-154131.jpeg)


## Git操作流程



![](https://static.1991421.cn/2020/2020-12-20-154508.jpeg)



- git add时，文件会被存储到暂存区
- gi t commit时，文件会被存储到本地仓库



## 参考文档

- https://stackoverflow.com/questions/27264809/where-git-staged-files-are-stored
