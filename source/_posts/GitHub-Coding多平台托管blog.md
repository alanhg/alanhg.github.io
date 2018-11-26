---
title: 'GitHub,Coding多平台托管blog'
tags:
  - GitHub
  - Hexo
abbrlink: fdccd09f
date: 2017-12-14 12:45:16
---
> GitHub提供静态页托管服务，所以之前一直使用GitHub托管个人静态blog

Github上我创建了用户仓库，master分支为静态页，source分支为博客code源码。

写博=》》更新站点流程是:
1. 本地写博，push到source分支
2. Travis-CI 监测到source分支变动，构建打包更新master分支
整体还是非常方便的，但GitHub屏蔽了百度爬虫，国内使用百度还是居多，不能被百度收录，还是很不开心，这样子，就只能考虑镜像一份静态站点到国内的平台了，或者自己租个服务器托管。

我这里选择使用`coding`，主要有以下2点原因
1. 速度快
2. 支持自定义域名

## 实现策略如下

### coding创建账号
推荐与GitHub同账号名，当然不同也没问题，只需注意仓库名要与账号名一致，这样才支持`{user_name}.coding.me`访问。

![](http://static.1991421.cn/blog/2017-12-14-054602.png)

### 本地增加多上游仓库地址

![](http://static.1991421.cn/blog/2017-12-14-054315.png)

### push静态页到coding主干分支

```
$ git push coding master

```

### 开启pages服务，并且配置自定义域名

![](http://static.1991421.cn/blog/2017-12-14-054144.png)

### 阿里DNS域名解析增加百度线路解析

![](http://static.1991421.cn/blog/2017-12-14-054107.png)

**注意:我这里只是想解决百度爬虫无法收录，所以只设定百度搜索线路走coding站点。**

## 结语

如上配置后，百度爬虫就可以正常访问我们的WEB，百度收录就OK了。
