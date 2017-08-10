---
title: 邮件中HTML锚点链接
tags:
  - email
abbrlink: faebe2a0
date: 2017-08-10 20:55:11
---
> 
平时我们订阅的新闻邮件，都会特别漂亮，这种带格式的Email其实可以理解为一个网页，官方名称叫做[HTML Email](https://en.wikipedia.org/wiki/HTML_email)。
查官方定义可以看到这就是HTML的子集，那么这类邮件能否正常显示，其实就取决于我们的邮箱客户端，等同于我们平时进行的web开发会存在浏览器兼容性问题。

最近同事在做电子邮件模板的时候，用到了锚点，发现安卓邮箱客户端点击正常，而IOS的官方邮箱客户端点击无反应，iOS的QQ客户端点击锚点链接解析有问题,跳转路径变成了手机文件系统的路径，看来是客户端对于HTML Email中的锚点支持情况不一。
![HTML Anchor](http://or0g12e5e.bkt.clouddn.com/blog/2017-08-10-133346.jpg)
## 邮箱客户端对于锚点支持情况
经过查询和测试，总结如下。

邮箱客户端 | 支持情况
---- | ---
Gmail (Web) | YES
Gmail (Android app) |  YES
Inbox by Gmail (Android app) | YES 
Gmail (iOS app) | NO
Apple Mail (iOS) | NO
Apple Mail (Mac) | YES
Yahoo! Mail(Web) | YES
Outlook.com (Web) | NO
Outlook (Android app) |	NO
Outlook (desktop) | YES
Outlook (Mac) | NO
QQ Mail (iOS) | NO

## 引用资料
+ http://www.ruanyifeng.com/blog/2013/06/html_email.html
+ https://emaildesign.beefree.io/2016/09/how-to-add-anchor-links-in-email/
