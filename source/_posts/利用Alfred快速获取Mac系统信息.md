---
title: Alfred实现快速获取Mac系统信息
date: 2021-02-11 10:40:46
tags:
- Mac
- Alfred
- Workflow
---

> 有时需要快速查询Mac系统版本信息，或者内存信息，常规操作是点击屏幕顶部右上角Apple图标=>About This Mac=>然后在对应的Tab页寻找信息=>选择拷贝，这样做未免麻烦了些。
>
> 
>
> 于是，趁着节假日，我快速做了个workflow，目标快速获取系统基础信息。



## 效果

![](https://static.1991421.cn/2021/2021-02-11-104601.gif)



说明：选择单个项，回车即可拷贝到系统剪贴板。



下载地址：https://github.com/alanhg/alfred-workflows/tree/master/about-mac

## 实现原理

1. `Apple Script`获取系统信息
2. `Shell`拼接及打印Alfred支持的列表结构

之所以选择Apple Script及Shell，好处是系统内置，这样不依赖任何环境。感兴趣的安装后可查看源码。



## Apple Script学习

做workflow开发，有时绕不开Apple Script，因为AS可以方便的获取系统层面的一些信息，同时可以自动化很多App操作，比如Chrome新开标签页等。

所以如何学习Apple Script是个问题，我在开发时多次尝试看官方doc，但最终发现文档还是太烂，看不进去，这里推荐直接学习较新的Apple Script书即可，毕竟作者已经总结归纳了，可以快速学习上手。不得不说，`官方文档永远是第一手资料`这句话是不一定对的，因为有时官方写的文档不一定行。



这里推荐一本我看过的书[Learn AppleScript: The Comprehensive Guide to Scripting and Automation on Mac OS X, Third Edition](https://learning.oreilly.com/library/view/learn-applescript-the/9781430223610/)，内容还算全面，可以作为入门。



## 写在最后

- 这是我写的第20个workflow了，根据自己的需求不断开发新的小工具，还是很有成就感的
- 写工具本身也是一种学习和锻炼，so，keep



