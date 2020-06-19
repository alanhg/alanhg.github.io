---
title: PhantomJS安装
abbrlink: 3b55b49d
date: 2018-05-01 18:32:15
tags:
- PhantomJS

---
> [PhantomJS](https://en.wikipedia.org/wiki/PhantomJS)是一个基于webkit的JavaScript API。它使用QtWebKit作为它核心浏览器的功能，使用webkit来编译解释执行JavaScript代码。任何你可以在基于webkit浏览器做的事情，它都能做到。比如服务端生成JS图表图片等，使用场景很广泛。


如何安装呢，这里简要说明下。

![](https://static.1991421.cn/blog/2018-05-01-103648.png)

## Linux
```bash
$ yum install -y bzip2
$ bzip2 -d phantomjs-2.1.1-linux-x86_64.tar.bz2
$ tar xvf phantomjs-2.1.1-linux-x86_64.tar
$ mv -r phantomjs-2.1.1-linux-x86_64 /usr/local/
$ cd /usr/local/
$ mv phantomjs-2.1.1-linux-x86_64/ phantomjs
$ ln -s /usr/local/phantomjs/bin/phantomjs /usr/bin

```

### 字体问题
因为在实际使用中，我用到了PhantomJS执行highcharts图表生成图片这样一个场景，图表中用到了中文字体，所以需要安装下微软雅黑字体，具体操作命令，依次如下

```
$ mkdir /usr/share/fonts/chinese
$ cp MicrosoftYaHei.ttf /usr/share/fonts/chinese/

$ mkfontscale
$ mkfontdir
$ fc-cache -fv

# 列出中文字体
$ fc-list:lang=zh
```

## Mac
```
brew install phantomjs

```
`利用brew安装最为方便`
## Windows

下载zip包解压，比如放在`D://phantomjs-2.1.1-windows`,进行环境变量配置，系统环境变量中，Path后加入`;D:\phantomjs-2.1.1-windows\bin`
