---
title: Linux文件系统
abbrlink: a4b4101b
date: 2018-03-18 23:02:28
tags:
- Linux
- Unix
- directory
---
> 最近在推进公司的CI，CD化，玩Linux又频繁了点，之前也玩过点，但毕竟主责是系统开发，所以基本功不扎实。当安装Tomcat，安装JDK，FTP时等等，总是会困惑下
软件应该该装在哪儿，或者说合适的路径是什么。每次作业时，总有这困惑，不免浪费时间。所以下决心一探究竟，进而节约些许的时间。

这样搜索多方资料，就有了这篇文章。

关于Linux文件系统，应该看[`文件系统层次标准`](http://www.pathname.com/fhs/),它解释了一些名称的来源。

- /bin-二进制文件
- /boot 启动必须文件
- /dev 设备文件
- /tmp 临时文件
- /etc 这个名称是继承了早起的Unix系统，目标是放置配置文件
- /home Home文件
- /lib 代码库存在位置
- /media 可删除media挂载的文件夹
- /mnt 挂载的文件系统
- /opt 插件软件选择性安装
- /run 执行时间变量数据存放位置
- /sbin 通常只服务于root用户
- /usr 另一个继承Unix的文件夹,代表着用户，这个文件夹应该是用户之间共享的
- /var 另一个继承Unix的文件夹，表示`variable`,
- /srv 表示`serve`,这个文件夹目的是托管静态文件，`/srv/http`表示静态网站,`srv/ftp`是FTP服务器

## /opt vs /usr/local
> /usr/local通常是进入/usr的东西,或者重写已经在/usr下的。/opt是全部在一个文件夹下，或者其它特殊的。

## /tmp文件何时清除
> 我们如果把一些文件放在/tmp下，会发现这些文件过段时间会消失,因为Centos系统中有个定时任务叫tmpwatch,负责定时清除部分目录文件，其中会清除/tmp下超10天的文件,其它系统比如Debian系统是会在启动时清除。

## 相关资料
- https://serverfault.com/questions/24523/meaning-of-directories-on-unix-and-unix-like-systems
