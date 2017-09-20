---
title: Tomcat配置常见问题
date: 2017-09-20 13:18:23
tags:
- server
- tomcat
---
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-20-052956.jpg)

## 请求乱码

需要在conf/server.xml中添加`URIEncoding='UTF-8'`

```xml
<Connector port='8080' protocol='HTTP/1.1' connectionTimeout='20000'
           redirectPort='8443' URIEncoding='UTF-8' />
```
Tomcat请求回复体的缺省字符集编码是`ISO-8859-1`

[官方字符编码介绍](https://wiki.apache.org/tomcat/FAQ/CharacterEncoding)