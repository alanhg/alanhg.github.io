---
title: ' Cannot find module inherits'
tags:
  - Node
  - nodejs
abbrlink: 7a3a5e4
date: 2018-06-26 02:51:28
---
> 最近在做项目Angular5升级至6时，遇到了提交源码，CI服务器执行构建报错`“Error: Cannot find module 'inherits'”`

网上搜罗的方案，有说重装node，更新NPM，也有直接安装这个包的，但是比如安装包，实际上，再次执行构建，又会报其它错误，比如下面这个
```
Cannot find module 'semver'
Error: Cannot find module 'semver'
```
所以这个直接安装包的方案是不行的。

分析了下其实是lock文件的问题【npm5的时候，增加的文件，确保各个包版本OK】，`直接删除lock文件，重新执行npm i`。这个时候会重新生成。再执行构建OK了。

贴出修改前后lock文件变化，对比发现，确实这里有错。
![](http://static.1991421.cn/2018-06-26-072603.jpg)

- 左边图是之前构建报错的lock文件
- 右边是重新生成的

## package-lock说明
如果改了package.json，且package.json和lock文件不同，那么执行`npm i`时npm会根据package中的版本号以及语义含义去下载最新的包，并更新至lock。如果两者是同一状态，那么执行`npm i `都会根据lock下载，不会理会package实际包的版本是否有新。



