---
title: Docker常用命令
date: 2018-07-07 10:36:48
tags:
- Docker
- 指令集
---
![](http://or0g12e5e.bkt.clouddn.com/2018-07-07-024107.png)

> 这里将平时使用的docker命令记录下，方便以后忘了的话，快速查询

```bash
# 查看所有容器（包含未启动的）
$ docker ps -a

# 创建一个容器，-P表示Docker随机映射一个端口到内部容器开放的端口，-p 8888:80 表示指定端口映射容器80
$ docker run -P -d nginx:latest 

# 进入docker容器bash
$ docker exec -it containerId bash

# 停止容器
$ docker stop containerId

# 删除容器
$ docker rm contaierId

# 查看所有镜像
$ docker images
```
## 写在最后
最终以官方CLI为准，[点击这里](https://docs.docker.com/engine/reference/run/)
