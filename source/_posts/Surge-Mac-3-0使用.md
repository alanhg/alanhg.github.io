---
title: Surge Mac 3.0使用指南
tags:
  - Surge
  - 网络调试
abbrlink: 1f6ba7db
date: 2019-02-09 15:14:20
---
> 最近入手了Surge for Mac，
购买的直接动机是希望对网络请求有更好的管理，比如我想实现Mail客户端下，发送Gmail邮件走代理，而发送其它邮件不走代理。这个如果不用Surge能做到吗？可以，但是麻烦些，比如使用ShadowSocks配合Proxier。

有时软件多也是累赘，对于Surge大名,早有耳闻，看了下官方手册,好长。不过官网的一段介绍-`Meets All Your Personalization about Network`,清晰准确的描述了Surge的定位及解决的点。
于是乎就下单【69.99刀】，可授权设备数为3台，当然iOS版的话又是单独付费【49.99刀-授权设备数3为台】，不得不说，贵！

但当你用上一段时间后，对比同类的其它APP时，你会发现真香！

购买地址:[戳这里`官网`](https://nssurge.com/buy_now)
支付手段:`支付宝或信用卡`
购买建议:	网页购买，`不要App内购`，因为网页购买直接可以得到license key和绑定邮箱，内购的需要90天后才可以绑定，不要小看这个邮箱，比如想加入测试或者，多设备注册就需要啊
购买成功，OK，开搞吧。



## 下载
[官方下载](https://nssurge.com)，注意Surge Mac版App Store并不提供，仅有[iOS版](https://apps.apple.com/us/app/surge-3/id1442620678?ls=1)

## 初始化配置

Surge配置还是挺复杂的，有一定的学习门槛儿，我们最好是先利用一个模板初始化，然后根据实际情况调节即可。

启动Surge,点击设定-配置文件

![](https://i.imgur.com/n5fXleE.jpg)

选择URL方式安装，[https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf](https://raw.githubusercontent.com/lhie1/Surge/master/Surge.conf)

![](https://i.imgur.com/1QLXdmt.jpg)

## 代理服务器

上述配置安装后，点击代理，即可看到有代理服务器，这里按照实际的代理服务器地址进行修改即可。如图，我配置了多台SS服务。

![](https://i.imgur.com/07jM5Oy.jpg)

配置完成后，点击代理服务器，连接成功，访问Google，OK，另外比如mail中， 当我们发送邮件到Gmail也显示为代理了，但是比如163就还是直连。

- SS已经成为过去式，建议不要搭建或购买SS服务

### V2Ray支持
> Mac版自`3.3.1`，iOS版自`4.1.0`,已经支持

#### 配置格式

```
v2rayProxy = vmess, xxx.xxx.com, 30544, username=xxxxxx-xx-406xe-8d63-x,, tls=true, ws=true, ws-path=/helloMario

```

### Trojan支持
> Yes,`3.4`已经支持

#### 配置格式

```
ProxyTrojan = trojan, 192.168.20.6, 443, password=password1
```

### 免费代理节点？
我们下载的配置文件中的代理肯定是不能用的，那个只是个例子而已。部分同学问我为啥代理不起作用。。。。OK，那个本来就不可用。有免费的代理节点吗？OK，确实存在，请自行查找。

`但免费的午餐是不靠谱的，也是有其它代价的，比如时间，比如隐私。`

推荐一个✈️和自行搭建的VPS服务商

#### Vultr

<a href="https://www.vultr.com/?ref=8363373"><img src="https://www.vultr.com/media/banners/banner_468x60.png" width="468" height="60"></a>

服务购买，[戳这里](https://www.vultr.com/?ref=8363373)

推荐Docker搭建V2Ray,[参考这里](https://github.com/alanhg/v2ray-docker)

#### Shadowsocks
支持Trojan，[戳这里](https://portal.shadowsocks.nz/aff.php?aff=27252)

`要知道，SS时代已经过去，现在相对稳定的是V2Ray和Trojan`

## 代理规则[Policy Rules]
### 境外走代理，境内走直连
一味的增加规则，对特定域名站点加入代理很繁琐，并且规则的增加会导致解析速度变慢，所以可以通过设定CN的走直连，默认的走代理。操作如下

![](https://i.imgur.com/FqDJFeK.png)

## 策略组[Policy Group]

这里，我增加策略组[比如叫group-auto-switch]，如下配置，这样每隔600毫秒，会去ping一下该地址，选择延迟最小的代理节点。比如哪天Macau的挂了，就会自动切换到US

![](https://i.imgur.com/wGKgsHi.jpg)

![](https://i.imgur.com/ZZ11Tm3.jpg)

`注意，测试地址别用谷歌，听说不好`

### 升级需求-临时切到某节点?
有时，有这样的需求，虽然自动切换节点很爽，但比如我现在上Apple注册美区ID，就是想美国IP访问，但这种需求是临时的，我想到的办法是，我去编辑组策略，去掉非美国节点，这是个办法，但是有更好的办法吗？有！

1. 新建策略组比如叫[group-final-select]，类型为select，策略选择刚才的自动切换策略组，及想要的US代理
2. 修改Rule规则，代理部分原来是选择的group-auto-switch,`全部替换`为group-final-select。

![](https://i.imgur.com/us5Sj0O.jpg)

![](https://i.imgur.com/basBHp5.jpg)

注意，策略组本身也是个策略，明白这点，有益于理解。

这样，日常我们手动选择执行group-auto-switch，假如临时需要切换到US，只需要手动选择US即可。

## 系统代理
### 系统代理与VPN并存?
可以，需要执行以下配置,将内网域名填写上。这样即可内网解析及代理外网解析同时work。

```
[Host]
internal.example.com = server:syslib
```

surge官方给出了完整解答，[戳这里](https://nssurge.zendesk.com/hc/zh-cn/articles/900000519943-Surge-Mac-%E4%B8%8E-VPN-%E4%B8%80%E5%90%8C%E4%BD%BF%E7%94%A8)

注意：如果需要匹配多个子域名，使用`*.example.com`，但不要使用`example.com`，测试后者写法会有时不work。



## 增强模式

部分应用并不走系统代理，使用增强模式可以解决此问题。

比如登录Mac版电报，发现一直loading，勾选该项可以解决。当然你也可以在电报里设定下代理，但是能在一个APP中解决岂不更优雅？

点击菜单栏，勾选增强模式

![](https://i.imgur.com/WhIZ9fz.jpg)

### 增强模式下，连接其它VPN？
比如我远程办公时需要使用OpenConnect连接公司VPN，而Surge的增强模式会让所有应用都走代理，本身两者是冲突的。因此增强模式打开的情况下，是连不上公司VPN之类的。所以需将增强模式关闭。

而增强模式如果关闭了，Mail，或者电报就需要单独配置代理，从而科学上网？

1. Mail客户端可以根据增加ProcessName类型的Rule进行解决

	![](https://i.imgur.com/BflPx2b.png) 
2. Telegram通过配置Rule无法解决，但App本身提供了代理设定
	
	Setting => Data and Storage => Proxy
	
	![](https://i.imgur.com/7z6dyzO.png)

所以，假如需要同时连接公司VPN等，增强模式需要关闭



## iCloud同步配置文件
Surge很好的支持了iCloud，建议将配置文件放在iCloud路径下，可以方便的同步到多终端设备和备份

![](https://i.imgur.com/4z1TiKH.jpg)

### iOS同步配置
iOS端需要设定同步，more=》Profile Sync，从iCloud中导入Profile即可完成同步化。


## HTTPS内容抓包

![](https://i.imgur.com/O7U6lLs.png)

![](https://i.imgur.com/1Xp2e33.png)


三步配置后，在dashboard中，即可看到解密后的请求报文和响应报文了。

![](https://i.imgur.com/3arYobO.png)


## 测试版尝鲜

### iOS

iOS测试版想使用，需要加入TestFlight。如果是Web邮箱注册进行的购买，按照以下操作。

1. 登陆Surge网站
2. 点击Apply TestFlight
3. 手机访问邀请网址，会跳转到下载TestFlight app
4. 然后选择更新surge到测试版即可

内购版的就麻烦些，需要等90天，在app license栏目下，绑定邮箱，这时就会得到license key，然后按照上面步骤进行即可。

相关文档：[戳这里](https://nssurge.zendesk.com/hc/zh-cn/articles/360012743714-Surge-iOS-TestFlight-%E8%AF%B4%E6%98%8E)


### Mac

![](https://i.imgur.com/H0Sn9Dd.png)

选择包含beta版，点击check now，安装成功后

## 还有疑问？
1. 官方论坛 https://community.nssurge.com/
3. 邮件作者 `support@nssurge.com`
4. 博客下评论，或者直接邮件我，乐意分享我的知识

## 写在最后
昂，似乎到此为止，我们可以很轻松的访问了，并且加入代理服务器某个挂了，还可以自动切换。这些事都是Surge帮我们背后去做，我们无感。完美强大吧。

当然这里我也只解决了基本的科学上网，但Surge的强大远不止此，慢慢摸索吧。

## 参考文档
- https://manual.nssurge.com/
- [Surge Mac Release Note](https://nssurge.zendesk.com/hc/zh-cn/sections/360000031193-Release-Note)
- https://github.com/lhie1/Rules
- [让人耳目一新的 Surge Mac 2.0](https://medium.com/@scomper/%E8%AE%A9%E4%BA%BA%E8%80%B3%E7%9B%AE%E4%B8%80%E6%96%B0%E7%9A%84-surge-mac-2-0-bb7cf735b1b8)
- https://medium.com/@GeekQu/surge-%E4%BD%BF%E7%94%A8%E5%B0%8F%E8%B4%B4%E5%A3%AB-d96f470fc5ce
- https://blog.nliu.work/post/20171105-surge-ssr-v2ray
- [使用 Surge iOS 以及 Surge Mac 开启 MitM 配置 CA 证书抓包 Https 内容](https://blog.wttft.com/201809101/)
