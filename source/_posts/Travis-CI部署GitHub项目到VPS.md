---
title: Travis CI部署GitHub项目到VPS
tags:
  - Travis
  - GitHub
  - CI
  - CD
abbrlink: '42577977'
date: 2018-05-06 21:21:51
---
> 之前利用Travis实现了个人博客的构建部署，源码及静态页都是GitHub托管，但GitHub-Page只能显示静态页，比如我当前这个项目Toolkit有前后端，所以考虑托管到VPS，GitHub做代码版本管理，Travis负责构建部署


so,如何实现呢

## Travis平台添加GitHub项目

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-07-152308.jpg)

## 创建SSH key
ssh登录终端传统方式是指令密码，除此之外是公钥私钥方式的免密登录，这里采用这种方式，首先在本地开启机器的ssh公钥添加到部署的目标服务器的authorized_keys中去。

```bash
# 生成ssh-key
$ ssh-keygen
# 将id_rsa.pub中的内容粘贴到vps服务器~/.ssh/authorized_keys中
```
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-07-153554.png)

成功标志:`如果添加成功的话，我们本地机登录VPS是免密的`

## 加密私钥
复制刚才生成的key-私钥到项目根目录下
```
$ gem install travis
# 执行登录命令，按提示输入账户，确认GitHub项目
$ travis login                       
$ travis encrypt-file id_rsa  --add

```
执行上述命令后，会发现，目录下生成了`id_rsa.enc`及`. travis.yml`中增加了一段脚本
```
before_install:
- openssl aes-256-cbc -K $encrypted_62e9ddb2e48f_key -iv $encrypted_62e9ddb2e48f_iv -in id_rsa.enc -out ~/.ssh/id_rsa -d
```

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-07-153647.png)


## 添加ssh_known_hosts
```
addons:
    ssh_known_hosts:
     - 45.78.58.109:29554
```
如上，为我的配置，IP及端口是我目标部署VPS的配置，如果不加，会报一下连接提示

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-08-030501.png)

## 补充其它配置

这里贴下我的完整配置，[点击这里](https://github.com/alanhg/toolkit/blob/master/.travis.yml)


所有配置都OK后，以后只需要专注业务开发，提交代码，Travis就可以自动部署到VPS，并重启服务了。

## 参考资料
+ [Hexo 博客 travis-ci 自动部署到VPS](https://uedsky.com/2016-06/travis-deploy/)
+ https://docs.travis-ci.com/
+ [SSH免密登录原理及配置](https://my.oschina.net/binxin/blog/651565)