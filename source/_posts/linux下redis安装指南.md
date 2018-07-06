---
title: linux下redis安装指南
tags:
  - redis
  - linux
abbrlink: '85e41428'
date: 2017-07-11 23:17:34
---
> redis官方提供的方式是源码安装，官方已经提供了安装教程，若习惯原版，[点击这里](https://redis.io/topics/quickstart)，我这里更多是翻译和补充下。
顺便再回顾下常用命令

## 安装
官方提供的是源码
```bash
$ wget http://download.redis.io/redis-stable.tar.gz
# 解压，释放源代码文件
$ tar xvzf redis-stable.tar.gz
$ cd redis-stable
# 编译
$ make
```
进入src目录下，会看到这些可执行的脚本
+ *redis-server* redis服务端本身
+ *redis-sentinel* is the Redis Sentinel executable (monitoring and failover).
+ *redis-cli* redis交互命令行
+ *redis-benchmark* 用于检查redis表现
+ *redis-check-aof* and *redis-check-dump* are useful in the rare event of corrupted data files.

### 复制脚本
在src下执行以下两个命令
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/
或者直接执行`sudo make install`

## 启动
实际应用还是需要做成服务，且自启动，这样子方便管理,如下:
+ 创建文件，用来存储redis配置和数据
```
sudo mkdir /etc/redis
sudo mkdir /var/redis
```
+ 复制util下的初始化脚本到`/etc/init.d`下,
```
sudo cp utils/redis_init_script /etc/init.d/redis
```
+ 编辑初始化脚本
```
sudo vi /etc/init.d/redis
```
 - 具体修改内容
```
#!/bin/sh
#chkconfig: 2345 80 90
# Simple Redis init.d script conceived to work on Linux systems
# as it does use of the /proc filesystem.

REDISPORT=6379
EXEC=/usr/local/redis/bin/redis-server
CLIEXEC=/usr/local/redis/bin/redis-cli

PIDFILE=/var/run/redis_${REDISPORT}.pid
CONF=”/etc/redis/${REDISPORT}.conf”

case “$1” in
start)
if [ -f $PIDFILE ]
then
echo “$PIDFILE exists, process is already running or crashed”
else
echo “Starting Redis server…”
$EXEC $CONF &
fi
;;
stop)
if [ ! -f $PIDFILE ]
then
echo “$PIDFILE does not exist, process is not running”
else
PID=$(cat $PIDFILE)
echo “Stopping …”
$CLIEXEC -p $REDISPORT shutdown
while [ -x /proc/${PID} ]
do
echo “Waiting for Redis to shutdown …”
sleep 1
done
echo “Redis stopped”
fi
;;
*)
echo “Please use start or stop as first argument”
;;
esac

```
与源配置文件对比
1. `#chkconfig: 2345 80 90`
2. `$EXEC $CONF &`

+ 注册服务 
```
# 注册服务 
$ chkconfig -add redis
```
+ 服务自启动
```
$ chkconfig redis on 
```
## yum安装
以上是源码安装，较为麻烦，如果yum安装则简单多了
```bash
$ yum install -y redis
```
安装完成后，启动服务即可。

