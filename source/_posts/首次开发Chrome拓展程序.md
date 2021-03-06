---
title: 首次开发Chrome拓展程序
tags:
  - Chrome
  - Extension
abbrlink: 3b4af61d
date: 2020-05-31 22:21:25
---
> 一直没做过Chrome拓展开发，最近发现京东跟阿里一样，在一些权益上刻意为用户设绊子，浪费宝贵的时间，于是顺便做个小工具，也权当Chrome插件开发练手。


![](https://static.1991421.cn/2020/2020-05-31-224428.jpeg)


## 工具的目的
- 自动点击摇一摇
- 定时自动获取目标金额优惠券

工具作用不大，但节省了几次鼠标点击的体力操作和对于定时才可以领取优惠券的惦记。so,个人觉得有点意义。

## 不完美的地方
- 因为是桌面端浏览器打开移动端网页，发起请求，因此还应该要模拟成手机端请求，比如有些活动必须手机端访问才行，应该是可以篡改请求头部来骗过服务端的，这个留待有需求了再解决吧。

## 拓展下载

这里我做的插件如何下载呢，[戳这里](https://github.com/alanhg/jd-tools)

不好用，欢迎吐槽。

## 扩展开发的几点收获

### 如何快速开发
1. 要知道扩展开发需要的技术还是网页三元素，所以了解前端的应该是毫不费力。
2. 要知道扩展crx后缀实际上是个压缩包格式，类似于Java的war包，实际上是一堆的class字节码文件，开发版的不需要打包成crx，也可以直接安装。
3. 要知道官网，具体的技术问题谷歌，看几个别人的开源项目，三者结合足够了。
4. 个人在开发中看了一本EBook-Creating Google Chrome Extensions，看完觉得该书一般，很多的细节点事没有讲述的，但鉴于这类书籍确实不多，假如想通过书籍学习，就了解下，权当做个粗粒度参考


### 扩展的能力范围
既然做，就知道扩展能干什么，比如扩展能像Alfred一样锁屏Mac吗，我想不可以。so，知道一个技术的能力范围即局限性很重要。

1. 拓展打开的网页功能，比如扫描DOM结构，生成目录弹窗，比如修改浏览页面样式，比如操作元素行为都是可以的，因为扩展可以在目标页面加载一段自定义的JS，那么不就为所欲为了吗。
2. 操作Chrome本身的一些功能，比如tab,比如开发者工具，比如主题，再比如notification


### 推荐开发辅助工具
- [Extensions Reloader](https://chrome.google.com/webstore/detail/fimgfedafeadlieiabdeeaodndnlbhid)
	
	比如修改了JS，点击按钮即可重新加载，免去了下载重装的麻烦。当然manifest文件修改是需要重新安装。



## 写在最后
1. 最近半年个人很迷恋小工具的编写，比如IDEA的插件已经写了4个以上，Alfred的workflow写了6个以上，这次又了解了Chrome的扩展开发。这些工具形态虽有所不同，但本质都是我在实际工作生活中为解决实际的诉求，而进行的尝试。这些工具给我带来的直接和间接收益早已超出了本身对其的投入成本。
2. 一直很羡慕那些有Idea，然后快速做出，并不断持续改进、持续推陈出新的人。现在多少也有点这类大神的一点感觉，当然还差很远，所以继续努力喽。
3. 个人觉得技术人多了解几个方面的技术始终是有好处的。就像你熟悉了B，对于A的问题都会有帮助。知识也许有界限，但知识之间也一定有交集和一定互有影响，

寥寥废话，仅供参考。

## 学习资料

- [Chrome extension 官方文档](https://developer.chrome.com/extensions/getstarted)
- 
