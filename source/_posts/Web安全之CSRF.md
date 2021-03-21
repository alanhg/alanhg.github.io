---
title: Web安全之CSRF
tags:
  - Web安全
abbrlink: '93186991'
date: 2021-03-16 19:53:38
---

> CSRF相较XSS名气小了点，但也是常见安全问题之一。借着空闲时间，梳理强化下。

## 概念

CSRF(`Cross Site Request Forgery`)，中文意思`跨站请求伪造`，是一种冒充受信任用户，向服务器发送非预期请求的攻击方式。

![](https://static.1991421.cn/2021/2021-03-16-224329.jpeg)

## 举例

单从概念还是很难理解，那么就以几个例子来辅助理解下。

比如我们收到这样一封邮件，当邮件打开时，写着诱惑性词汇，恭喜你中奖500万，虽然明知道是假的，但是总想点开看一看，万一是真的呢。当我们打开邮件时，发现是骗人的，于是关了。但是殊不知，邮件源码中有这样一段代码，于是当邮件打开时，替换标签IMG就会发起get请求，同时又因为test1.com，我们正常登录过，所以cookie中保存了我们的登陆信息，因此请求成功，我们的ID为123的信息也就删除了。

```html
<img src="https://test1.com/index?action=delete&id=123">
```

为了杜绝这种情况，我们把站点中的删除动作改成post方法，于是以为这样就万事大吉了，但是悲剧还是继续发生了，因为犯罪份子又发了这样一封邮件

```html
  <form method="POST" action="https://test1.com/index">
      <input type="hidden" name="action" value="delete"/>
      <input type="hidden" name="id" value="123"/>
  </form>
<script> document.forms[0].submit(); </script> 
```

打开邮件即中招，看来post也不行，除此之外还有超链接形式或者XHR，这种稍微麻烦点，需要用户主动点击，你不点？如果写了点击就中500万呢。

```html
 <a href="https://test1.com/index?action=delete&id=123">
        点击就中500万
    </a>
```

以上就是常见的CSRF攻击方式。



## 分析

由上可以看出CSRF的特征利用用户在A站点的登陆状态及用户未知的情况下，在B站点内发起了访问A站点的请求，从而达到非法目的。



## 防范手段

基于攻击特征，作出以下的防范措施。为了确保安全，这些方面应该尽可能的做到

1. API按照RESTful标准设计，好处是比如删除动作，会是delete方法，那么单纯的链接或者表单下get,post请求无法执行删除操作
2. cookie进行Samesite设定，如果是strict，则第三方站点下发起的跨域请求都不会携带cookie，如果是lax，post请求不会携带cookie
3. CORS严格控制，这样可以规避跨域异步请求下的一些非法操作
4. refer检验，比如上述的Gmail中的请求，完全可以利用refer禁掉
5. CSRF Token，一些操作完全也可以增加这样的token，而跨域的脚本无法获得这个token，进而无法攻击
6. 关键性Cookie开启SameSite，如果设定为strict，跨站请求不会携带cookie，设定为lax，只有get请求会携带cookie。





## 写在最后

安全是构建开放Web必须考虑的一环，因此需要重视和采取措施。



## 参考

- https://github.com/dwqs/blog/issues/68
- https://tech.meituan.com/2018/10/11/fe-security-csrf.html
- https://developer.mozilla.org/zh-CN/docs/Glossary/CSRF