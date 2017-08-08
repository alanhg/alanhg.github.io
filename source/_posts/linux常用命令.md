---
title: linux常用命令
tags:
  - linux
abbrlink: fe4ef317
date: 2017-05-15 15:40:41
---

## 查看系统信息

```
uname -a # 查看内核，操作系统，CPU信息 
head -n 1 /etc/issue   # 查看操作系统版本
env # 查看环境变量

# centos版本查看
$ rpm -q centos-release

```
## 账户权限
```
# 修改当前用户密码
$ passwd
```
## 文件操作

```
vi filename
cat filename

# 删除文件
$ rm filename

# 删除文件夹
$ rm -rf dir

# 查找并删除
$ find  .  -name test  | xargs rm -rf   

# 压缩
$ tar zcvf FileName.tar.gz DirName

# 解压
$ tar zxvf FileName.tar.gz
```
## 目录操作

```
# 当前用户目录下
$ cd ~

```

## 服务
`chkconfig`命令主要用来更新（启动或停止）和查询系统服务的运行级信息。谨记chkconfig不是立即自动禁止或激活一个服务，它只是简单的改变了符号连接。
```
chkconfig --list        #列出所有的系统服务
chkconfig --add httpd        #增加httpd服务
chkconfig --del httpd        #删除httpd服务
chkconfig --level httpd 2345 on        #设置httpd在运行级别为2、3、4、5的情况下都是on（开启）的状态
chkconfig --list        #列出系统所有的服务启动情况
chkconfig --list mysqld        #列出mysqld服务设置情况
chkconfig --level 35 mysqld on        #设定mysqld在等级3和5为开机运行服务，--level 35表示操作只在等级3和5执行，on表示启动，off表示关闭
chkconfig mysqld on        #设定mysqld在各等级为on，“各等级”包括2、3、4、5等级
```
`service`命令常被用于运行初始化脚本，通常所有的系统级初始化脚本被存储于`/etc/init.d`目录下.常用 命令如下
```
$ service SCRIPT-Name start
$ service SCRIPT-Name status
$ service SCRIPT-Name restart

```

## http
```
$ curl http://1991421.cn >> test.html

```
## 查找
```
# 在环境变量$PATH设置的目录里查找python指令位置
$ which python

```

## 环境
+ 显示环境变量`NODE_ENV`
```
$ echo $NODE_ENV
```
+ 设置环境变量`NODE_ENV`
```
$ export NODE_ENV="production"
```
+ 显示所有环境变量
```
$ env
```
+ 删除环境变量`NODE_ENV`
```
$ unset NODE_ENV
```
