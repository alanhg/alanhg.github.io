---
title: 美团网首页HTML源码阅读
tags:
  - 源码阅读
  - Source Code
abbrlink: 8e611eca
date: 2020-10-10 17:21:38
---

首页网址：https://www.meituan.com

> 前端代码是透明的，你可以直接获取。通过解读源码，总是可以学到很多技术点。这里我来梳理下美团首页源码中包含的技术点。

## SEO

```html
<title>美团网-美食_团购_外卖_酒店_旅游_电影票_吃喝玩乐全都有</title>
<meta
      name="description"
      content="美团网:美食攻略,外卖网上订餐,酒店预订,旅游团购,飞机票火车票,电影票,ktv团购吃喝玩乐全都有!店铺信息查询,商家评分/评价一站式生活服务网站"
    />
    <meta
      name="keywords"
      content="美食,团购,外卖,网上订餐,酒店,旅游,电影票,火车票,飞机票"
    />
```

这两个meta标签服务于SEO，对于SPA应用，SEO是个问题，所以进而也就有了对应的解决方案SSR。

## 格式检测

```html
   <meta name="format-detection" content="telephone=no" />
   <meta name="format-detection" content="address=no" />
```

### 注意
- 服务于关闭格式检测，比如数字串，避免点击直接call出去
- 该标签非标准标签，只在Safari下有效，相关[Apple文档](https://developer.apple.com/library/archive/documentation/AppleApplications/Reference/SafariHTMLRef/Articles/MetaTags.html#//apple_ref/doc/uid/TP40008193-SW1)

## 自定义标签
```html
 <meta name="lx:category" content="group" />
 <meta name="lx:cid" content="" />
 <meta name="lx:appnm" content="mtpc" />
 <meta name="lx:autopv" content="off" />
```
### 注意
要知道，如上标签为自定义的,比如我一般增加releaseDate标签，来记录打包的具体时间，这样方便了解当前访问的WEB网页版本

## DNS Prefetching

```html
    <link rel="dns-prefetch" href="//analytics.meituan.net" />
    <link rel="dns-prefetch" href="//www.meituan.com" />
    <link rel="dns-prefetch" href="//s0.meituan.net" />
    <link rel="dns-prefetch" href="//s1.meituan.net" />
    <link rel="dns-prefetch" href="//p0.meituan.net" />
    <link rel="dns-prefetch" href="//p1.meituan.net" />
```
### 注意
> 合理的dns prefetching能对页面性能带来50ms ~ 300ms的提升

dns prefetching的`正确使用姿势`如下

1. 对静态资源域名做`手动`dns prefetching。
2. 对js里会发起的跳转、请求做`手动`dns prefetching。
3. `不用`对超链接做手动dns prefetching，因为chrome会`自动`做dns prefetching。当然HTTPS的网页不会，需要手动开启下`<meta http-equiv="x-dns-prefetch-control" content="on">`
4. 对重定向跳转的新域名做`手动`dns prefetching，比如：页面上有个A域名的链接，但访问A会重定向到B域名的链接，这么在当前页对B域名做手动dns prefetching是有意义的。

推荐两篇相关好文

- [预加载系列一：DNS Prefetching 的正确使用姿势](https://tech.youzan.com/dns-prefetching)
- [性能优化之 DNS Prefetch](https://github.com/barretlee/performance-column/issues/3)


## http,https切换

```html
 <script>
      (function () {
        if (location.protocol == 'http:') {
          location.href = location.href.replace('http://', 'https://');
        }
      })();
    </script>

```
 
实际测试，这段代码完全没用，因为美团在服务器端已经做了302跳转，当然个人认为301永久跳转更佳

## 相对协议URL

```html
 <link
      rel="stylesheet"
      type="text/css"
      href="//s0.meituan.net/bs/fe-web-meituan/23bb705/css/main.css"
    />
```

因为美团这里服务器端已经做了强行跳转HTTPS，个人理解这里自动协议切换是没有意义了。当然了解这个手段没问题，相对协议URL的好处就是浏览器会根据当前URL的协议自动去选择HTTPS或者HTTP


## async,defer

```html
<script
      src="//analytics.meituan.net/analytics.js"
      type="text/javascript"
      charset="utf-8"
      async
      defer
    ></script>
```

### 注意
- async用于异步加载不block HTML的继续解析
- defer用于JS的延迟执行
- 两者是script标签的两个属性，因此是可以同时使用的


## body中link标签

```html
<body id="main">
    <link
      rel="stylesheet"
      type="text/css"
      href="//s0.meituan.net/bs/fe-web-meituan/5058856/css/com_header.css"
    />
 ...
```

如上body中的css work,因为浏览器在渲染前会纠错，也就是HTML是可以容错的。

## IIFE

```javascript
!(function (win, doc, ns) {
  var cacheFunName = '_MeiTuanALogObject';
  win[cacheFunName] = ns;
  if (!win[ns]) {
      var _LX = function () {
          _LX.q.push(arguments);
          return _LX;
      };
      _LX.q = _LX.q || [];
      _LX.l = +new Date();
      win[ns] = _LX;
  }
})(window, document, 'LXAnalytics');
```

- IIFE主要解决的是ES6之前没有块作用域的问题，当然因为有了ES6带来的let，const，部分IIFE的场景完全可以替代。
- 这里的感叹号是多余的，可以去掉，因为没有消费IIFE的返回值

运行如下例子即可看出IIFE的价值

```javascript

 for (var index = 0; index < 10; index++) {
        window.setTimeout(() => console.log(index), 1000);
      }

 for (var index = 0; index < 10; index++) {
        ((i) => {
          window.setTimeout(() => console.log(i), 1000);
        })(index);
      }

```


## 写在最后
- 一个简单的HTML网页也带出了这么多的细节知识点，不得不说，前端很碎。
- 正如开篇所说的，前端是透明的，所以好处就是看看别的站点的每个功能是如何实现的，总是能学到些，so，不断学习不断进步吧。


