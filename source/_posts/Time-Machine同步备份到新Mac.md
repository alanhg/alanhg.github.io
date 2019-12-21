---
title: Time Machine同步备份到新Mac
abbrlink: 1a70de77
date: 2019-12-21 12:04:18
tags:
- Time Machine
- MacBook Pro
---
> 最近剁手了MacBook Pro16寸，正好体验了一下Time Machine同步备份到新Mac,期间也不是特别顺利，这里总结下，兴许帮到些朋友。

## 准备工作
- 群晖NAS `Time Machine`，备份的镜像是我的原机器 MacBook Pro 2015 `MacOS 10.14 Mojave`
- 目标机器 MacBook Pro 2016 `macOS 10.15 Catalina`
- NAS与Mac同在局域网内

## 开始Time Machine同步
启动新Mac，会有提示界面,依次选择想同步的资料即可。经过大致几个小时【我这里花费4小时】的同步即结束。

![](http://static.1991421.cn/2019-12-21-124532.jpg)

![](http://static.1991421.cn/2019-12-21-125059.png)

### 注意点
1. `原系统与目标系统版本可以不一致`，我这里就是`10.14=>10.15`
2. 选择NAS的Time Machine准备同步时，如果出现报错`No Volumes found in backup`，请尝试以下解决办法：重试，考虑关闭原Mac机器与NAS的连接状态

   ![](http://static.1991421.cn/2019-12-21-124645.png)

## 同步结束

同步完成，新Mac不需要一点设定就可直接完美直接使用了？

`NO`,新Mac同步完成后，基本OK，但仍有一些问题及设定需要操作。

1. 新设备Apple ID账户信息需要手动登陆
2. APP的安全设定仍然需要每个单独设定打开
3. 部分APP同步过来后不能正常启动使用，比如我的微信出现了问题，解决办法重装
4. 部分需要license激活的APP，因为毕竟是新设备，所以仍然需要重新激活
5. 网络出现问题，连接Wi-Fi成功，但上不去网，解决办法是网络添加新location,重新连接即可

## 写在最后
以前拿到一个新Mac，总是需要从零开始配置，作为一个码农，重新搭建环境简直是个噩梦。如今有了NAS的Time Machine，不得不说，同步资料到新Mac的体验还是挺棒的，节约了至少一天的时间。

- 给Apple打call.
- 推荐朋友们花上2K购买一台NAS，系统本身就支持Time Machine,这比使用移动硬盘每次手动进行备份方便多了。

## 参考资料
- [使用“时间机器”备份您的 Mac](https://support.apple.com/zh-cn/HT201250)
