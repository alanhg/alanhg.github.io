---
title: nginx重定向-post请求信息丢失问题
date: 2017-07-19 06:55:18
tags:
- nginx
---
> 
做了两个网站，网站A，网站B，A网站会接收POST提交，然后重定向到B网站，重定向是在nginx中进行配置，具体配置语法，请参考nginx官方文档，这里只贴出关键语句
## 原配置
```
# rewrite ^.+ http://web-b.com$uri;
```
但是经过测试发现问题，跳转到B，表单提交信息会丢失

## 解决

经过查询，果然rewrite会将post提信息丢失，所以应该使用307重定向，具体配置如下

```
  return 307 ^.+ http://web-b.com$uri；
```

## 说明
### 状态码307含义
[HTTP-307](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/307)是临时重定向，标明这个请求被临时移动到给定的目标地址,方法和请求体都会被重用于重定向后的请求。