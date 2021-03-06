---
title: 开启GitHub两步验证
date: 2021-06-14 11:42:06
tags:
- GitHub
---

> 最近发布Action到GitHub Market需要开启两步验证，于是就搞了下，但是发现还是有些坑的，这里记录下。



## 开启GitHub两步验证

1. 点击右上角settings-Account security

<img src="https://static.1991421.cn/2021/2021-06-14-115905.jpeg" style="zoom: 33%;" />



2. 按照提示开启即可，中间提醒`下载恢复码，下载保存`。

3. 弹出的二维码需要用支持MFA的App扫描，对于认证App，选择很多，个人习惯使用1Password
   - 解释下，二维码本身就是个链接，但并不一定是HTTP链接，之所以不是直接弹出链接进行拷贝，个人理解是因为不安全且体验不友好
   - App扫描后存储该链接到登陆项，每次点击App其实就是根据该链接请求得到一个新的且有效时间的验证码

填写验证码即可正常开启两步验证

### 1P扫描二维码

关于1P中找到扫描二维码的方式还是比较隐蔽的，如图

![](https://static.1991421.cn/2021/2021-06-14-120310.jpeg)

扫描GitHub提供的二维码后，1P即可存储该项，以后如果操作，1P中就会提示如下，拷贝输入即可

![](https://static.1991421.cn/2021/2021-06-14-120629.png)

### 注意

- 1P推荐使用网页版下载而非App Store商店版本，权限有所不同

## GitHub push

开启两步验证后，突然发现提交代码不work了，解决办法是，Settings-Developer settings-Personal access tokens，生成新token作为密码，输入即可，电脑本身会缓存化该值，因此就可以一直正常push操作了。

![](https://static.1991421.cn/2021/2021-06-14-121642.jpeg)







## 写在最后

通过开启这个验证才注意到1P原来还支持，不得不说真香。



## 相关文档

- [什么是两步验证](https://www.iplaysoft.com/two-factor-authentication.html)

