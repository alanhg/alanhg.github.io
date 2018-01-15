---
title: linux常用命令
tags:
  - linux
abbrlink: fe4ef317
date: 2017-05-15 15:40:41
---
![terminal](http://or0g12e5e.bkt.clouddn.com/blog/2017-08-19-040639.jpg)
> 使用文字界面来设定，对于了解Linux有一定的帮住,平时不免接触,常用命令总结如下。

## 系统

```bash
uname -a # 查看内核，操作系统，CPU信息 
head -n 1 /etc/issue   # 查看操作系统版本
env # 查看环境变量

# centos版本查看
$ rpm -q centos-release

# cpu
$ cat /proc/cpuinfo

# 内存
$ cat /proc/meminfo

```
## 账户
```
# 修改当前用户密码
$ passwd
```
## 档案与目录管理

## 基本属性

```
# 此案时文件的属性以及文件所属的用户和组
$ ls -l

# 更改文件属组
$ chgrp [-R] 属组名文件名

# chown：更改文件属主，也可以同时更改文件属组
chown [–R] 属主名 文件名
chown [-R] 属主名：属组名 文件名

```

## 文件与目录管理

```
# 删除文件
$ rm filename

# 删除文件夹
$ rm -rf dir

# 查找并删除
$ find  .  -name test  | xargs rm -rf   

# 复制
$ cp vsftpd.conf vsftpd.conf.bak

# 单列，长格式，显示所有文件,包含隐藏文件及目录
$ ls -Al

```
### ln

ln命令用来为文件创建连接，连接类型分为硬连接和符号连接两种，默认的连接类型是硬连接。如果要创建符号连接必须使用"-s"选项。

`ln -s /usr/mengqc/mub1 /usr/www/aaa`


## vi

基本上 vi/vim 共分为三种模式，分别是命令模式（Command mode），插入模式（Insert mode）和底线命令模式（Last line mode）。 这三种模式的作用分别是：
### 命令模式

用户刚刚启动 vi/vim，便进入了命令模式。
此状态下敲击键盘动作会被Vim识别为命令，而非输入字符。比如我们此时按下i，并不会输入一个字符，i被当作了一个命令。
以下是常用的几个命令：
i 切换到插入模式，以输入字符。
x 删除当前光标所在处的字符。
: 切换到底线命令模式，以在最底一行输入命令。
若想要编辑文本：启动Vim，进入了命令模式，按下i，切换到输入模式。
命令模式只有一些最基本的命令，因此仍要依靠底线命令模式输入更多命令。

### 输入模式

在命令模式下按下i就进入了输入模式。
在输入模式中，可以使用以下按键：
字符按键以及Shift组合，输入字符
ENTER，回车键，换行
BACK SPACE，退格键，删除光标前一个字符
DEL，删除键，删除光标后一个字符
方向键，在文本中移动光标
HOME/END，移动光标到行首/行尾
Page Up/Page Down，上/下翻页
Insert，切换光标为输入/替换模式，光标将变成竖线/下划线
ESC，退出输入模式，切换到命令模式

### 底线命令模式
在命令模式下按下:（英文冒号）就进入了底线命令模式。
底线命令模式可以输入单个或多个字符的命令，可用的命令非常多。
在底线命令模式中，基本的命令有（已经省略了冒号）：
q 退出程序
w 保存文件

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
$ service SCRIPT-Name stop
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
`说明`，永久生效方法为在`/etc/profile`中添加`export NODE_ENV="production"`,`source /etc/profile`立即生效

## yum

+ 安装指定软件 `yum install <package_name>`
+ 删除指定软件 `yum remove <package_name>`
+ 查找软件包 `yum search <keyword>`

## 磁盘与硬件管理
### mount
```
# mount  /dev/fd0 /mnt/floppy     <=軟碟(windows 系統檔) 

```
`说明`这种方式，立即生效，但是主机重启后会失效，永久生效的方法为在/etc/rx.local添加`mount  /dev/fd0 /mnt/floppy`

## 压缩指令
```
# 压缩
$ tar zcvf FileName.tar.gz DirName

# 解压
$ tar zxvf FileName.tar.gz
```
## 硬件·内核·Shell·监测

-i<条件>：列出符合条件的进程。（4、6、协议、:端口、 @ip ）

```
$ lsof -i:4000

```

### kill
```
# 杀死指定进程
$ kill -9 3840
```

## 相关网站
+ [Linux命令大全](http://man.linuxde.net/)