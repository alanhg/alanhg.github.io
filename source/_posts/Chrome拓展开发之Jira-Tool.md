---
title: Chrome拓展程序开发之Jira Tool
date: 2021-04-04 22:50:23
tags:
- Chrome
- Extension
- JIRA
---

> JIRA作为我们团队的项目管理工具是工具链中的一环。平时站会每个人也是基于JIRA上的看板来陈述自己做的事情及遇到的问题，但JIRA还是有体验差的地方，比如说Kanban board中的Quick Filters，不支持单选，每次选择都是叠加，这点并不利于我们去快速切换不同filter下的card。
>
> 烦不胜烦，借着节假日，我就索性利用Chrome extension来解决下。



## 解决问题

quick filters实现单选

## 效果

![](https://static.1991421.cn/2021/2021-04-04-230250.gif)

如上，当开启Single Filter后，如果点击新的filter，之前的会自动取消。如果关闭开关，则恢复默认的设置，每次点击新的filter都是追加。



## 实现

具体实现代码直接查看[仓库](https://github.com/alanhg/jira-tool)即可，这里就不再说明。

这里只说下Chrome拓展该功能的原理，即当网页完全加载后，追加开关按钮，对于`quick filters`中的点击事件进行事件捕获，如果点击某个filter，对其它选中的filter自动点击进行反选。



## Chrome商店上架

因为是第一次走商店上架，这里记录下操作过程。

商店开发者平台地址，[点击这里](https://chrome.google.com/webstore/devconsole)

1. 支付5美元注册费用，成为拓展程序开发者
   - 需要visa卡
   - 地区不支持中国大陆，选择香港，填写fake地址即可
2. 点击上传新内容，按照要求填写即可
   - 上传文件类别为zip

当前因为我的应用还在审核中，因此并不确定是否需要几天，官方说法几个工作日。



## Chrome拓展安装

1. 走商店安装，但国内用户需要科学上网
2. crx安装，但前提也是需要上架商店，否则安装会报错`CRX_REQUIRED_PROOF_MISSING`
3. 源代码安装，比如这里下载[jira-tool](https://github.com/alanhg/jira-tool)，访问`chrome://extensions/`，选择加载未打包版，选择chrome-extension文件夹即可

## 写在最后

插件本身较为简单，但却一定程度的提升了使用JIRA的效率。