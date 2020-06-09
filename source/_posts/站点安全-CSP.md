---
title: ' 站点安全-CSP'
tags:
  - CSP
  - XSS
abbrlink: 63ea9513
date: 2020-05-11 20:31:06
---

> 最近项目在做安全扫描，安全团队报过来了一个问题-没有满足CSP，如下图，错误提示已经很清晰了，但是源于我之前对此并有学习过，于是开始了调查学习

![](http://static.1991421.cn/2020/2020-05-11-203614.jpeg)


## 内容安全策略( CSP )

> CSP 的实质就是白名单制度，开发者明确告诉客户端，哪些外部资源可以加载和执行，等同于提供白名单。它的实现和执行全部由浏览器完成，开发者只需提供配置。

![](http://static.1991421.cn/2020/2020-05-11-205930.jpeg)

### 配置方式
1. res头部配置 `当前我项目选择的方式`
2. html meta标签配置


### 配置控制内容

- script-src
- style-src
- img-src
- frame-src
- default-src
- 等等

正如之前所讲，配置策略可以严格控制我们资源的类型，来源地址，协议类型。

### 贴下我当前的配置

我当前的配置还是比较松的，只是控制了资源来源一定是自己

```yml
content-security-policy: "default-src 'self' wss: 'unsafe-inline' file: data: blob: https://*;"
```
![](http://static.1991421.cn/2020/2020-06-09-203930.jpg)

### 内容格式
那怎么配置呢，知道格式，和值即可。


1. script-src,default-src我们可以叫做一个指令，所以我们是配置一或者多个指令，如上我只配置了`default-src`,`指令之间以分号分割`
2.  单个指令中多个源source，source可以是域名、IP、协议，注意协议需要带冒号
3.  unsafe-inline,unsafe-eval,none必须有单引号。

所以才会出现，指令配置中，分号，单引号，冒号，空格多种写法的存在。



### 常见的安全策略
1. HTTPS，实质今日网站很多都是`HTTPS`了，如果不是的，比如chrome就会提示站点不安全。HTTPS为啥安全呢，因为它把内容都进行了加密。
2. 如果是高访问量站点，为了提高访问速度，我们一般会把静态资源CDN化，比如图片，但这些CDN资源万一被别人拿去用了呢，那不是盗刷流量了，所以会有安全策略，比如根据`refer`来源地址来判断，如果不是A站点请求的CDN资源，则直接拦截。
3. 比如sessionId，令牌，设置为`HttpOnly`，因为这个信息本身是并不能表示什么，我们往往是利用令牌去换用户信息，所以消费方是server端，而为了确保会被脚本等篡改，所以要设置。Js获取Cookie 的时候会跳过HttpOnly = true 的Cookie 记录




## 参考文档

- [内容安全策略( CSP )](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/CSP)
- [Content Security Policy 入门教程](http://www.ruanyifeng.com/blog/2016/09/csp.html)