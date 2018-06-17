---
title: ShadowSocks自定义规则
abbrlink: 6f1919c7
date: 2016-10-07 22:53:52
tags:
- 效率
- 利器
---
点击ss,选择编辑用户规则
格式如下
```
! Put user rules line by line in this file.
! See https://adblockplus.org/en/filter-cheatsheet
||amazonaws.com
||atom.io
```
保存即可。

**规则大概描述如下**
```
通配符支持，如 *.example.com/* 实际书写时可省略 * 如 .example.com/ 意即 *.example.com/*
正则表达式支持，以\开始和结束， 如 \[\w]+:\/\/example.com\
例外规则 @@，如 @@*.example.com/* 满足@@后规则的地址不使用代理
匹配地址开始和结尾 |，如 |http://example.com、example.com| 分别表示以 http://example.com 开始
和以 example.com 结束的地址|| 标记，如 ||example.com 则 http://example.com 、https://example.com 、ftp://example.com 等地址均满足条件，只用于匹配地址
开头
注释 ! 如 ! Comment
分隔符^，表示除了字母、数字或者 _ - . % 之外的任何字符。如 http://example.com^ ，http://example.com/ 和 
http://example.com:8000/ 均满足条件，而 http://example.com.ar/ 不满足条件
```
---------------------------
**搬瓦工简介**
搬瓦工（BandwagonHost）是美国IT7公司旗下的一家提供便宜年付OVZ架构的VPS主机方案的服务商。
因其价格便宜、且依托的商家比较靠谱，具有较高的性价比。
https://bandwagonhost.com/
