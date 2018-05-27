---
title: Nginx安装及配置
author: Qiang He
tags:
  - Nginx
  - proxy
  - server
abbrlink: 37016
date: 2016-09-10 09:14:03
---
## nginx简介
最近在部署web站点,用到了nginx,这里记录主要相关操作及配置。
来句概括的话，nginx是一个高性能的http与反向代理服务器,具体nginx了解请看[官网](https://nginx.org/en/)及[维基百科](https://zh.wikipedia.org/zh-hans/Nginx)，了解下,

## 相关命令

```
# yum方式安装nginx
$ yum -y install nginx

# 启动nginx服务
$ nginx

# 重启nginx服务
$ nginx -s reload

# 停止nginx服务
$ nginx -s stop


```
## 相关配置

+ gzip

Gzip开启以后会将输出到用户浏览器的数据进行压缩的处理，减小通过网络传输的数据量，提高浏览的速度。

**下面贴出在nginx.conf配置文件中配置gzip的基本信息**
```  
# 开启gzip
gzip on;
``
# 启用gzip压缩的最小文件，小于设置值的文件将不会压缩
gzip_min_length 1k;

# gzip 压缩级别，1-10，数字越大压缩的越好，也越占用CPU时间，后面会有详细说明
gzip_comp_level 2;

# 进行压缩的文件类型。javascript有多种形式。其中的值可以在 mime.types 文件中找到。
gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;

# 是否在http header中添加Vary: Accept-Encoding，建议开启
gzip_vary on;

# 禁用IE 6 gzip
gzip_disable "MSIE [1-6]\.";

```
关于前端静态资源的gzip，我们也可以采取预压缩方案，这样子，对于用户请求，能够更快的服务，提升性能，比如webpack就可以再打包前端静态资源的时候，生成gz文件。
这里贴出静态gzip配置项。

```
gzip_static on;

```

+ 反向代理

```
    #定义一个服务器，监听80端口，配置的域名是www.1991421.cn
    server{
        listen 80;
        # using www  domain to access the main website
        server_name www.1991421.cn;
        access_log  /var/log/nginx/www.log

        location / {
            root /usr/www/website_root;

        }
    }

```

## 相关好文

+ [Nginx何时取代Apache？](http://www.infoq.com/cn/news/2016/11/Nginx-when-replace-Apache)