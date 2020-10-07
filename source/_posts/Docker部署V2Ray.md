---
title: Docker部署V2Ray
tags:
  - Docker
  - V2Ray
  - WS
abbrlink: 5df46810
date: 2019-11-16 15:14:20
---

> 由于众所周知的原因，访问谷歌的难度越来越大，从最早的SS到今天的v2ray,VPS也在banwagong,digitalocean,vultr之间换了又换，每次都要重新部署，堪称繁琐，为了节约有限的生命，决定花点时间制作满足自己需求的docker镜像,从而实现一键部署更新。

![](https://static.1991421.cn/2019-11-16-131525.png)


## 准备条件
- ~~网络要健康，可以上谷歌，VPS站点可能被墙~~`比如https://bandwagonhost.com/`

## VPS选择
> 主流的厂商也就这几个，这里我选择`Vultr`,主要是资费灵活且有日本节点，DO目前没有日本机器

- [Digital Ocean](https://www.digitalocean.com/)
- [搬瓦工](https://bandwagonhost.com/)
- [Vultr](https://www.vultr.com/)

机器搞定后，就可以开始配置了。

### Vultr推荐
	
<a href="https://www.vultr.com/?ref=8363373"><img src="https://www.vultr.com/media/banners/banner_468x60.png" width="468" height="60"></a>	
	
### 注意
1. VPS具体机器时区是什么无所谓，因为V2Ray会自动转换时区，但是时间一定要准确。
2. DO的计费是按时计费，关机后依旧扣费，删除服务器才停止计费。
3. 关于操作系统，这里我选择`CentOS 7 x64`
4. 关于机房，我选择了日本节点，一是速度相对较快，二是油管会员香港支持

## 安装 Docker CE

```bash
$ wget -qO- https://get.docker.com/ | sh


// 这步是为了让用户能够直接使用docker命令,root用户忽略
$ sudo usermod -aG docker username

``` 

### 启动 Docker CE

> CE means 社区版

```bash
$ sudo systemctl enable docker
$ sudo systemctl start docker

```

## 安装Docker Compose

```bash
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
$ docker-compose --version // 测试是否安装成功

```

## 文件准备

```
.
├── docker-compose.yml //容易编排文件
├── init-letsencrypt.sh // 证书初始化获取文件
├── nginx 
│   └── conf.d
│       └── default.conf
└── v2ray
    └── config.json

3 directories, 4 file
```

具体配置[戳这里](https://github.com/alanhg/v2ray-docker),这里只说明几处需要修改的点

### init-letsencrypt.sh

- domains需要修改为自己的域名
- email填写

### nginx/conf.d/default.conf
- servername修改为自己的域名，同上
- 证书路径域名修改为自己的域名

### v2ray/config.json

- clients.id修改，推荐使用[生成器](https://intmainreturn0.com/v2ray-config-gen/)重新生成一个ID

### 文件上传

_推荐使用FileZilla进行上传，也可以用以下命令上传_


```bash
$ scp  -r /Users/xxx/Documents/GitHub/v2ray-docker  root@ip:/var/v2ray-docker
```


## 启动服务

终端登录VPS，执行以下命令

```bash
$ cd /var/v2ray-docker

$ chmod +x ./init-letsencrypt.sh

$ ./init-letsencrypt.sh

$ docker-compose up -d

```

### 注意细节

1. 容器间可使用服务名称作为hostname相互访问。例如，v2ray这个服务可使用http://v2ray:10086 访问v2ray服务。
2. 当服务的配置发生更改时，可使用`docker-compose up -d`命令更新配置。此时，Compose会删除旧容器并创建新容器。新容器会以不同的IP地址加入网络，名称保持不变。任何指向旧容器的连接都会被关闭，容器会重新找到新容器并连接上去。
3. 当执行`./init-letsencrypt.sh`时，如果证书获取OK，会出现如下提示，因为系统或网络原因可能获取证书失败[这里我在centos8执行命令时报错，为此切换成了7]。

    ![](https://static.1991421.cn/2019-11-16-111216.png)
4. docker-compose restart nginx 提示成功，不代表nginx成功启动，maybe报错
5. 在使用 nginx docker 容器配置反向代理的时候，默认不能直接使用 localhost，因为访问它指向的是这个容器本身。

### 常用指令

```bash

$ docker network ls
$ docker-compose restart // restart all service
$ docker-compose restart nginx // restart target service
```

## 域名解析
登陆域名服务网页，配置A记录，将目标域名解析指向VPS的IP地址。

## 开启BBR加速

```

# 注意，会提示重启系统，选择Y
$ wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh 

#检测BBR是否开启
$ lsmod | grep bbr 

```

## 客户端配置使用

如上操作后，服务算是部署OK了，只需要客户端进行配置即可。

这里我是用Surge客户端，配置后，即可正常使用.贴下之前DO购买的美国节点与当前Vultr日本节点的延迟区别

![](https://static.1991421.cn/2019-11-16-122952.png)

### 注意
配置即使正确，正常服务可用有延迟，建议在确定配置都正确，连接失败时，`等上10分钟`。


## 不想了解的=》直接上

这里贴出我已经Docker封装好的配置

[戳这里](https://github.com/alanhg/v2ray-docker)

### 建议
1. 登陆Vultr选择一台机器，建议日本的，系统选择`CentOS 7 x64`
2. 狗爹等厂商购买域名，设定解析到上述购买的机器IP上
2. 使用Filezilla登陆，将仓库文件移动上去
4. 客户端使用Clash,Surge等

## 写在最后

经过这番折腾，以后部署一台v2ray机器大致只需要1.install docker;2. docker-compose up，从此脱离了较为繁琐的配置，节约了时间，so值！ 

## 相关资料

- [Docker快速部署v2ray翻墙](https://asfuyao.github.io/2019/06/13/Docker%E5%BF%AB%E9%80%9F%E9%83%A8%E7%BD%B2v2ray%E7%BF%BB%E5%A2%99/)
- [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
