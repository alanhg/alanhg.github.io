---
title: 关于Cordova封装H5站点遇到的坑
tags:
  - Cordova
  - hybrid
abbrlink: fcd67311
date: 2017-07-14 21:55:27
---
>倘若存在移动网页，然后需要APP，但是只是作为一种存在介质的话，cordova来将其封装打包，最为合适，但是当真正去做还是会有坑。
将其封装为APP，主要使用到了这个插件[cordova-plugin-inappbrowser](https://github.com/apache/cordova-plugin-inappbrowser)

## 坑1-文件下载
在实际APP中，点击下载，发现没反应，几次都不行，推断有问题，在GitHub插件pr中检索download,果然，发现有相关问题，如下图，仔细看了下，得到以下两点信息
![inappbrowser-pr](http://static.1991421.cn/inappbrowser-pr.png)
+ 首先这个下载问题，的确是这个插件的事，本质原因是安卓手机下载，就意味着文件要存储在手机上，而这是需要授权的，所以插件必须要声明文件存储权限，然后看了下插件的源码，果然，根本没有存储权限
+ 是pr，说明已经解决，并且提交，申请合并主干了，但是由于pr是打开状态，说明还没合并主干，那么通过npm，cordova安装的都不行了，因为官方版本不行，所以只能根据提交记录找到提交记录作者的fork状态下的插件即可，然后下载下来丢到项目中对应插件下，重新添加平台，构建打包，发现，果然解决啦。
![inappbrowser-pull](http://static.1991421.cn/inappbrowser-pull.png)
![inappbrowser-fork](http://static.1991421.cn/inappbrowser-fork.png)

解决问题的插件分支，[点击下载](https://github.com/MeirBon/cordova-plugin-inappbrowser/tree/download-permissions)

## 坑2-启动画面-splashscreen
按照启动动画默认的设置，实际运行，发现启动动画消失后会有长时间的白屏问题，分析发现，是inappbrowser在打开网页的时候是会有一段时间的白屏，那么这个就造成很不好的体验，需要实现启动动画一直显示，然后如果事件监听到网页加载完成了，就手动关闭启动动画，这样子是最好，查看插件官方文档，有这么个参数配置
`<preference name="AutoHideSplashScreen" value="false" />`
按照配置说明是设置为false,就不会自动关闭，需要手动关闭
但是实际配置后，添加平台，运行，发现不起作用，查看pr,果然有人提PR，
![cordova-plugin-splashscreen-pull](http://static.1991421.cn/cordova-plugin-splashscreen-pull.png)
又是open状态，没招。

最终只是绕路解决，想到的方案是配置文件中将splashscreen的时效设置为0，然后手动启动和关闭，但是因为启动会自动消失，所以写定时器循环，不断的show，保证splash不消失，具体代码如下

+ `config.xml`
```xml
    <preference name="ShowSplashScreenSpinner" value="false"/>
    <preference name="SplashScreenDelay" value="0"/>
    <preference name="FadeSplashScreen" value="false"/>
    <preference name="FadeSplashScreenDuration" value="0"/>

```
+ `index.js`
```
    onDeviceReady: function () {
        // this.receivedEvent('deviceready');
        var url = 'http://apache.org';
        var target = '_blank';
        var options = "location=no,toolbar=no";
        var intervalID = window.setInterval(function () {
                console.log('navigator.splashscreen.show()');
                navigator.splashscreen.show();
            }, 500
        );
        inAppBrowserRef = cordova.InAppBrowser.open(url, target, options);
        inAppBrowserRef.addEventListener('loadstart', loadStartCallBack);
        inAppBrowserRef.addEventListener('loadstop', loadStopCallBack);

        function loadStartCallBack() {
            // inAppBrowserRef.hide();
        }

        function loadStopCallBack() {
            // inAppBrowserRef.show();
            if (navigator.splashscreen) {
                clearInterval(intervalID);
                //         // We're done initializing, remove the splash screen
                navigator.splashscreen.hide();
                console.warn('Hiding splash screen');
            }
        }
    },

```
测试效果还不错

## 总结
+ Apache基金会缺钱，缺人，这些插件都是常年累月没人更新，这样造成很多问题无法及时解决，久而久之的话，这些开源技术也就不会有人使用了
+ Google、Github、Stackoverflow，很多时候问题都是在这上面寻找，都是可以找到相关问题的描述，大众点的问题，一般都会有人提出了解决方案
+ Cordova本身这个技术，热度看来在减少，毕竟Reactive Native很成熟，NativeScript也在崛起，类似需求，其实用别的也能实现。
