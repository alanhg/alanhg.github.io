---
title: Switch导出游戏截图
tags:
  - 搞机
  - 游戏
abbrlink: 4d0b6f75
date: 2018-10-04 12:15:32
---
> 最近玩Nintendo Switch，想把游戏截图导出，为此小折腾一番

How? 摆在面前的办法有两个

1. 存储卡
2. 分享到推特或脸书，用[ifttt](https://ifttt.com/)推到相册。

方法1，每次需要Switch抠卡，连电脑，去传数据，这样多不爽了，`非常不程序猿`，所以选择方案2.
怎么做呢
### Switch得能上谷歌`你懂得`
网上有建议把电脑下的SS设置允许局域网连接，然后在Switch下的网络设置代理，从而解决Switch可以发推，我试了下没成功，另外这种方案的问题是Switch网络依赖了某台笔记本网络，这也不怎么爽，索性干脆点，直接解决了路由器，不更好？这样手机在家也不用开小火箭了。所以要刷机路由器，让路由器层直接代理了外网请求-即路由器装梯子。

好了，一个纯粹&&质朴&&天真无邪的发张游戏截图的需求就被放大到了如何让路由器可以带梯子访问邪恶的外部网站这个大问题了。这点非常程序猿。

#### 我是怎么解决的

我家里目前用的是小米路由器3，查了下，需要刷开发版ROM，解决SSH，然后安装SS即可。教程看这里

```
1. https://gist.github.com/rambolee/468ee988d2cf80224a6ac4675c141b4f

2. http://poodar.me/_______________-3-______-Shadowsocks/可
```
注意，最新版的小米开发版是刷机不成功的，直接用第一篇文章里作者贴的资源版本即可。

照着上面的两个教程，解决了路由器，这样我们网络问题解决了，同时在家手机登其它设备也方便了，完美。

### IFTTT
ifttt是个自动化神器，辅助完成推特中的游戏截图推动到iOS相册这部分工作。

1. ifttt注册账户
2. 配置applets
3. iPhone下载ifttt-app【国区也有】
4. Switch绑定twitter账户
5. 发推，查看手机相册
	
- applets配置如下图	
![](https://static.1991421.cn/2018-10-04-ifttt.com_applets_86419437d-if-new-tweet-by-alanhe421-with-hashtag-nintendoswitch-then-add-photo-to-album_edit.png)
- ifttt活动-每次Switch发推即触发
![](https://static.1991421.cn/2018-10-04-041122.png)

## 写在最后
折腾了下，以后想要手机截图就只需要Switch发推即可,另外之前一直吃灰的Echo Dot也可以用了。。。
贴张游戏截图
![](https://static.1991421.cn/2018-10-04-041833.png)

