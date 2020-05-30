---
title: Alfred实现一键OCR截图识字
date: 2020-05-30 10:40:35
tags:
- OCR
- Alfred
- Workflow
---
> 最近在刷题，发现很多公众号为了保护个人知识版权，都是用图片来发题，这样在测试时，每次都需要从零手写，这样就很浪费时间。于是考虑搞个截图识字来节约时间。


## OCR服务-百度
OCR服务商还是挺多的，谷歌，腾讯，百度等。因为百度的SDK支持NodeJS，而腾讯不行，谷歌毕竟在墙外，可靠性弱一些。所以选择百度。

个人不喜欢百度，但是毕竟OCR服务有限量免费，不用白不用。

## Workflow实现

原理是获取系统剪贴板中图片，API请求百度OCR服务，进而返回文本显示。具体安装后查看配置即可。


下载地址: [戳这里](https://github.com/alanhg/alfred-workflows/tree/master/ocr)

## 如何安装

### workflow文件
双击workflow文件即可安装。但还需要做些环境配置。


### 系统环境

假如没有安装node,需要先装下

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

nvm install 12

```

```bash

brew install pngpaste
npm install baidu-aip-sdk -g

```
### workflow配置

登陆百度智能云，选择文本识别，创建应用,将高亮的三个值配置在workflow中


![](http://static.1991421.cn/2020/2020-05-30-105526.jpeg)


## 当前效果

![](http://static.1991421.cn/2020/2020-05-30-104926.gif)


