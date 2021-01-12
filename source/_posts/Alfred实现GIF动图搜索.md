---
title: Alfred实现GIF动图搜索
date: 2021-01-09 23:16:54
tags:
- Giphy
- Alfred
- Workflow
---

> 微信支持添加GIF到表情包，为了丰富下自己贫瘠的表情包，需要方便的找到新的动图GIF。国外有个网站Giphy还不错，并且提供了API支持，于是花了点时间实现了搜索表情包的Workflow。



## 效果

输入gif或sticker即可进行搜索，回车即可复制到剪贴板，然后⌘ V即可。当然还有些其它一些操作，比如⌥选择即可浏览器浏览，⌘在访达中浏览等。

于是乎，再也不担心找不到酷酷的表情包了。

![](https://static.1991421.cn/2021/2021-01-09-233311.gif)



Workflow下载地址，[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/giphy)



## 实现细节点

为了实现这个workflow还是踩了点坑的，这里Mark下

1. Alfred的[Script filter Input](https://www.alfredapp.com/help/workflows/inputs/script-filter/)中的icon目前`不支持GIF动态显示`，即使是动态GIF。如上可看出搜索结果列表的GIF都只是第一帧静态图

2. GIF拷贝到剪贴板使用`Apple Script`解决，关键代码如下，目前测试，粘贴微信，Typora，印象笔记等均OK

   ```applescript
   set the clipboard to POSIX file thePath
   ```

3. Giphy返回GIF的URL会有一些参数，需要去掉才可正常下载，否则会报`403`

4. 下载的GIF动图属于缓存资源，Alfred针对缓存有推荐位置

   Cache: ~/Library/Caches/com.runningwithcrayons.Alfred/Workflow Data/[bundle id]，对应环境变量**alfred_workflow_cache**
   Data: ~/Library/Application Support/Alfred/Workflow Data/[bundle id]，对应环境变量**alfred_workflow_data**

   当前我选择**alfred_workflow_cache**，但对应workflow文件夹，Alfred默认并不会创建，需要自己手动创建。

5. **alfred_workflow_cache**等路径存在空格，作为quicklookurl时需要进行下编码`空格替换为%20`才可正常使用

6. `Giphy国内被墙`，Mac需要走系统代理，同时Alfred也需要走[代理](https://github.com/alanhg/others-note/issues/231)，才可正常使用

7. Giphy提供了各种平台的SDK，但这里因为是做workflow，因此使用[WEB API](https://developers.giphy.com/docs/api/endpoint#search)

8. Giphy API Key分为Production及beta，Production Key申请审核，5个工作日内即会回信，经测试,申请门槛儿不高。



## 相关资料

- [Alfred Script Environment Variables](https://www.alfredapp.com/help/workflows/script-environment-variables/)

- [Alfred Script Filter Input](https://www.alfredapp.com/help/workflows/inputs/script-filter/)

- [Giphy API](https://developers.giphy.com/branch/master/docs/api/endpoint/#search)

  