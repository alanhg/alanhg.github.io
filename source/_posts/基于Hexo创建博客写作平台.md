---
title: 基于Hexo创建博客写作平台
tags:
  - hexo
  - Angular
  - 个人产品
abbrlink: 770dc743
date: 2018-06-18 11:16:48
---
> hexo是一款流行的博客框架，利用hexo可以快速创建博客站点，用MD来进行写博，执行命令生成特定的静态页。之前的写博流程大致如下
1. 打开IDE
2. 执行终端命令`hexo new 'postname'`
3. 写博
4. 执行一系列命令 `git add . && git commit -m 'add post' && git push`
等上几分钟，Travis构建成功后，OK，访问站点，新博文更新上去了。

上述流程中总共4步，但除第3步外，其它都是机械化的步骤，本着DRY原则，看来得自己写个工具来省去这些步骤了。于是，WEB博客平台需求就有了。
## 开搞

### 架构设计
