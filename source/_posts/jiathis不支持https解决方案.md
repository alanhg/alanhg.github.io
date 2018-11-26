---
title: jiathis不支持https解决方案
tags:
  - HTTPS
  - JavaScript
abbrlink: f7cce253
date: 2018-02-25 13:13:47
---
> 第三方社会化分享插件使用比较多的也就是baidushare，jiathis，但这些都不支持https,如果https站点使用是会报错的。
如何解决呢，其实只能改源码解决了，当然也可以利用反向代理解决。

百度share修改源码方案见[这里](https://github.com/hrwhisper/baiduShare)

jiathis的js源码因为已经进行了代码混淆，所以并不能修改源码来解决，如果还是想使用，可以直接down下来相关代码，部署在自己的WEB中，但资源路径不能变动

结构及资源如下:

![](//static.1991421.cn/blog/2018-02-25-063251.png)

jia.js文件可以自由放置，但是相关css及img资源却不必须如此去放了(在根路径下)

## 其它办法?

+ 使用开源方案-如 https://github.com/overtrue/share.js
+ 自己写，因为实际的分享媒体很少，常用的只是微信，微博，并且微信设计二维码，其余大多只是链接

