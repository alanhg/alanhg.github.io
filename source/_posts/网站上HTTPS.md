---
title: 给网站上HTTPS
tags:
  - HTTPS
  - SSL
  - NGINX
abbrlink: cb08c555
date: 2018-05-30 22:33:12
---
> 给网站加HTTPS已成一种趋势，新版Chrome访问未加密的站点会直接提示不安全。总提示不安全，另外加S的确可以加强网站信息传输的安全，so有必要搞一搞，这里以我自己的站点为例，介绍下配置过程。

## Let’s Encrypt证书
国内阿里云之前提供赛门铁克免费证书，但现在没了，好消息是Let’s Encrypt有免费SSL证书，不过证书有效期只有90天，别担心，有办法解决自动更新证书问题。

## 配置步骤

### 安装 acme.sh
```bash
curl  https://get.acme.sh | sh

```
### NGINX配置,特定路径支持对外访问
在生成证书时，CA会check网站下`.well-known/acme-challenge/`的文件来完成证书发放，所以我们需要该路径下文件支持对外访问。

以下为NGINX容器下配置。
- 当最终CA完成check后,wellknow文件夹下是会被删除，所以我们看不到，但是还是保持该路径支持访问，因为证书更新还需要保持能够请求

```
location ^~ /.well-known/acme-challenge/ {
        alias /var/www/toolkit/.well-known/acme-challenge/;
        try_files $uri =404;
    }
```

### 生成证书

```
acme.sh  --issue  -d tool.alanhe.me --webroot  /var/www/toolkit

```

### copy 证书到 NGINX下

### 注意
- `/etc/nginx/ssl`文件夹可能不存在，如果没有需要手动创建`mkdir /etc/nginx/ssl`
- 执行下面命令，证书是自动copy到ssl，不需要手动去做

可以执行证书命令

```
acme.sh  --installcert  -d  tool.alanhe.me --key-file   /etc/nginx/ssl/tool.alanhe.me.key --fullchain-file /etc/nginx/ssl/fullchain.cer --reloadcmd  "service nginx force-reload"
```
没意外的话，终端会显示OK，接下来就是NGINX配置下证书即可。

### NGINX证书配置

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
![](https://static.1991421.cn/blog/2018-05-31-030134.png)

## 证书更新?
安装acme.sh之后，程序会自动创建了cronjob,定期会Check证书，如果过期会自动更新，所以无需担心。
当我们执行`crontab -e`会看到的确存在这样一个任务
```bash
16 0 * * * "/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" > /dev/null
```



## 写在最后

以上即是完整的配置过程，但每次部署难免麻烦，比如服务器更换等，于是有了更好的方式即将整套配置进行docker配置，这样每次部署只需要拉取docker配置文件，run即可。这里贴下我的博客部署[配置](https://github.com/alanhg/alanhg.github.io/tree/master/deploy)，仅供参考





## HTTPS安全在哪-题外话

HTTPS相对HTTP是安全了些，为什么安全，因为HTTPS对传输数据进行了加密。我们都知道TCP连接是3次握手，而建立在TCP之上的HTTP+TLS/SSL是7次握手。因为TSL连接是4次握手(双方发送机密信息，双方确认)。

![](https://static.1991421.cn/2021/2021-03-11-151647.jpeg)



上图来自李兵老师的《浏览器工作原理与实践》



需要注意HTTPS的安全只是相对安全依然有漏洞，比如利用中间人攻击我们就可以破译部分的HTTPS站点数据



## 相关文档

+ [acme.sh](https://github.com/Neilpang/acme.sh/wiki/%E8%AF%B4%E6%98%8E)
+ [Let's Encrypt，免费好用的 HTTPS 证书](https://imququ.com/post/letsencrypt-certificate.html)
+ [使用 Let's Encrypt 证书](https://czjake.com/blog/article/https-certificate-letsencrypt)
