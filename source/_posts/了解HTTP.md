---
title: 了解HTTP
tags:
  - HTTP
abbrlink: '16e51059'
date: 2021-03-03 22:57:32
---
> 作为前端developer总是要经常查看networks，HTTP请求不可避免要接触，但一直缺乏系统的学习，于是查询这里梳理下，加深下记忆。

## HTTP定义

> 超文本传输协议（英语：HyperText Transfer Protocol，缩写：HTTP）是一种用于分布式、协作式和超媒体信息系统的应用层协议HTTP是万维网的数据通信的基础。HTTP协议是1989年发起的，当前标准由万维网协会（World Wide Web Consortium，W3C）和互联网工程任务组（Internet Engineering Task Force，IETF）进行协调发布。

需要知道

1. HTTP是个已有30多年的历史的协议
2. HTTP通常建立在TCP/IP协议之上，但HTTP协议中并没有规定它必须使用或支持的层。因此HTTP可以在任何互联网协议或其它网络上实现
3. HTTP请求的发起端不一定是在浏览器，爬虫或者其他工具均可

## HTTP版本历史

当前HTTP2已是主流但有必要了解HTTP协议的发展历程，从而更好的熟悉它。

- ~~HTTP/0.9~~
  - 只接受get请求，没有指定版本号在请求行
- ~~HTTP/1.0~~
  - 第一个指定版本号版本
  - 支持HEAD , POST方法
  - 头部字段支持，请求体内容类型，响应体状态码等支持
  - 强缓存，If-Modified-Since,Expires
- HTTP/1.1
  - 支持GET , HEAD , POST , PUT , DELETE , TRACE , OPTIONS方法
  - 长连接支持，默认开启，
    - 因为有了长连接，我们可以做到一个TCP连接下可以顺序发起多个请
    - 长连接在空闲一段时间后即会关闭
    - 流水线连接确保了请求可以连续被发起，不需要等待上一个请求的返回，进一步提升请求效率，但在HTTP/1.1下是不被默认启用的
  - 压缩/解压送，协商缓存等性能优化支持
  - host头处理
- HTTP/2
  - 多路复用
    - 严格意义上做到了同一时刻可以多个请求同时在执行，真正的并发
  - 服务端推送
  - header压缩
- *HTTP/3*处于草案阶段
  - 底层协议由TCP换成基于UDP的QUIC
  - 缩短连接建立时间

![](https://static.1991421.cn/2021/2021-03-04-202056.jpeg)



需要知道

1. 大量的WEB还处于1.1到2的升级过程中
2. 任何HTTP协议，比如HTTP2支持需要WEB本身容器如nginx及访问终端如chrome支持
   - 因此比如HTTP3还属于草案，如果想尝鲜既需要在容器上配置支持该协议，也需要安装比如Chrome canary开启QUIC才可以尝鲜
3. TLS即HTTPS在HTTP1.1上也支持，并非需要一定是2
4. 部分WEB已经支持了HTTP3，比如YouTube
   - 测试站点是否支持3，可以使用该工具https://gf.dev/http3-test

## Chrome DevTools中的HTTP请求

正如一开始所说前端不可避免要多接触HTTP请求，而查看请求的终端最多的就是Chrome，借助于Chrome的我们也可以一方面的多了解HTTP，一方面更了解WEB在执行HTTP请求时的一些机制问题。

1. 如上HTTP2的多路复用下我们可以连续发起多个请求，也就是同一时刻可以有多个请求存在，但是请求的量是有限制的

   - 就Chrome而言，单个域名下连接数量上限是6个，总量上限是10个

   - 因为同一个域名下连接复用，因此TCP连接ID一致，在network下的connectionID即是

     ![](https://static.1991421.cn/2021/2021-03-04-002510.jpeg)

2. 有时会看到一些请求的status是canceled，原因是这些请求在处理中，而刷新页面会造成请求中断，JS执行上下文中断，因此会报该错误，这是浏览器端报错而非服务端报错



## HTTPS解密抓包

随着Chrome对HTTPS的大力推广，可以看到大多数网站都已上了HTTPS，如果是本身在浏览器即客户端下查看HTTPS请求数据的话，与HTTP没什么不同，但是如果想分析App中发起的HTTP请求的话，明显App本身是不提供界面的，这时就需要代理软件来拦截流量，从而抓包分析了。但抓包之后会发现一堆二进制数据看不懂，原因即是这个TLS的功劳，如何也想浏览器那样可以正常查看数据呢，需要解决的是证书。



由于HTTPS的认证机理中有一步根证书是从系统中获取，而如果我们自行签署了一个证书做到系统认证安全，那么就可以拿着这个证书进行正常的加密解密，从而解析了HTTPS的内容。当然这个方式并不是所有的站点请求都可用，因为如果服务端只认证指定签发的证书，那么即无效。



![](https://static.1991421.cn/2021/2021-03-04-004208.jpeg)



![](https://static.1991421.cn/2021/2021-03-04-003501.jpeg)



## 写在最后

寥寥数笔，权当学习回顾了。



## 参考文档

- https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE
- https://imququ.com/post/how-to-decrypt-https.html
- https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Connection_management_in_HTTP_1.x
