---
title: Surge Mac 3.0使用
date: 2019-02-09 15:14:20
tags:
- Surge
- Shadowsocks
---
> 最近入手了surge for Mac，还挺贵的
购买的动机是希望对网络请求有更好的管理，比如我想实现Mail客户端下，发送Gmail邮件走代理，而发送其它邮件不走代理。这个如果不用Surge能做到吗？可以，但是麻烦些，比如使用ShadowSocks配合Proxier。

有时软件多也是累赘，对于Surge大名,早有耳闻，看了下官方手册,好长。不过官网的一段介绍-`Meets All Your Personalization about Network`,清晰准确的描述了Surge的定位及解决的点。
于是乎就下单483.42 ¥，可授权设备数为3台，当然iOS版的话又是单独付费，不得不说，贵！

## 初始化配置

Surge配置还是挺复杂的，最好是先利用一个模板初始化，然后根据实际情况调节即可。

启动Surge,点击设定-配置文件

![](http://static.1991421.cn/2019-02-09-7D0EFEF0-8104-4534-B370-75A8424A8DB5.png)

选择URL方式安装，[https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf](https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf)

![](http://static.1991421.cn/2019-02-09-9B56CFD9-6F57-4F85-B3EF-D98E8E13EB5A.png)

## SS代理服务器配置

上述配置安装后，点击代理，即可看到有代理服务器，这里按照实际的代理服务器地址进行修改即可。如图，我配置了多台SS服务。

![](http://static.1991421.cn/2019-02-09-070439.png)

配置完成后，点击代理服务器，连接成功，访问Google，OK，另外比如mail中， 当我们发送邮件到Gmail也显示为代理了，但是比如163就还是直连。


## 写在最后
教程仅仅是抛砖引玉，这里我也只解决了基本的科学上网，但Surge的强大远不止此，需要慢慢摸索了。

## 参考文档
- https://nssurge.com/
- https://github.com/lhie1/Rules
- [让人耳目一新的 Surge Mac 2.0](https://medium.com/@scomper/%E8%AE%A9%E4%BA%BA%E8%80%B3%E7%9B%AE%E4%B8%80%E6%96%B0%E7%9A%84-surge-mac-2-0-bb7cf735b1b8)