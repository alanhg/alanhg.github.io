---
title: php环境搭建
tags:
  - php
abbrlink: 99b764b5
date: 2017-10-02 22:28:32
---
> 关于语言谁好的问题，吵来吵去，甚是无聊，语言是工具，语言的背后是思想，对你口，合适即可。
客观来说，php也是优秀的语言，繁荣这么多年，差不到哪。

> 由于一些老项目是php开发的，必须保证开发机具备PHP环境，所以这里将php环境搭建记录下

## Windows

推荐使用`phpstudy`,[下载地址](http://www.phpstudy.net/)

注明:phpstudy没有mac版

phpstudy直接继承了
+ Apache
+ PHP
+ .ect

通过安装该工具，直接快速搞定环境问题。

## Mac
从 OS X 10.0.0 版本开始，PHP 作为 Mac 机的标准配置被提供。原文看[这里](http://php.net/manual/zh/install.macosx.bundled.php),但是如果直接浏览器访问，会报以下错误。
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-03-86D27F6433EFDC3E188CCD07D6519A7B.jpg)
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-03-ED7F19B676EE1E40A05ABDAC5A41C737.jpg)
所以建议仍然重新安装php,执行以下命令，然后在phpstorm下进行配置即可。
`curl -s http://php-osx.liip.ch/install.sh | bash -s 5.6`
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-03-093521.jpg)
再次浏览器访问页面，就OK了。


