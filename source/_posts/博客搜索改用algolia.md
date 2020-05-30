---
title: 博客搜索改用Algolia
date: 2020-05-30 22:20:57
tags:
- theme-next
- hexo
---
> 个人博客当前使用的搜索服务是Swiftype，但有一定试用期，到期后402报错。而local search的体验很差，于是我切换到使用algolia。发现这么个服务配置，网上说法不一，多少还是踩了点坑的，这里简单Mark下。


## 当前博客主题版本
- hexo - v3.9.0
- hexo-theme-next - v7.2.0

注意：版本不同，配置确实可能存在出入

## algolia站点服务注册

- 登陆官网，账户注册，创建索引
- API Keys中All API keys下创建API，注意给予搜索增删索引的权限

博客配置中要用到这里的`search,admin API Key`和索引名字

## 主题配置文件
开启algolia服务

## 博客主配置文件

```yml
algolia:
  appId: 
  applicationID: 
  apiKey: 
  adminApiKey: 
  chunkSize: 5000
  indexName: my_blog
  fields:
    - content:strip:truncate,0,500
    - excerpt:strip
    - gallery
    - permalink
    - photos
    - slug
    - tags
    - title
```

### 注意
- 不需要安装next官网提到`npm install --save hexo-algolia`,推荐`npm install hexo-algoliasearch --save`,如果有则直接跳过
- appId，applicationID配置值一样，之所以有appId，applicationID是因为站点内容索引需要的配置项与主题模版的不一致，可能是版本不对应造成的，具体我不想去查，不重要。

## 索引生成

```bash
$ export HEXO_ALGOLIA_INDEXING_KEY=xxxx
$ hexo algolia

```

注意Win下默认shell不支持export，可以在git bash下执行

如上配置后，即可完成搜索服务的配置。

## 写在最后

local search,Swiftype,Algolia,这算是将next主题支持的搜索服务玩一遍了，如果Algolia也不行了，我就只好自己搭建搜索服务支持了，等着这个需求出现吧。

## 参考文档

- http://theme-next.iissnan.com/third-party-services.html#wei-sousuo
