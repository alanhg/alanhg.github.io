---
title: Cordova开发常见问题
date: 2017-10-09 21:55:12
tags:
- Cordova
- Android
- ionic
---
> 在利用ionic或者直接使用Cordova开发会经常遇见些问题，这里总结下

+ [Android版，代号、标记和细分版本 (Build) 号关系](#代号、标记和细分版本 (Build) 号关系)
+ [crosswalk-webview是否需要](#crosswalk-webview是否需要)
+ [config.xml文件修改，平台重新添加?](#config.xml文件修改，平台重新添加?)

## 代号、标记和细分版本 (Build) 号关系

代号|版本|API级别
---|---|---
Nougat|7.1|	API 级别 25
Nougat|7.0|	API 级别 24
Marshmallow|	6.0|	API 级别 23
Lollipop|	5.1	|API 级别 22
Lollipop|	5.0	|API 级别 21
KitKat|	4.4-4.4.4	|API 级别 19
Jelly Bean|	4.3.x	|API 级别 18
Jelly Bean|	4.2.x	|API 级别 17
Jelly Bean|	4.1.x	|API 级别 16
Ice Cream Sandwich|	4.0.3-4.0.4|	API 级别 15，NDK 8

最新最全信息，[点击查看官网文档](https://source.android.com/source/build-numbers)

## crosswalk-webview是否需要

[cordova-plugin-crosswalk-webview](https://github.com/crosswalk-project/cordova-plugin-crosswalk-webview)

这个插件，主要是解决老手机卡顿APP操作下卡顿问题，但如果不考虑较旧手机(Android4.4以下)，那么不建议安装
> Android 4.4之前的Android系统浏览器内核是WebKit，Android4.4系统浏览器切换到了Chromium(内核是Webkit的分支Blink)。

安装该插件，就是使用[Crosswalk Webview](http://blog.csdn.net/itcatface/article/details/49799337)替代了系统的WebView.
本质就是将`Chromium`带到APP里,但是4.4及以后已经切换到了`Chromium`

优点:
+ 不依赖安卓版本
+ 兼容性
+ 表现提升，对比老系统webviews的话

不足:
+ 增加内存开销
+ 增加APK体积大小(17MB左右)
+ 增加安装体积(50MB左右)

## config.xml文件修改，平台重新添加?

- ionic项目的的话，`不需要`，执行`ionic cordova build platform`或者`ionic cordova run platform`，ionic-cli直接更新平台中对应的code了。
- Cordova初始化构建的项目，需要rm然后再add。



