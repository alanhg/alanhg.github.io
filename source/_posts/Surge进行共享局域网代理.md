---
title: Surge进行共享局域网代理
tags:
  - Surge
abbrlink: f272c7c
date: 2021-01-23 22:01:13
---

> Surge进行网络代理很方便，但比如其它设备也需要网络代理，比如互联网电视、Nintendo Switch，这时如何快速解决墙的问题呢，个人总结有以下两个办法。

这里以NS设备需要翻墙-发推举例

## 允许WI-FI连接，充当代理设置

1. 确保iPhone，NS连接同一个Wi-Fi网络即内网环境一致

2. 启动了Surge的iPhone开启允许Wi-Fi访问

3. NS上Wi-Fi设定代理，参数以Surge中提示的Wi-Fi IP，端口

   ![](https://static.1991421.cn/2021/2021-01-23-220718.jpeg)

4. NS尝试发推，翻墙成功



注意：使用Mac版Surge也可，这里是以iPhone为例

## DHCP 

该功能仅Mac版支持，iPhone不可

1. Mac版按照要求开启DHCP
2. NS网关设定为Mac内网地址



## 写在最后

1. 个人很喜欢Surge，因此方案围绕Surge开展
2. 如上两种方式各有利弊，总之目的单一，解决部分设备在不需要安装或无法安装Surge的情况下，快速获得信息自由。