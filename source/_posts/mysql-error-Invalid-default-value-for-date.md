---
title: 'mysql error:Invalid default value for date'
tags:
  - mysql
  - db
abbrlink: 7c1b75b3
date: 2017-10-04 03:34:51
---
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-03-201336.jpg)

> 最近在进行mysql数据迁移时遇见了这个错误,推断是mysql版本差异性带来的问题，我的A、B机器MySQL版本分别是5.6和5.7

## 原因
Google了一把，发现原来是MySQL-SQL Mode的问题。

## 解决
修改配置文件,重启服务
```
# sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES 
sql_mode=ONLY_FULL_GROUP_BY,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
```
提示:去掉sql_mode配置是不起作用的
