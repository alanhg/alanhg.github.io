---
title: WebSocket读书记
date: 2020-04-19 16:31:02
tags:
- WebSocket
- Reading
---
> 最近项目中用到了WebSocket，但个人对WS的认知太过空白，于是花了点时间阅读了相关书籍[《WebSocket》](https://www.amazon.cn/dp/B015D78JVQ/ref=sr_1_4?keywords=websocket&qid=1587293374&sr=8-4)。对于其中的一些收获，这里Mark下

![](http://static.1991421.cn/2020/2020-04-19-194807.jpeg)

## WebSocket的使命
技术的推出一定是为解决一个问题，就类似于ES推出了promise，是为了解决回调问题，XHR为了提供异步交互。WebSocket伴随着HTML5的推出，是为了让WEB与后端具备双工通讯能力。在WS之前，我们只能通过轮询解决，并且发起方只能是客户端。

因为有了WebSocket,我们的WEB和后端，你可以主动给我发消息，我也可以主动给你发消息。这就是它的使命。


## TTL，SSL，HTTPS
谈到通讯，就一定会谈到安全，对于WebSocket，也会有WS和WSS之分。在HTTPS下的WS即是WSS。
那么我们常说起的TTL，SSL，HTTPS又都是什么呢

- 传输层安全性协议（英语：Transport Layer Security，缩写：TLS）及其前身安全套接层（英语：Secure Sockets Layer，缩写：SSL）是一种安全协议，目的是为互联网通信提供安全及数据完整性保障。
- HTTPS协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，要比HTTP协议安全
- HTTPS，也称作HTTP over TLS

![](http://static.1991421.cn/2020/2020-04-19-164130.jpeg)

## WebSocket,SockJS,STOMP
- HTML5开始提供的一种浏览器与服务器进行全双工通讯的网络技术，属于应用层协议。它基于TCP传输协议，并复用HTTP的握手通道。
- WebSocket是一种网络传输协议，可在单个TCP连接上进行全双工通信，位于OSI模型的应用层。
- SockJS是一个浏览器JavaScript库，它提供了一个类似于网络的对象。SockJS提供了一个连贯的、跨浏览器的Javascript API，它在浏览器和web服务器之间创建了一个低延迟、全双工、跨域通信通道。一些浏览器中缺少对WebSocket的支持,因此，回退选项是必要的，而Spring框架提供了基于SockJS协议的透明的回退选项。SockJS的一大好处在于提供了浏览器兼容性。优先使用原生WebSocket，如果在不支持websocket的浏览器中，会自动降为轮询的方式。除此之外，spring也对socketJS提供了支持。
- STOMP是一个协议，因为WebSocket并不规定具体的通讯内容格式，而STOMP制定了格式。

我当前的项目中使用的技术栈是React+SpringBoot, 所以最终WebSocket+SockJS+STOMP都使用。

## OSI七层模型
`Open System Interconnection Model`

这个知识点印象是大学期间，`《计算机网络》谢希仁书`中提到的,早已经忘的差不多了，但看书时，提及应用层，有点生疏，索性复习下这些基础知识。

![](http://static.1991421.cn/2020/2020-04-19-164957.jpeg)


### 注意

- OSI七层模型只是概念
- 实际的应用实际上不是7层，是5层，废弃了`表示层，会话层`


## WebSocket与HTTP的交集
WebSocket连接，订阅，发送，接收消息，到断开连接，这中间并不只有WebSocket协议，还是会有HTTP协议的存在。


![](http://static.1991421.cn/2020/2020-04-19-191659.jpeg)

- 连接使用的还是HTTP GET请求
- 紧接着建立了WebSocket连接，即双工通讯链接，在这个连接里，我们接发消息。注意状态码是101
- 所以单个连接，总共会发起两个请求，1个是HTTP，一个是WebSocket


### 常用状态码
HTTP Status 的5个状态码段，大家都知道，但是实际使用中，至少在平时的restful前后端通讯中，1xx段确实没有遇到过，而这里却看到了。

#### 101
> HTTP  101 Switching Protocol（协议切换）状态码表示服务器应客户端升级协议的请求（Upgrade请求头）正在进行协议切换。服务器会发送一个Upgrade响应头来表示其正在切换过去的协议。

## HTTP 0.9 - Web诞生

不清楚互联网历史甚是不对。之前没有留意到还有HTTP 0.9，这里补充下历史

1. HTTP最早诞生的版本是0.9，于1991年提出，OK，与我同年生，这样好记忆多了
2. 0.9只支持GET，到1.0的时候才发展出POST，PUT等
3. 当前主流的是1.1，2.0增加的是多路复用等，可以注意到很多站点都已经开启了2.0支持，当然我的站点就是
4. HTTP/3 是即将到来的第三个主要版本的HTTP协议，使用于万维网。在HTTP/3中，将弃用TCP协议，改为使用基于UDP协议的QUIC协议实现。但注意到3动了底层，所以推广应用起来一定会比2慢

![](http://static.1991421.cn/2020/2020-04-19-194115.jpeg)


## 写在最后

1. 当前的认知还是很肤浅的，唯有继续在实际使用中不断去校对认知，学习。
2. 不得不说这本书讲的还是很细致的，所有的基本点都有所讲解
3. 在读这本书的同时，刚好看到一篇文章在讲读书的价值，我想读书的价值就是填补自己的认知空白，同时得到了机会与牛人进行隔空交流，一点不为过。


## 参考文档

- [在vue中使用SockJS实现webSocket通信](https://juejin.im/post/5b7fd02d6fb9a01a196f6276)
- [OSI模型](https://zh.wikipedia.org/wiki/OSI%E6%A8%A1%E5%9E%8B)
- [http 发展史 (http0.9、http1.0、http1.1、http2、http3) 梳理笔记](https://www.chainnews.com/articles/401950499827.htm)
