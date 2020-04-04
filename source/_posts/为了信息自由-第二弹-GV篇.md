---
title: 为了信息自由-第二弹-GV篇
tags:
  - Google Voice
abbrlink: 541862a1
date: 2019-11-02 21:15:37
---
> 部分国外服务需要电话绑定，国内手机号不支持。另一方面，比如我常使用的电报，拿国内号码注册可以，但是有安全风险，国内隐私状况你懂的。总之为了安全方便使用国外的这些优质服务，决定搞下Google Voice。

## 准备条件
- 网络要健康，可以上谷歌

## 淘宝GV购买
之前折腾过自己进行GV注册，但需要美国电话卡，这条直接卡死，即使可以购买个电话卡，但每个月还要养卡，搞不定，于是只能淘宝购买了`11.8RMB`。购买时候，会让你选择`可转移`，`建议大家还是别选可转移的了，转移有封号的风险，具体可另查。`

## Telegram销号
之前我已经使用大陆手机号注册了Telegram,不销号直接注册使用GV电话也行，但为了安全，还是销毁老号数据记录妥当些。

销号访问地址:[戳这里](https://my.telegram.org/auth)

![](http://static.1991421.cn/2019-11-02-89BCD1BC-75C2-4A6E-AB70-B8BA8CC5FDCB.png)

![](http://static.1991421.cn/2019-11-02-975227B6-53AB-4060-B8FE-07FBDB253CCB.png)

## IFTTT使用确保GV不被回收
> Google Voice的回收政策是这样的：如果超过6个月没有拨打或者接听电话，也没有发出或接收过短信，号码就会被回收.因此需要使用IFTTT定期拨打电话来避免该问题。

IFTTT Keep Google Voice Active [地址](https://ifttt.com/applets/131839p-keep-google-voice-active?term=google%2520voice)

注意：App安装不是必须的，Google Voice WEB也可以接听电话，但我接听时，听不清数字，根据提示可按键2，这样Gmail会收到语音邮件，点击重新播放即可。

![](http://static.1991421.cn/2019-11-02-131210.png)

实测，上图输入电话号格式是支持多种的比如`(404) 692-2710或者4046922710`

![](http://static.1991421.cn/2019-11-02-130212.png)

这样以来就可以确保不易被回收了，完美。

## 写在最后
1. GV虚拟电话号码解决后，很多服务比如Azure,Telegram都可以直接使用这个号码，一类问题得到了解决，so，值得投资。
2. GV正如Apple美区账户一样，只会越来越难申请，so有需要的尽快搞定。


## 相关资料

- [How to Deactivate or Delete Your Telegram Account](https://www.makeuseof.com/tag/deactivate-delete-telegram-account/)
- [使用IFTTT让Google Voice自动回复短信来保号](https://www.vpsdawanjia.com/1452.html)

