---
title: 图床工具iPic使用
tags:
  - CDN
  - 利器
  - markdown
abbrlink: 53fe91c5
date: 2017-07-22 20:06:05
---
> md博客编写不免需要有图片或者gif动画,上传图床是最佳方案

## 原做法
+ 浏览器打开网页
+ 多步操作[对象存储-内容管理-上传文件-复制链接]
+ 在md-blog,粘贴链接，使用

这样的做法不免很啰嗦，多步操作每次重复劳动，仅仅不过是要上传的素材不同，如何能够自动化呢，所以一直在寻找合适的工具及方式来优化这块写作操作流程。
偶然原因加入利器群，认识很多朋友，了解到很多利器，其中就有`iPic`这个玩意儿。

## iPic使用后
如下即利用iPic上传图片效果
![use-iPic](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-22-121516.jpg)
这样以后编写blog,就可以拖拽图片到iPic，或者直接iPic发送截图到目标图床，上传成功，得到的链接会自动
赋到系统剪贴板，这样子，只需要粘贴到md文件中。

iPic的确是个好东西，简化了资源上传图床整个流程，给Jason[iPic之父]点赞

附上iPic工具官方网站介绍[点击这里](https://toolinbox.net/iPic/)

## Win环境工作者怎么办?
推荐`Visual Studio Code`配合[qiniu-upload-image](https://marketplace.visualstudio.com/items?itemName=imys.qiniu-upload-image)即可，但体验差于iPic,毕竟一个是应用程序，一个是插件。