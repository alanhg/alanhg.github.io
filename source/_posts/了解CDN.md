---
title: 了解CDN
tags:
  - 性能优化
  - 缓存
abbrlink: 3d406863
date: 2021-04-17 23:21:15
---

> WEB为了性能，可以上CDN，但是你真的了解CDN吗，这里梳理下原理，强化理解。



## 概念

> **内容分发网络**（英语：**C**ontent **D**elivery **N**etwork或**C**ontent **D**istribution **N**etwork，缩写：**CDN**）是指一种透过[互联网](https://zh.wikipedia.org/wiki/互聯網)互相连接的电脑网络系统，利用最靠近每位用户的服务器，更快、更可靠地将音乐、图片、视频、应用程序及其他文件发送给用户，来提供高性能、可扩展性及低成本的网络内容传递给用户。

以上摘自WIKI，作为基本概念了解，接下来理解下CDN的实现原理



## 原理



![](https://static.1991421.cn/2021/2021-04-17-235549.jpeg)



如上图，可以看出CDN服务实现的关键技术



1. `CNAME`，我们在配置CDN资源时，网页中配置的并非CDN服务提供我们的域名，而是自定义域名，而自定义域名实际上是作为CDN资源域名的一个别名存在
2. CDN服务需要有一个自己的`DNS`，因为域名解析为IP需要
3. 具备负载均衡的能力(Global Sever Load Balance 简称`GSLB`)，平常我们域名解析IP，可以理解为两者都是静态的，而为了具备负载均衡的能力，实际上DNS解析为IP变成了动态的过程，这样可以返回最合适的CDN节点IP，从而让用户就近访问



OK，那么这样，CDN就理解了。



## DNS-prefetch

由上可知，域名到IP需要时耗，为了提升速度，WEB中我们可以对这些跨域的静态资源进行预DNS解析，为什么这样做就可以快呢，因为Chrome会开启专门的线程做DNS-prefetching。

> 普遍来说合理的dns prefetching能对页面性能带来50ms ~ 300ms的提升，[有人](https://blog.secure64.com/?p=367)做了这方面的统计



```html
<link rel="dns-prefetch" href="//static.1991421.cn">
```



## CDN的好处

CDN最终为用户提供了良好的资源访问速度，但实际使用上，除了这点好处还很多，比如也可以节约带宽，非同源站点，资源都需要重复加载，而我们CDN作为第三方资源本身也可以避免了资源的重复加载浪费。



## 写在最后

知其然，知其所以然，才有意思，也才可以更好的驾驭技术。



## 参考链接

- https://tech.youzan.com/dns-prefetching/



