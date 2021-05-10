---
title: Alfred实现一键GIF压缩
date: 2021-05-10 10:31:51
tags:
- Alfred
- Workflow
---

> 个人博客中经常需要贴一些录制的GIF动画，考虑到GIF大小会影响页面加载体验，我需要手动进行GIF压缩，压缩过程乏味且浪费时间，因此动手写个小工具来提升操作效率。



## 效果

![](https://static.1991421.cn/2021/2021-05-10-104238.gif)



Workflow下载地址，[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/compress-gif)



### 注意

当前workflow支持scale/colors个性化参数设定



- scale
  - 比例，比如0.5 指的是宽和高缩小为原来的 0.5 倍
- colors
  - 调色板长度，值为2-256之间，数字越小，压缩率越高，图片质量的损失度也越大

## 实现细节

聊聊工具实现的关键部分，完整源码直接查看workflow即可。

- Gifsicle是个开源工具，可以实现GIF的个性化压缩，比如比例缩放，颜色调整等，这样就可以实现体积压缩
- AppleScript来获取当前选中文件完整路径



## 写在最后

以后GIF压缩，只需要选中文件，唤起压缩命令即可，再也不用访问第三方工具网页上传下载压缩了，效率还是明显提升。

