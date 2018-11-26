---
title: GitHub Pages自定义域名开启HTTPS
tags:
  - GitHub
  - HTTPS
abbrlink: '92147245'
date: 2018-02-17 13:17:46
---
> GitHub Pages本身是支持HTTPS，比如仓库地址是alanhg.github.io,https可以正常访问，但自定义域名后，是不可以https访问的。
这里利用Cloudflare的免费CDN服务来实现。
## 操作步骤
+ 注册Cloudflare账户
+ 点击'Add Site'
    ![](http://static.1991421.cn/blog/2018-02-17-052245.png)
    
+ 选择免费方案
+ 添加成功后，会提示你需要修改域名的DNS服务器
  
  ![](http://static.1991421.cn/blog/2018-02-17-052831.png)

+ 在Crypto下面，选择`SSL-Flexible`

    ![](http://static.1991421.cn/blog/2018-02-17-053052.png)

    勾选`Always use HTTPS`

    ![](http://static.1991421.cn/blog/2018-02-17-053203.png)

+ 登录域名服务商的控制台，修改DNS服务器地址为上面Cloudflare所提供的

    ![](http://static.1991421.cn/blog/2018-02-17-053427.png)

## 写在最后
配置完成后，访问`https://1991421.cn`发现可以了，但是浏览器会提示证书错误，为GitHub的，所以我们自定义域名与其不符。
这个问题需要等待一段时间，我是第二天再访问正常了。
![](http://static.1991421.cn/blog/2018-02-17-055144.png)

![](http://static.1991421.cn/blog/2018-02-17-055008.png)
