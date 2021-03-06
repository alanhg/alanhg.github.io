---
title: Android反编译
abbrlink: 792a6dc0
date: 2017-03-13 08:26:53
tags:
- decompile
- java
---
> 由于业务需要，进行了反编译的学习，有几点收获,这里总结下。

![Android](https://static.1991421.cn/blog/2018-01-05-055903.jpg)

## 什么是反编译
APP开发是将项目代码打包成一个APP，如果是安卓版就是个APK包，最终通过商店或者其它渠道，安装在用户的手机上。
而反编译是将APP包，进行逆向工程，最大程度的拿到原来的所有资源，如项目代码。

### Android，iOS可行？
IOS本身是个封闭的环境，所以可行性几乎为0，没有大量的投入，这里你可以认为就是0
Android还具有一定的可行性，当然目前的APP一般都是做了代码混淆、安全加固的。

## 反编译流程

这里的反编译讲的是`Android`

## 环境准备

+ JAVA环境-建议[1.8+](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
+ IDE，推荐`Intelij IDEA`或`Android Studio`
+ Unix环境，推荐`Mac,Ubuntu`

## 反编译工具

玩了下[在线工具decompileandroid](www.decompileandroid.com)、[jadx](https://github.com/skylot/jadx)、[AndroidDecompiler](https://github.com/dirkvranckaert/AndroidDecompiler),
对比推荐`jadx`，下面介绍下jadx基本使用
 
## 开始

### 下载ZIP包

网址:[这里](https://github.com/skylot/jadx/releases),下载最新版的zip包即可，注意不要选择源码。

![](https://static.1991421.cn/blog/2018-01-04-145125.png)

### 环境变量配置

不同平台不一样，比如MAC，我是配置在`cat ~/.bash_profile`用户级环境变量配置，想立即生效，执行`source ~/.bash_profile`

### 运行GUI反编译工具

```
# 运行反编译GUI工具
$ jadx-gui

```
点击文件-打开文件，选择目标APK，等待工具自动执行，会看到工具将项目自动反编译成功，选择另存所有文件到某个地方即可。

![](https://static.1991421.cn/blog/2018-01-04-145724.png)


### 利用IDE打开上一步另存出的项目CODE

如图为某瓣APP反编译出来的项目CODE
![](https://static.1991421.cn/blog/2018-01-04-145604.png)

### 分析CODE

这点就看个人功力了，学过JAVA，学过Android会好很多

## 代码之外
除了反编译出来的项目代码外，还需要结合两点

### 玩APP
通过APP的具体操作，比如发帖按钮，其实对应去CODE中找对应的Activity等类库会好很多。

### 通过搭建模拟器，代理网络，抓包

除了APP本身，APP是需要与服务端进行交互的，所以利用Fiddler等抓包工具，进行抓包分析，可以拿到接口信息，从而印证某些推断。
目前的HTTP请求很多都是加密了的，即HTTPS,这个需要证书来解决了，建议查下相关资料吧。 


## 写在最后

— 目前安卓开发，在打包时候都是会进行**代码混淆**的，所以即使去壳反编译后，也不是说就完全的展示了项目的情况，但是基本上并不影响大体的阅读。
其实反编译一些优秀的app，阅读别人的代码，了解别人的整体设计，是种很不错的学习形式。

- 前端本身是透明的，所以反编译用来学习很好，不要直接盗窃别人的劳动成果，这点是需要注意的。
