---
title: Git多远程仓库配置
abbrlink: 4c1ccb9c
date: 2017-11-27 22:31:14
tags:
---
> 实际开发中，有时候会遇到Git项目需要托管到多个远程地址情况，当然Git是支持多上游的，所以操作还是很简单的。

## 例子

比如我们有GitHub、码云两个仓库地址
```bash
# 添加GitHub
$ git remote add github https://github.com/alanhg/NiceFish.git

# 添加码云
$ git remote add oschina https://gitee.com/mumu-osc/NiceFish.git

# 提交到GitHub
git push github master

# 提交到多个仓库
git push --all 

```

## 语法说明
详细请看官方手册,[链接](https://git-scm.com/docs/git-push)
```
# name为远程名称,url是地址
$ git remote add  <name> <url>

# --all,push所有分支,repository为仓库地址，或者远程名称，refspec为分支名称
$ git push [--all] [<repository> [<refspec>…​]]
```




