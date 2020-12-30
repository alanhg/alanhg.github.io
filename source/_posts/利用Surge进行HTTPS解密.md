---
title: 利用Surge进行HTTPS解密
date: 2020-12-30 19:29:25
tags:
- Surge
- MitM
- HTTPS
---

> 最近，我不满足光猪圈健身个人的健康数据只能由官方App查看的问题，于是利用Surge抓取了请求，现在利用postman，或自己写个App，脚本等，都可以轻松获取App数据。

## 解密的好处

解密即抓取解密了请求中及返回数据。好处有以下几点。

- 了解一些WEB，App是否偷偷传递了敏感数据到后台
- 基于请求数据，自行搭建C端或者B端，比如一些开源App，知乎，掘金客户端等 


OK，这里就Mark下如何开启解密。

## 开启解密

- 这里以Mac端`v4.0.3`，iOS端`v4.4.3`为例
- 针对解密，Mac端v3及iOS端v3起已支持，功能及命名存在些许差异

### 配置(Mac端)

![](https://static.1991421.cn/2020/2020-12-30-195232.jpeg)



如上，按照数字顺序，依次打开HTTPS解密开关=>生成证书=>系统安装=>添加域名

### 配置(iOS端)

>  iOS端的配置相对Mac端繁琐，首先要要将[缺省浏览器](https://github.com/alanhg/others-note/issues/174)设定为Safari，如果手机上无其它浏览器可忽视此设定要求。原因是Safari下下载证书后，系统才可以识别文件

接下来按照图示依次操作

![](https://static.1991421.cn/2020/2020-12-30-195755.jpeg)



![](https://static.1991421.cn/2020/2020-12-30-200426.jpeg)



安装成功后，还要`General=>About=>Certificate Trust Settings`，信任该证书，以Surge中显示为信任标志配置成功

最后，开启MiTM及增加域名设置

## Dashboard

开启解密后，需要在`Dashboard`或iOS端的`Utilities=>Recent Requests`中查看解密后的body体

- 这里以Mac端的dashboard来展示，且推荐使用Mac端来浏览。
- 在Dashboard中查看解密请求，需要Enable HTTP Capture，否则还是不会解密body体
- 注意箭头指向的小图标，如果解密成功会是这个颜色，若失败会提示`MitM failed`



![](https://static.1991421.cn/2020/2020-12-30-203331.jpeg)



如上即可看到请求及返回的body体

### 连接远程机器

有时候需要Mac上浏览iOS端抓包数据，操作如下



1. 开启远程控制器支持，`Home=>More Settings=>Remote Controller`

   ​					

   ​					![](https://static.1991421.cn/2020/2020-12-30-230212.jpeg)



![](https://static.1991421.cn/2020/2020-12-30-203515.jpeg)

![](https://static.1991421.cn/2020/2020-12-30-202556.jpeg)



![](https://static.1991421.cn/2020/2020-12-30-202724.jpeg)





##  其它

- 开启了MitM，加密流量会多一次解密和加密，对性能有一点影响
- 部分应用只允许特定证书，可能会影响
- 生成的证书是自签名证书，如果密钥泄漏，需要手动取消信任
- MitM 失败和性能毫无关系，MitM 失败是客户端在握手期间主动断开连接所致，一般是因为客户端有 Pinned-Certificate 防御 MitM，或者是正好因自身逻辑取消了请求，也可能是你配置不当对非 TLS 请求尝试进行 MITM。


## 写在最后

- 利用Surge的HTTPS解密可以方便本地或者局域网内其它设备的网络请求，基于此，比如做个性化广告拦截等都具备了一定可行性，因此还是挺实用的
- 需要注意，Surge依然无法完全替代Charles，fiddler，仅仅支持对于抓包有这些基本的feat而已。



## 参考文档



- [HTTPS Decryption (Man-in-the-Middle Attack, MitM)](https://manual.nssurge.com/http-processing/mitm.html)


