---
title: Nginx透传用户IP
abbrlink: 777f4604
date: 2018-05-27 10:46:01
tags:
- Nginx
---
> 最近开发WEB，牵扯到IP登录，后端需要拿到用户访问IP，因为后端是ExpressJS,req.ip即可拿到，但实际部署后，发现req.ip永远是`127.0.0.1`
想了下当年的WEB部署用到了Nginx，顿时明白了这点，这个是Nginx的锅。因为Nginx用作反向代理，换句话说对于我们的WEB后端，请求方是Nginx,那么IP总是127.0.0.1就解释的通了。


## IP透传
Google了下，解决这个问题是做下Nginx的IP透传，配置如下

```config

location / {
           proxy_pass http://127.0.0.1:3001/;
           proxy_set_header      Host $host;
           proxy_set_header        X-Real-IP       $remote_addr;
           proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
}

```
修改OK后，执行以下命令即可
```
# 测试配置是否正确
$ nginx -t
# 重新加载配置
$ nginx -s reload
```

