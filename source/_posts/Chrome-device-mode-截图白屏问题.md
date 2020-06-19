---
title: Chrome device mode 截图白屏问题
tags:
  - Chrome
abbrlink: a45efddd
date: 2017-09-28 22:44:26
---
> 测试网站或者制作移动网页截图，使用对应真机设备是一种方式，但在特定场景下也不免效率和成本偏高，Chrome浏览器自带的device mode可以完美模拟各种移动设备的分辨率，
另外还Chrome提供了截图功能。

## 问题
由于Chrome提供的设备毕竟有限，所以有时会需要添加自定义设备，但是最近在使用自定义设备，进行截图的时候，发现截图出来的是空白页面。

效果如下图
![white screen](https://static.1991421.cn/blog/2017-09-28-144925.jpg)

看了一遍自定义设备参数，对比测试，最终找到了原因，原来添加自定义设备这个时，`Device pixel ratio`这个参数是不能为空，否则即会出现截图为白屏即空白的情况。
如下图，我手动设定为`1`
![custom device](https://static.1991421.cn/blog/2017-09-28-145105.jpg)

关闭标签页，重新打开网页，按F12，点击设备模式，还是刚刚自定义的设备，点击截图，发现OK了。

![is ok](https://static.1991421.cn/blog/2017-09-28-150757.jpg)

## 说明

### Device pixel ratio

devicePixelRatio是设备上物理像素和设备独立像素(device-independent pixels (dips))的比例。
在视网膜屏幕的iphone上，屏幕物理像素640像素，独立像素还是320像素，因此，devicePixelRatio等于2。

## 注意细节

修改了自定义设备参数，比如宽高等，刷新当前标签页是不起作用的，必须切换模拟设备或者关闭标签页，重新打开。
