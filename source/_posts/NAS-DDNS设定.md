---
title: NAS DDNS设定
tags:
  - NAS
  - DDNS
abbrlink: 8b243a50
date: 2019-08-25 14:48:51
---
> 购买群晖会赠送QuickConnect服务，也就是可以直接外网访问，但访问很慢【听说走宝岛台湾】且域名不怎么好，要想快点，就需要搞下自定义域名绑定

为什么说是DDNS设定，了解DDNS的同学应该知道这个就是为了解决动态IP域名绑定问题的。要了解DDNS的，[戳这里](https://www.lifewire.com/definition-of-dynamic-dns-816294)

开搞前有几个基础条件需要满足
## 基础条件
1. 有外网IP
	
	百度获取下自己的IP地址，然后终端执行traceroute命令，假如只有一条解析记录，则说明是外网IP地址
2. 域名
	
	既然进行自定义域名解析，当然需要有个域名，一般国内是在阿里云买，原因是省事。
3. 家里路由器需要支持端口转发
	
	在访问进入网关时，需要根据端口来转发到NAS服务上	

## dnspod添加域名解析

比如我这里，添加a记录nas，

![](http://static.1991421.cn/2019-08-25-062743.png)

![](http://static.1991421.cn/2019-08-25-062808.png)

## dnspod获取api token

![](http://static.1991421.cn/2019-08-25-063651.png)

记录下来id,token,这个就是用户名和密码

## 万网DNS解析地址修改
点击进入对应域名，按照dnspod提供的地址进行修改

![](http://static.1991421.cn/2019-08-25-063534.png)

## NAS下配置DDNS
- Control Panel 
- External Access 
- DDNS，选择DNSPod.cn,填写用户名密码，确定即可

## 路由器端口转发

我这里使用的是小米路由器3

![](http://static.1991421.cn/2019-08-25-064115.png)


## 可能存在的问题

1. DNS解析时效性

	假如万网新买的域名，需要上传身份证件审核，审核需要时间，so解析就无法立即生效
 

## 写在最后

一番设定后，应该就可以了。访问地址会是`http://nas.xxx.cn:5000`。