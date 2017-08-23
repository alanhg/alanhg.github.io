---
title: 利用Cordova将移动站点打包
tags:
  - Cordova
  - hybrid
abbrlink: 3302c222
date: 2017-07-02 22:46:11
---
> 最近客户提出一个要求，就是虽然我们已经有了移动网页版站点，但是让客户记住网址，输入网址这个是很辛苦的，那么就需要有APP，但是单纯开发APP的成本还是不少，那么如何最大限度的复用既有的东西呢，比如移动网页版，这个时候就催生这么一种解决方案，利用Cordova这种混合开发工具将移动站点打包为APP，那么APP这种存在就有了，对于特定客户，其实APP跟网页唯一的区别只是存在形式的不同，并不需要有什么差异性的功能，那么这种情境下，将M站点进行打包APP就再合适不过了。

## 可行性

## 能打包吗？

答案：OK,说白了就是利用系统浏览器打开网页,cordova有浏览器插件,所以肯定可以。

## 能上架吗?

答案:现在可以直接说结论,目前大部分可以，都不行的话，这篇文章不用看了，无太大意义。
本人利用这个方案打包的APP，在主流的`苹果`、`应用宝`、`360`、`豌豆荚`、`华为`、`魅族`、`vivo`均OK。
小米商店不行，提交审核会被打回,明确指出单纯加壳APP不行。

既然目前主要的商店都支持，那就继续看下如何实现吧！

## 具体策略

+ cordova初始化项目
初始化开发环境及细节请参见官方doc，这里没必要重复,[点击这里](https://cordova.apache.org/docs/en/latest/guide/cli/index.html)
+ 安装主要几个插件
 - `$ cordova plugin add cordova-plugin-whitelist`
 - `$ cordova plugin add cordova-plugin-splashscreen`
    该插件主要控制APP启动画面的设定
 - `$ cordova plugin add cordova-plugin-inappbrowser`
    该插件实现在APP中利用内置浏览器打开目标网页
+ 在`index.js`文件中，实现应用启动后打开对应站点
```javascript
var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', onDeviceReady, false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function () {
        this.receivedEvent('deviceready');
    },

    // Update DOM on a Received Event
    receivedEvent: function (id) {
    }
};
function onDeviceReady() {
    // window.open = cordova.InAppBrowser.open;
    var url = 'http://apache.org';
    var target = '_blank';
    var options = "location=no,toolbar=no";
    cordova.InAppBrowser.open(url, target, options);
}
app.initialize();
```
## 总结
这种方案，主要就是利用Cordova实现APP化，原理上来说就是做了个浏览器，但去掉了浏览器界面，伪装成了APP的模样。

## 小技巧
关于图标，除了UI设计师直接给定各个对应尺寸图标外，我认为利用ionic服务也是不错的选择，安装ionic框架后，利用`ionic resources`，根据模板图片，生成对应平台的各个尺寸图标也是个便捷方式,然后将图标生成config.xml中的对应配置项拷贝过来即可。