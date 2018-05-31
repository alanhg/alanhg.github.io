---
title: 网站上HTTPS
tags:
  - HTTPS
  - SSL
  - NGINX
abbrlink: cb08c555
date: 2018-05-30 22:33:12
---
> 给网站上HTTPS已成一种趋势，新版Chrome访问未加密的站点会直接提示不安全。总提示不安全，另外加S的确可以加强网站信息传输的安全，so有必要搞一搞。

## Let’s Encrypt证书
国内阿里云之前提供赛门铁克免费证书，但现在没了，好消息是Let’s Encrypt有免费SSL证书，不过证书有效期只有90天，别担心，有办法解决自动更新证书问题。

## 配置步骤

### 安装 acme.sh
```bash
curl  https://get.acme.sh | sh

```
### 生成证书

```
acme.sh  --issue  -d tool.alanhe.me --webroot  /var/www/toolkit

```

### copy 证书到 nginx

注意:`/etc/nginx/ssl`文件夹可能不存在，如果没有需要创建`mkdir /etc/nginx/ssl`

注意:因为CA会check网站下`.well-known/acme-challenge/`的文件来完成证书发放，所以我们需要该路径下文件支持对外访问。
以下为nginx容器下配置。

```
location ^~ /.well-known/acme-challenge/ {
        alias /var/www/toolkit/.well-known/acme-challenge/;
        try_files $uri =404;
    }
```

配置完成后，我们就可以执行证书命令了

```
acme.sh  --installcert  -d  tool.alanhe.me --key-file   /etc/nginx/ssl/tool.alanhe.me.key --fullchain-file /etc/nginx/ssl/fullchain.cer --reloadcmd  "service nginx force-reload"


```

### nginx配置

```
server {
       listen       443 ssl http2 default_server;
        listen       [::]:443 ssl http2 default_server;
        server_name  tool.alan.me;

        ssl on;
        ssl_certificate "/etc/nginx/ssl/fullchain.cer";
        ssl_certificate_key "/etc/nginx/ssl/tool.alanhe.me.key";
        
 ...
 
 }       

```
配置完成后，执行`nginx -t`，如果提示OK，则重启服务，访问`https://tool.alanhe.me`，地址栏出现了小绿锁，完美!
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-31-030134.png)

## 证书更新?
安装acme.sh之后，程序会自动创建了cronjob,定期会Check证书，如果过期会自动更新，所以无需担心。
当我们执行`crontab -e`会看到的确存在这样一个任务
```bash
16 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
```

## 相关文档
+ [acme.sh](https://github.com/Neilpang/acme.sh/wiki/%E8%AF%B4%E6%98%8E)
+ [Let's Encrypt，免费好用的 HTTPS 证书](https://imququ.com/post/letsencrypt-certificate.html)
+ [使用 Let's Encrypt 证书](https://czjake.com/blog/article/https-certificate-letsencrypt)