---
title: NativeScript入门指南
tags:
  - nativescript
abbrlink: 7ce0841c
date: 2017-06-11 00:09:57
---
nativescript是个跨平台开发框架，号称性能只比原生差10%,同时又支持Angular写法，这对于有web及ng开发人，算是足够有诱惑力啦。

## 环境搭建

### Node安装

node安装具体直接到官网吧[点击这里](https://nodejs.org/zh-cn/download/)

建议：
+ 安装nvm,控制机子多版本node问题
```
nvm install node
nvm use
```
+ 安装nrm,切换源到淘宝，提升装包速度
```
$ npm i -g nrm
$ nrm ls
$ nrm use taobao  //switch registry to taobao
```

### 安装NativeScript CLI
`npm install -g nativescript`

注意，`全局安装`

### IOS和Android环境安装
不同平台，策略不同
具体安装细节照着官网文档做，这里我没必要重复
+ [Windows](http://docs.nativescript.org/angular/start/ns-setup-win)
+ [Mac](http://docs.nativescript.org/angular/start/ns-setup-os-x)
+ [Linux](http://docs.nativescript.org/angular/start/ns-setup-linux)

注意:
+ Android环境，建议首先安装androidstudio,通过官方ide去管理sdk更方便
+ 如果之前配置过安卓环境对应的步骤可以略过 


### 校验程序
`tns doctor`

### 创建项目
`tns create HelloWorld --template nativescript-template-ng-tutorial`
注意:
模板形式创建的项目缺少`App_Resources`资源文件夹内容，所以直接执行下面的运行会报错，从github的官方demo上下载[点击这里](https://github.com/NativeScript/nativescript-marketplace-demo/tree/master/app/App_Resources)，拷贝文件夹放入项目中。

### 运行项目

```
tns run android
tns run ios
```

到此为止，应该初步OK了，下来就是详细的跟着官方doc学习下基本思想和基本玩法了。
