---
title: ' Azure搭建SS服务-撸羊毛'
tags:
  - Azure
  - ShadowSocks
  - YouTube会员
abbrlink: '88194639'
date: 2019-07-07 09:56:46
---
> 一直挺喜欢看YouTube视频，不过现在广告太多太频繁。想着找个办法干掉广告。网页版的还好有AdBlock，但手机，iPad一般都是APP观看广告就一大堆了，尝试用Surge，但需要一直维护规则。OK，看来只有会员一条道路了。

>查了下YouTube会员， 印度的最良心，家庭计划，一个月才18RMB，良心！但印度会员购买需要以印度IP访问才行，需要搞下代理。试了下`Google Cloud Platform`,虽然创建印度地区实例成功，但访问YouTube竟然显示的是不丹【what？因为地理上近？】。尴尬了,无奈决定再试下微软的Azure了。

## 准备条件
- `visa双币卡`，因为要绑定支付
- 好使点的`终端`，部署SS需要，比如Mac下，我用的iterm2
- `微软账户`，如果没有，在登录azure时会提示先注册

## 登录国际azure官网

地址: https://azure.microsoft.com

一路点击，银行卡的地方，就正常填写，对于地址，其实可以随意填写

*关键*:银行卡信息正确即可


##  进入portal
注册成功之后，点击portal进入管理页面

https://portal.azure.com/#home

页面还是挺复杂的，如果英文看着吃力，可以切换语言

![](http://static.1991421.cn/2019-07-07-013433.png)

OK，点击左侧菜单

## 创建实例

*关键*:选最低配置，因为免费200刀其实没多少钱，搁不住azure贵啊！


![](http://static.1991421.cn/2019-07-07-013530.png)

![](http://static.1991421.cn/2019-07-07-013644.png)

按照要求，将必填项都填写下,一路下一步，最后点击创建，如果成功的话 会有提示。

### SSH用户
如果SSH选择的用户名密码，记得记录下来，终端访问时需要

### 公共IP

![](http://static.1991421.cn/2019-07-07-014608.png)

这里需要新建下,这样就会有对外访问的固定IP

## 端口开放
SSH的22端口及SS未来的服务端口在入站端口规则中需要添加下。

![](http://static.1991421.cn/2019-07-07-014309.png)

## 部署SS
实例创建成功后，可以终端访问了，对于部署SS，不再详细描述，这里推荐[一键脚本搭建SS/搭建SSR服务并开启BBR加速](https://suniceman.com/2019/04/10/install-shadowsocks-in-one-command/) 

最后输出的配置参拷贝下来，添加到SS客户端下，访问谷歌，成功就好。

测试下IP地址所在地

![](http://static.1991421.cn/2019-07-07-014947.png)

访问油管，也显示为India了，开心的去注册会员了，走起！。

![](http://static.1991421.cn/2019-07-07-015026.png)


## 写在最后
为了能够撸YouTube羊毛，也够折腾的，不过好歹最后成功了，顺便也体验了下Google和微软的两大云服务。对比来说，Google的操作简单，微软的看着都心累，挺复杂的。对于速度，目前觉得azure快些。


## 相关链接
- [全球最低价，印度区Youtube Premium会员还不上车吗？](https://zhuanlan.zhihu.com/p/62762581)
- https://blog.yiheng.moe/share/azure.html
- [一键脚本搭建SS/搭建SSR服务并开启BBR加速](https://suniceman.com/2019/04/10/install-shadowsocks-in-one-command/) 
