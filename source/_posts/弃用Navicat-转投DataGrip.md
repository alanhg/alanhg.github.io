---
title: '弃用Navicat,转投DataGrip'
tags:
  - DataGrip
  - Software
abbrlink: 6111fbb0
date: 2019-10-01 23:59:47
---

> DB工具之前一直使用Navicat，从破解版到单个DB版，再到Essentials版，来回折腾，如今决定转投JetBrains旗下的DataGrip

![](http://static.1991421.cn/2019-10-02-014747.jpg)

## 弃用Navicat理由

1. 价钱
	
	License贵，单个DB版，比如MySQL，一年1000多块，而作为跨数据库的旗舰版，更是一年要5千多块。工作中，我喜欢一个软件解决一类问题，就像IDE，不可能一个语言都来一个特定IDE，有一个全能型的更好。so，我倾向使用Navicat旗舰版，但价格却太高昂，个人买是不可能了，无奈公司也不提供旗舰版license【特殊情况可以走项目申请-麻烦】
2. 效率

	Navicat的GUI做的很成熟美观，但对于程序员来说，鼠标操作还是慢几拍，对比Jetbrains公司的IDEA，WS等对于快捷键的支持，弱鸡。
	
3. 更新缓慢
	
	软件更新升级慢，同时也不提供SDK，个人定制开发是不可能了。so一旦遇到一些问题，无处询问，只能干等，记得之前遇到DB数据导出Excel，发现支持上有问题。

吐槽了不足，当然Navicat也不是没优点的，毕竟人家是一款成熟的产品了。尤其旗舰版，各种主流数据库【关系 or 非关系数据库】都支持，仅这一条，秒杀大多DB软件，另外导入导出，查询，备份等常用功能都很齐全。

但毕竟贵，使用单个数据库版的后果就是需要来回切软件，同时，破解或者Essential版也都不是长久之计，so决定还是换吧！

## 选择DataGrip的理由

选择DataGrip的理由就是它在保障基本功能的同时，上述3个缺点都不存在。

1. 功能齐全

	DataGrip经过几年的发展，基本功能很全面。可以与Naviat一拼，另外多DB支持【PostgreSQL,MySQL,SQLite,MongoDB`2019.3新增支持`】。
	
1. 价钱

	License不算贵，1年1000多块，这价位与Navicat单个DB版持平了
2. 效率

 快捷键支持好到爆，要知道DataGrip是Jetbrains公司旗下的产品，基本操作都是一套习惯，熟悉基本界面的，再学习成本不高。另外也都有自定义快捷键的口子。
	
	推荐官方视频-[戳这里](https://www.youtube.com/watch?v=Xb9K8IAdZNg&t=231s)
	
3. 更新快
	JetBrains旗下的IDE更新频繁，这点非常好。另外SDK开放，基于此可以二次开发，解决一些个性化的问题。
	
### 不足之处

#### NoSQL支持还不够
官方论坛上关于这个呼声蛮高- [No-SQL support
](https://youtrack.jetbrains.com/issue/DBE-41?_ga=2.263967756.1891671747.1569902179-110805512.1543747110)
个人觉得解决是个早晚的事。但在解决前怎么办呢，一些人没办法只能再安别的专门软件来解决这些不支持的数据库。但毕竟要来回切，不爽啊。

好消息是`2019.3`今年最后一版增加了mongo支持，好极了，以后会越来越多，但让假如是还不支持的数据库，可以尝试插件检索下。真不行也可以自己开发一个，SDK还是挺简单的。

#### 导出功能还不丰富

比如我想Excel导出表结构，目前还不支持

## DataGrip学习资料
- [Youtube](https://www.youtube.com/watch?v=Xb9K8IAdZNg)
- [How to Find Things in DataGrip](https://blog.jetbrains.com/datagrip/2017/04/20/how-to-find-things-in-datagrip/)

## 写在最后
之前在DB这块使用上很不爽【有点折腾】，这次下定决心切换了App，接下来就是多玩提高熟悉度，从而提高生产力了。同时也希望DataGrip给力点，遵从民意，快点支持NoSQL数据库吧！

