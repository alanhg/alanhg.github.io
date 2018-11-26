---
title: Mac在Zsh环境下安装maven
abbrlink: 431ef2a3
date: 2018-03-04 15:23:57
tags:
- zsh
- maven
---
> maven是java开发下的一款构建工具，这里介绍下载zsh shell下maven的安装

## 下载maven包

![](http://static.1991421.cn/blog/2018-03-04-072623.png)
解压，放在比如该目录`/Library/apache-maven-3.5.2`

## 打开终端如iterm2,执行以下指令，配置zshrc文件

```
$ vi ~/.zshrc
```
在文件末尾追加以下命令

```
export M2_HOME=/Library/apache-maven-3.5.2
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

```
退出编辑器，关闭终端，重启终端

![](http://static.1991421.cn/blog/2018-03-04-072933.png)
