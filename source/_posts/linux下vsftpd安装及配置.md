---
title: linux下vsftpd安装及配置
tags:
  - linux
  - ftp
  - vsftpd
abbrlink: f84c18e6
date: 2017-08-19 09:57:02
---
![vsftpd](http://static.1991421.cn/blog/2017-08-26-082519.jpg)

> 部署web,需要进行文件传输，单文件传输的话，使用sz,rz即可实现，多文件还是用ftp较为便捷,
vsftpd是linux环境下的老牌服务端软件，正如它自己的话-Probably the most secure and fastest FTP server for UNIX-like systems.

## 安装

```bash
# 软件安装
$ yum install -y vsftpd

# 服务自启动
$ chkconfig on vsftpd

# 服务启动
$ service vsftpd start

```

## 配置
配置文件位置:`/etc/vsftpd/vsftpd.conf`

建议做备份，一旦坏了，可以还原。。。`cp vsftpd.conf vsftpd.conf.bak`

## 参考文章
+ [CentOS下vsftp设置、匿名用户&本地用户设置、PORT、PASV模式设置](http://desert3.iteye.com/blog/1685734)


