---
title: 了解DDNS
tags:
  - DDNS
  - DNS
abbrlink: 6931a7f0
date: 2017-08-04 19:10:23
---

最近搞了台个`VPS`，我打算用来搭建WEB服务，但是面临的问题是VPS没有固定IP，这样就无法直接godaddy上增加域名到IP地址的解析记录了,困惑时，了解到VPS所在的服务器网络环境是有[动态DNS](https://zh.wikipedia.org/wiki/%E5%8B%95%E6%85%8BDNS),
之前不了解这个技术，所以维基了一会儿，终于搞明白了些。

`DDNS`就是为了解决动态IP问题的，原来可以利用DDNS给出一个固定的动态域名比如[aaaaaaa.asuscomm.com]绑定web服务，这样就可以直接用这个动态域名去访问。
当然正常我们搭建个web的话肯定是不希望用这个域名去直接访问的怎么办的，好办，只要在自己买的域名比如alanhe.me上增加个记录
![CNAME](//static.1991421.cn/blog/2017-08-04-112143.jpg)

如上，配置成功后，就可以使用[http://test.alanhe.me](http://test.alanhe.me)来访问自己搭建的web了。

## 总结
+ `DDNS`本身就是为了解决动态IP想要个固定域名问题
+ `DNS`记录类型
  - A记录(IP指向)
   指向的目标主机地址类型必须是IP地址
  - [CNAME(别名指向)](https://en.wikipedia.org/wiki/CNAME_record)
   可以为主机设置别名,相当于子域名来代替IP地址,如果IP地址变化，只需要改动子域名的解析
  - MX
   邮件交换记录
   
相关文章:[什么是域名解析中A记录、CNAME、MX记录、NS记录](https://www.douban.com/note/523329196/)
