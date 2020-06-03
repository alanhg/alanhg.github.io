---
title: 项目引入WebSocket-集群场景
date: 2020-06-03 22:55:08
tags:
- Cluster
- Redis
- WebSocket
---

> 最近站点上了WebSocket,紧接面临的问题是Web服务集群下WS的通讯问题。Web服务多实例的情况下，假如A用户访问订阅了A服务的WS频道，但是B服务在后台发起了广播，实际上A用户是收不到消息的。于是问题来了,集群场景下，广播，单个用户准确发消息呢。


## Tech Stack
首先，介绍下当前项目的技术栈

- React `v16.4.2`
- SpringBoot `v2.1.6.RELEASE`

## 解决方案

 Redis实现用户信息共享，同时Redis实现消息订阅广播即可。
 
 具体代码如何写呢？不啰嗦，[戳这里](https://github.com/alanhg/spring-websocket-demo)
 
### 大致流程
- 用户访问连接WS，redis存储用户信息，集群实例都连接了redis，所以理论上都可以拿到所有用户信息
- 假如要点对点发送消息，唤起redis广播，所有实例redis服务都会收到消息，根据目标UID去找，满足即可发送
- 假如要广播，唤起redis广播，所有实例redis服务都会收到消息，进而都会发送消息，这样所有用户都会收到了。



![](http://static.1991421.cn/2020/2020-06-03-232111.jpeg)


### 是否有必要增加Kafka，MQ

网上搜索websocket集群方案，很多都聊到了增加消息队列。当前我在项目中并没有用到，个人认为，假如用量不大，Redis足矣。


## 写在最后

其实想想，假如没有集群，也就谈不上有这个问题的存在。

那为什么一定要搞集群呢，集群是将服务实例物理增加，以更多的Client提供服务，服务内容相同，但同时却也带来了问题，如文章一开始提到的问题。面对这样的问题，Redis这种NoSQL存储服务暴露给多个Client便就可以解决这个问题。

前因后果大致如此，抛砖引玉。


## 参考文档

- [Using Spring Boot for WebSocket Implementation with STOMP](https://www.toptal.com/java/stomp-spring-boot-websocket)
- [springboot websocket集群]( https://blog.inslee.cn/2020/05/12/springboot/websocket2.html)
- [springboot websocket](https://blog.inslee.cn/2020/05/12/springboot/websocket.html)
 
 
 

 
 
 