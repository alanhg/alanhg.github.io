---
title: Nginx配置只支持域名访问WEB
tags:
  - Nginx
  - Server
abbrlink: e50450c4
date: 2018-06-02 12:35:56
---
> 通过DNS解析配置后，我们实现了域名访问WEB，但是我们WEB部署服务器的IP是可见的，用户通过IP也是可以访问WEB，这样存在两个问题
1. 如果用户一直以我们IP访问，比如我们更换服务器机房等，IP是会变的，这样就会造成访问故障。
2. 如果他们恶意将自己的域名解析到我们WEB也是可以的
所以有必要设定会禁止IP访问我们WEB,只支持指定域名的访问。


## 具体配置
以下我的一个WEB `https://tool.alan.me`的Nginx配置
## 配置指定域名服务

```
server {
       listen       443 ssl;
       server_name  tool.alanhe.me;

        ssl on;
        ssl_certificate "/etc/nginx/ssl/fullchain.cer";
        ssl_certificate_key "/etc/nginx/ssl/tool.alanhe.me.key";
      ...  
  }

```
## 增加缺省服务配置
```
 server {
        listen 443 default_server ssl;
        server_name _;
        ssl on;
        ssl_certificate      /etc/nginx/ssl/fullchain.cer;
        ssl_certificate_key  /etc/nginx/ssl/tool.alanhe.me.key;
        return       403;
}


```

配置完成后，重启服务Nginx配置`nginx s- reload`即可。

## 效果
当我们以IP访问
![](https://static.1991421.cn/blog/2018-06-02-045526.png)

当我们以指定域名访问
![](https://static.1991421.cn/blog/2018-06-02-051256.png)
