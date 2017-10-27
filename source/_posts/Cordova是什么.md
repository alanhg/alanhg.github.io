---
title: Cordova是什么
tags:
  - cordova
  - hybrid
  - ionic
abbrlink: 313a0813
date: 2017-07-02 17:31:43
---
## Cordova是什么
Cordova详细介绍及前世今生，建议看维基百科和官网,[点击这里](https://en.wikipedia.org/wiki/Apache_Cordova)

![Cordova](http://or0g12e5e.bkt.clouddn.com/cordova-bot.png)

我这里只做一个简短的介绍，Cordova是一个`移动应用开发框架`，Cordova使得开发者可以用`CSS3`、`HTML5`、`Javascript`来开发应用，它拓展了Html和Js在设备上的功能，这样的应用就是`hybrid`，它既不是真的原生应用(因为所有的布局渲染不是通过平台原生UI框架，而是Web Views)，也不是简单的web-app(它们被打包成APP，且具备访问原生设备API的能力)。

### 结构图

![Architecture](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-10-163512.jpg)

## Ionic跟Cordova的关系是什么
![ionic](http://or0g12e5e.bkt.clouddn.com/Ionic-logo.png)
我们一般并不直接用Cordova开发混合应用，而是用Ionic,Ionic是用于构建Hybid-app的开源SDK，它提供了工具和服务来从事开发，Ionic是构建于Angularjs和cordova之上的，所以可以明确ionic与cordova并不是一个层面的东西。

## Cordova拿来干什么
利用Cordova，开发人员可以用web开发技术来进行app开发，同时利用Cordova给与的访问设备底层api的接口，实现相机，蓝牙等功能。而Ionic这种技术的存在，是为了提升app开发效率，为我们提供了大量的组件轮子而已。