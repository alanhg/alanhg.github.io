---
title: linux下redis安装指南
date: 2017-07-11 23:17:34
tags:
- redis
- linux
---
redis官方提供的方式是源码安装，官方已经提供了安装教程，习惯原版，[点击这里](https://redis.io/topics/quickstart)，我这里更多是翻译和讲解下。

## 编译
官方提供的是源码
```
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make
```
进入src目录下，会看到这些可执行的脚本
+ redis-server redis服务本身
+ redis-sentinel is the Redis Sentinel executable (monitoring and failover).
+ redis-cli redis交互命令行
+ redis-benchmark 用于检查redis表现
+ redis-check-aof and redis-check-dump are useful in the rare event of corrupted data files.

## 复制脚本
在src下执行以下两个命令
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/
或者直接执行`sudo make install`

## 做成服务
实际应用还是需要做成服务，且自启动，这样子方便管理,如下:
创建文件，用来存储redis配置和数据
sudo mkdir /etc/redis
sudo mkdir /var/redis

复制util下的初始化脚本到`/etc/init.d`下,
sudo cp utils/redis_init_script /etc/init.d/redis_6379

sudo cp redis.conf /etc/redis/6379.conf

sudo mkdir /var/redis/6379

sudo update-rc.d redis_6379 defaults

sudo /etc/init.d/redis_6379 start

