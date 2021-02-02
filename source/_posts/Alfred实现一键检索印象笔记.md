---
title: Alfred实现一键检索印象笔记
tags:
  - Alfred
  - Alfred4
  - Workflow
  - 印象笔记
abbrlink: 19a8050f
date: 2020-05-30 13:12:55
---


> 最近思考如何在Alfred中实现印象笔记的检索功能，好在社区中已经有好人实现了一版，但其支持的是Alfred3及Evernote，所以需要进行下改进。当然如果功能有不满意的，还需定制自行改进下，不过问题不大，开搞。


## 当前效果


![](https://static.1991421.cn/2020/evernote-workflow.gif)


下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/%E5%8D%B0%E8%B1%A1%E7%AC%94%E8%AE%B0)


想知道如何做到的，继续看。

## 脚本改造


将scpt文件中的两处进行替换

- `com.evernote.Evernote`替换为`com.yinxiang.Mac`
- `com.runningwithcrayons.Alfred-3`替换为`com.runningwithcrayons.Alfred`


### 查看APP签名

如何获取目标APP的签名信息呢？命令如下

```bash
codesign -dv --verbose=4 /Applications/印象笔记.app
```


## 写在最后

- 在前人基础上，2个替换就实现了印象笔记的支持，还是比较简单的
- 为何Alfred能够做到印象笔记检索呢？背后的可行性是在于，Evernote本身开放了部分API，本身就提供了apple script的支持，具体可查看[Evernote开发者API](https://dev.evernote.com/doc/articles/applescript.php)。
- 印象笔记是Evernote的中国区本土化产品，但核心的功能毕竟还是Evernote，所以也就支持了。


## 参考文档
- https://lloyar.github.io/2019/01/16/evernote-and-alfred.html
- https://www.alfredforum.com/topic/840-evernote-workflow-9-beta-4-alfred-4/
