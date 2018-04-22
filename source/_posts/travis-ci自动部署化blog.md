---
title: travis-ci自动部署化blog
tags:
  - travis
  - ci
  - hexo
  - devops
abbrlink: d10aa459
date: 2017-07-04 22:33:54
---
Travis CI is a hosted, distributed[2] continuous integration service used to build and test software projects hosted at GitHub.

## 背景
在github上部署了个人blog，为了便于在不同工作台上进行blog，所以将blog平台源码作为blog仓库分支也托管上，目前仓库下有master(静态页)，source(源码)。

## CI化之前
每次增加新blog后，需要依次执行以下动作
```
# 1.添加修改文件
$ git add .
# 2.提交修改内容到暂存区
$ git commit -m 'update'
# 3.push到远程仓库
$ git push
# 4.生成新的静态页，然后部署到仓库主干即静态页分支下
$ hexo g -d
```
## CI化之后
只要有source分支下有新的推送，即可自动执行部署及推动到静态页主干，也就是以后写blog,不需要再操心静态页部署更新环节,即上面操作的第四步。

