---
title: Docker初次尝试
tags:
  - Docker
  - 运维
abbrlink: 56f072b9
date: 2018-06-24 05:04:36
---
> Docker这个词，算是近几年的热词了，很多企业也已经大量运用起这个技术。如果不知道恐怕有点low，所以有必要花点时间去了解下。

## Docker简介
![](http://or0g12e5e.bkt.clouddn.com/2018-06-24-121810.jpg)

> Docker是一个开放原始码软体专案，让应用程式布署在软体容器下的工作可以自动化进行，借此在Linux作业系统上，提供一个额外的软体抽象层，以及作业系统层虚拟化的自动管理机制[1]。Docker利用Linux核心中的资源分离机制，例如cgroups，以及Linux核心命名空间（name space），来建立独立的软体容器（containers）。这可以在单一Linux实体下运作，避免启动一个虚拟机器造成的额外负担[2]。Linux核心对命名空间的支援完全隔离了工作环境中应用程式的视野，包括行程树、网路、用户ID与挂载档案系统，而核心的cgroup提供资源隔离，包括CPU、记忆体、block I/O与网路。从0.9版本起，Dockers在使用抽象虚拟是经由libvirt（英语：libvirt）的LXC与systemd - nspawn提供界面的基础上，开始包括libcontainer函式库做为以自己的方式开始直接使用由Linux核心提供的虚拟化的设施。
依据行业分析公司“451研究”：“Dockers是有能力打包应用程式及其虚拟容器，可以在任何Linux伺服器上执行的依赖性工具，这有助于实现灵活性和便携性，应用程式在任何地方都可以执行，无论是公有云、私有云、单机等。”

摘自WIKI，[查看原文](https://zh.m.wikipedia.org/zh-hans/Docker_(%E8%BB%9F%E9%AB%94))

## Docker的能力
Docker是为应用的开发和部署提供的“一站式”容器解决方案，它能帮助开发者高效快速的构建应用，实现“Build，Ship and Run Any App, Anywhere”，从而达到“一次构建，到处运行”的目的。
使用了Docker，我们可以
+ 更快速的交付和部署应用环境。
+ 更高效的资源利用率。
+ 更便捷的迁移和扩展性。
+ 更便捷的应用更新管理。

## 牛刀小试-创建MySQL容器
发现Docker可以解决环境问题，想了下自己过去遇到的各种开发环境配置，版本等蛋疼问题，心想的确，利用Docker不就可以好多了。比如我在开发中，需要用到MySQL，但是不同项目会有版本差异，我不可能电脑安装多版本，平时系统安装的话，作为服务长时间运行也是占用系统资源。这样的确是个问题。

利用Docker实际上似乎就可以快速解决。所以下载安装，搞起。

### 下载Docker
果断官网下载，安全便携。我这里Mac版下载下来就是个dmg，点击运行安装。
### 启动Docker
点击运行即可启动Docker，执行`docker images`，看到还没一个镜像。从hub上拉取
```bash
docker pull mysql:5
docker pull mysql
```
![](http://or0g12e5e.bkt.clouddn.com/2018-06-24-124624.png)
如上，我拉取了最新版(8)及5.x的MySQL，redis等一些常用数据库镜像
执行`$ docker run -p 3306:3306 --name mysql5 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5`
![](http://or0g12e5e.bkt.clouddn.com/2018-06-24-125034.png)
CLI使用说明见这里([官网](https://docs.docker.com/engine/reference/commandline/docker/))

启动成功后，用Navicat连接MySQL试下，没问题，就一句代码的事，MySQL安装成功。
- 假如我要卸载这个，只需要stop，再rm即可
- 假如MySQL8发布了，想第一时间试下呢，没问题，run一个MySQL8镜像的容器
环境安装就是如此简单。
### 写在最后
以上只是初步的尝试，但已经解决了我一些开发环境上的问题。更多的使用还要继续深挖。

