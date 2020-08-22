---
title: Pro Git读书记
date: 2020-08-22 14:32:16
tags:
- Git
- CVS
- ebook
---
> Git已经成了开发中不可缺少的技能，Git玩的好，也是生产力。对于Git，我之前有一些人知盲区，于是碎片时间读了下[《Pro Git, Second Edition》](https://book.douban.com/subject/26208470)，不愧是GitHub官方推荐的学习资料，确是好书。

这里mark下几个知识点，强化记忆


![](https://static.1991421.cn/2020/2020-08-22-150715.jpeg)


## Git Commit修改

- 如果只是本地已经commit但未push，message可以直接修改，原理实际上就是` git commit --amend -m`
- 如果是已经push到上游的最后一次提交，可以reset指针到上一次的提交，然后重新commit，但是这时push需要`--force`

### 注意

1. Commit Message修改后，Hash值会变。也就是只要重新提交，Hash值就会变
2. 如果你想修改不是上一次的提交，本地历史可以，但是push后的不可以修改

整体来说，历史是无法改变的，但是如上的情况下是可以修改的。

## rebase vs merge
我们的Git Workflow往往是多分支的，对于分支之间的合并Change，有两种手段，Merge和Rebase。

![](https://static.1991421.cn/2020/2020-08-22-143747.jpeg)

Merge效果如下，注意

![](https://static.1991421.cn/2020/2020-08-22-143804.jpeg)

Rebase-变基，效果如

![](https://static.1991421.cn/2020/2020-08-22-143822.jpeg)

### 注意
- Merge会产生一个新的Commit
- Rebase没有多出新的commit
- 如上Rebase操作具体是到temp分支执行rebase master处理冲突，这样祖先就变成了master，进而在master分支执行merge即可
- Rebase是改基，就是改了指针指向的祖先

## Server端 Git Hooks
> Git hook能够在发生某特定行为的时机，触发执行自定义的脚本。

在实际的项目开发中Client端Git Hooks一直发挥着作用，比如lint代码风格 ，比如本地强制跑UT等。但是需要知道hooks本身也有server端的支持。这样可以互补了client端的不足，比如可以做提交信息合格率检测，拒绝非法Push等。

Server端Git Hooks配置原理与本地类似，要知道Git是分布式的。
