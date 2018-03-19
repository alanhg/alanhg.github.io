---
title: http请求中的referer
abbrlink: b541df7e
date: 2018-03-19 23:18:37
tags:
- HTTP
---
> 之前系统与其它站点对接，实现登录鉴权用到了referer，所以这里总结下

## 什么是referer头
HTTP referer是HTTP头部字段中的一项，告诉服务器，我是从那个页面链接过来的，服务器由此来进行特定的处理。
比如我的系统支持从A网站过来的链接，从而免登陆。那么我就需要判断referer。

## window.open打开的链接请求有referer吗
测试证明IE会丢失referer的，Edge可以，Chrome更可以。所以如果是站点需要携带referer的话，建议换个方式，比如location或者直接超链接。

## 相关资料
+ https://en.wikipedia.org/wiki/HTTP_referer
+ https://75team.com/post/everything-you-could-ever-want-to-know-and-more-about-controlling-the-referer-header-fastmail-blog.html