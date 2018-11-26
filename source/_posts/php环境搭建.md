---
title: php环境搭建
tags:
  - php
abbrlink: 99b764b5
date: 2017-10-02 22:28:32
---
> 关于语言孰优孰略，吵来吵去，甚是无聊，语言是工具，语言的背后是思想，对你口，合适即可。
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

当然，XAMPP、wampserver也可以

## Mac
从 OS X 10.0.0 版本开始，PHP 作为 Mac 机的标准配置被提供。原文看[这里](http://php.net/manual/zh/install.macosx.bundled.php),但是如果直接浏览器访问，会报以下错误。
![](//static.1991421.cn/blog/2017-10-03-86D27F6433EFDC3E188CCD07D6519A7B.jpg)
![](//static.1991421.cn/blog/2017-10-03-ED7F19B676EE1E40A05ABDAC5A41C737.jpg)
所以建议仍然重新安装php,执行以下命令，然后在phpstorm下进行配置即可。
`curl -s http://php-osx.liip.ch/install.sh | bash -s 5.6`
![](//static.1991421.cn/blog/2017-10-03-093521.jpg)
再次浏览器访问页面，就OK了。

## Apache配置
php项目运行需要在Apache下，直接配置路径，运行会报403错误，还需要一些配置,如下为修改后的配置，改动前，建议备份原配置文件

```
<Directory />
    Options  Indexes  FollowSymLinks
    AllowOverride None
   Order deny,allow
    Allow from all
</Directory>


DocumentRoot "/Users/juliana/newsp/testing/Test/www"
<Directory "/Users/juliana/newsp/testing/Test/www">
    #
    # Possible values for the Options directive are "None", "All",
    # or any combination of:
    #   Indexes Includes FollowSymLinks SymLinksifOwnerMatch ExecCGI MultiViews
    #
    # Note that "MultiViews" must be named *explicitly* --- "Options All"
    # doesn't give it to you.
    #
    # The Options directive is both complicated and important.  Please see
    # http://httpd.apache.org/docs/2.4/mod/core.html#options
    # for more information.
    #
    Options FollowSymLinks Multiviews
    MultiviewsMatch Any


    #
    # AllowOverride controls what directives may be placed in .htaccess files.
    # It can be "All", "None", or any combination of the keywords:
    #   AllowOverride FileInfo AuthConfig Limit
    #
    # AllowOverride None
      AllowOverride All


    #
    # Controls who can get stuff from this server.
    #
    Require all granted
</Directory>
```




