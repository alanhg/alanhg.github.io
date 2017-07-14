---
title: 关于cordova封装h5站点遇到的坑
tags:
  - cordova
  - hybrid
abbrlink: fcd67311
date: 2017-07-14 21:55:27
---
>倘若存在移动网页，然后需要APP，但是只是作为一种存在介质的话，cordova来将其封装打包，最为合适，但是当我真正去做还是会有坑。
将其封装为APP，主要使用到了这个插件[cordova-plugin-inappbrowser](https://github.com/apache/cordova-plugin-inappbrowser)

## 坑1-文件下载
在实际APP中，点击下载，发现没反应，几次都不行，推断有问题，在github插件pr中检索download,果然，发现有相关问题，如下图，仔细看了下，得到以下两点信息
![inappbrowser-pr](http://or0g12e5e.bkt.clouddn.com/inappbrowser-pr.png)
+ 首先这个下载问题，的确是这个插件的事，本质原因是安卓手机下载，就意味着文件要存储在手机上，而这是需要授权的，所以插件必须要声明文件存储权限，然后看了下插件的源码，果然，根本没有存储权限
+ 是pr，说明已经解决，并且提交，申请合并主干了，但是由于pr是打开状态，说明还没合并主干，那么通过npm，cordova安装的都不行了，因为官方版本不行，所以只能根据提交记录找到提交记录作者的fork状态下的插件即可，然后下载下来丢到项目中对应插件下，重新添加平台，构建打包，发现，果然解决啦。
![inappbrowser-pull](http://or0g12e5e.bkt.clouddn.com/inappbrowser-pull.png)
![inappbrowser-fork](http://or0g12e5e.bkt.clouddn.com/inappbrowser-fork.png)

## 坑2-启动画面-splashscreen
按照启动动画默认的设置，实际运行，发现启动动画消失后会有长时间的白屏问题，分析发现，是inappbrowser在打开网页的时候是会有一段时间的白屏，那么这个就造成很不好的体验，需要实现启动动画一直显示，然后如果事件监听到网页加载完成了，就手动关闭启动动画，这样子是最好，查看插件官方文档，有这么个参数配置
`<preference name="AutoHideSplashScreen" value="false" />`
按照配置说明是设置为false,就不会自动关闭，需要手动关闭
但是实际配置后，添加平台，运行，发现不起作用，查看