---
title: post提交数据的编码方式
date: 2017-10-16 20:42:54
tags:
- http
- post
---
> Postman是一款强大的API调试工具，在执行post请求时候会发现body有4种格式选项，那么这四种各是什么含义，及使用场景呢，各方检索后，总结如下
![postman-post](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-16-125105.jpg)

虽然Postman中看到的是form-data，x-www-form-urlencoded，raw，binary,但真实提交的数据格式并不是这4种方式，而是multipart/form-data，application/x-www-form-urlencoded，application/json，text/xml。

## application/x-www-form-urlencoded

> When a web browser sends a POST request from a web form element, the default Internet media type is "application/x-www-form-urlencoded".[8] This is a format for encoding key-value pairs with possibly duplicate keys. Each key-value pair is separated by an '&' character, and each key is separated from its value by an '=' character. Keys and values are both escaped by replacing spaces with the '+' character and then using URL encoding on all other non-alphanumeric[9] characters.

以上描述摘自[WIKI](https://en.wikipedia.org/wiki/POST_(HTTP))

浏览器的原生 form 表单，如果不设置enctype属性，那么最终就会以application/x-www-form-urlencoded方式提交数据。

## multipart/form-data

当表单提交内容中包含文件时（比如图片文件），则需要这种数据格式。

## application/json

application/json 这个 Content-Type 作为响应头很常见，实际上，现在越来越多的人把它作为请求头，用来告诉服务端消息主体是序列化后的 JSON 字符串。可以方便的提交复杂的结构化数据，特别适合 RESTful 的接口。

## raw，binary

raw代指原始数据，binary代指二进制数据。

+ 选择raw后出现一个大的输入框，在里面输入什么则提交什么。可以是text,json,xml,html等。
+ binary专门用来提交文件的二进制数据，且一次只能提交一个文件。

## 参考文章

+ [W3C Form content types](https://www.w3.org/TR/html4/interact/forms.html#h-17.13.4.1)
+ [POST提交数据的常见编码方式](http://chayangge.com/2016/12/01/POST%E6%8F%90%E4%BA%A4%E6%95%B0%E6%8D%AE%E7%9A%84%E5%B8%B8%E8%A7%81%E7%BC%96%E7%A0%81%E6%96%B9%E5%BC%8F/)
+ [常用的Post提交类型](http://www.voidcn.com/article/p-figxdxhn-bdu.html)