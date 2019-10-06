---
title: Surge Mac 3.0使用
tags:
  - Surge
  - Shadowsocks
  - 网络调试
abbrlink: 1f6ba7db
date: 2019-02-09 15:14:20
---
> 最近入手了Surge for Mac，
购买的直接动机是希望对网络请求有更好的管理，比如我想实现Mail客户端下，发送Gmail邮件走代理，而发送其它邮件不走代理。这个如果不用Surge能做到吗？可以，但是麻烦些，比如使用ShadowSocks配合Proxier。

有时软件多也是累赘，对于Surge大名,早有耳闻，看了下官方手册,好长。不过官网的一段介绍-`Meets All Your Personalization about Network`,清晰准确的描述了Surge的定位及解决的点。
于是乎就下单【69.99刀】，可授权设备数为3台，当然iOS版的话又是单独付费【49.99刀】，不得不说，贵！

但当你用上一段时间后，再对比同类的其它APP时，你会觉得真香！

购买地址:[戳这里`官网`](https://nssurge.com/buy_now)
支付手段:`支付宝或信用卡`

购买成功，OK，开搞吧。

## 初始化配置

Surge配置还是挺复杂的，有一定的学习门槛儿，我们最好是先利用一个模板初始化，然后根据实际情况调节即可。

启动Surge,点击设定-配置文件

![](http://static.1991421.cn/2019-02-09-7D0EFEF0-8104-4534-B370-75A8424A8DB5.png)

选择URL方式安装，[https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf](https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf)

![](http://static.1991421.cn/2019-02-09-9B56CFD9-6F57-4F85-B3EF-D98E8E13EB5A.png)

## SS代理服务器配置

上述配置安装后，点击代理，即可看到有代理服务器，这里按照实际的代理服务器地址进行修改即可。如图，我配置了多台SS服务。

![](http://static.1991421.cn/2019-02-09-070439.png)

配置完成后，点击代理服务器，连接成功，访问Google，OK，另外比如mail中， 当我们发送邮件到Gmail也显示为代理了，但是比如163就还是直连。

## 策略组[Policy Group]

这里，我增加策略组[比如叫group-auto-switch]，如下配置，这样每隔600毫秒，会去ping一下该地址，选择延迟最小的代理节点。比如哪天Macau的挂了，就会自动切换到US

![](http://static.1991421.cn/2019-02-12-132840.png)

![](http://static.1991421.cn/2019-06-16-040600.png)

`注意，测试地址别用谷歌，听说不好`

### 升级需求-临时切到某节点?
有时，有这样的需求，虽然自动切换节点很爽，但比如我现在上Apple注册美区ID，就是想美国IP访问，但这种需求是临时的，我想到的办法是，我去编辑组策略，去掉非美国节点，这是个办法，但是有更好的办法吗？有！

1. 新建策略组比如叫[group-final-select]，类型为select，策略选择，刚才的自动切换策略组，及想要的US
2. 修改Rule规则，代理部分原来是选择的group-auto-switch,全部替换为group-final-select。

![](http://static.1991421.cn/2019-06-16-042214.png)

![](http://static.1991421.cn/2019-06-16-042335.png)

注意，策略组本身也是个策略，明白这点，有益于理解。

这样，日常我们手动选择执行group-auto-switch，假如临时需要切换到US，只需要手动选择US即可。

## 增强模式
部分应用并不走系统代理，使用增强模式可以解决此问题。

比如登录Mac版电报，发现一直loading，勾选该项可以解决。当然你也可以在电报里设定下代理，但是能在一个APP中解决不是更优雅吗？

点击菜单栏，勾选增强模式

![](http://static.1991421.cn/2019-03-31-Screen%20Shot%202019-03-31%20at%2009.45.10.png)

## iCloud同步配置文件
Surge很好的支持了iCloud，建议将配置文件放在iCloud路径下，可以方便的同步到多终端设备和备份

![](http://static.1991421.cn/2019-06-16-041217.png)

## V2Ray不支持？
> 不久的以前确实如此，但是最新版`3.3.1`已经支持，并且在测试中了，还没正式版放出.想提前使用，就要更新到beta版。

![](http://static.1991421.cn/2019-10-05-145021.jpg)

选择包含beta版，点击check now，安装成功后。进入配置文件中，手动添加v2ray代理

```
v2rayProxy = vmess, xxx.xxx.com, 30544, username=xxxxxx-xx-406xe-8d63-x,tls=false
```

重新加载配置文件，就会看到新的代理配置了。

### 界面上没有v2Ray配置选项？
是的，暂时还没有，所以只能用文本编辑模式。首先支持了就是个喜大普奔的事情，别挑了，先搞起！

### IOS版如何使用

Surge iOS测试版4.1.0也加入了VMess支持，需要加入TestFlight。

相关文档：[戳这里](https://nssurge.zendesk.com/hc/zh-cn/articles/360012743714-Surge-iOS-TestFlight-%E8%AF%B4%E6%98%8E)

## 写在最后
昂，似乎到此为止，我们可以很轻松的访问了，并且加入代理服务器某个挂了，还可以自动切换。这些事都是Surge帮我们背后去做，我们无感。完美强大吧。

当然这里我也只解决了基本的科学上网，但Surge的强大远不止此，慢慢摸索吧。

## 参考文档
- https://manual.nssurge.com/
- https://github.com/lhie1/Rules
- [让人耳目一新的 Surge Mac 2.0](https://medium.com/@scomper/%E8%AE%A9%E4%BA%BA%E8%80%B3%E7%9B%AE%E4%B8%80%E6%96%B0%E7%9A%84-surge-mac-2-0-bb7cf735b1b8)
- https://medium.com/@GeekQu/surge-%E4%BD%BF%E7%94%A8%E5%B0%8F%E8%B4%B4%E5%A3%AB-d96f470fc5ce
- https://blog.nliu.work/post/20171105-surge-ssr-v2ray