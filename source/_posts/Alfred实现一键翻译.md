---
title: Alfred实现一键翻译
tags:
  - Alfred
  - Workflow
abbrlink: db2d5274
date: 2020-10-03 09:51:01
---
> 应一个朋友的诉求，实现了基于百度翻译API的workflow，这里简单share下

## 翻译服务
因为朋友的明确需求是百度翻译，所以这里也就选择了百度。但个人更喜欢谷歌翻译，因为确实翻译质量相对好些。

使用百度翻译服务需要以下两点

- 注册百度账号
- 获取APP ID，密钥，对应的API服务确保开通

开通地址：https://fanyi-api.baidu.com/product/113

![](https://static.1991421.cn/2020/2020-10-02-170306.jpeg)


## Workflow实现
整个实现很简单，无非是请求API，获取翻译结果，友好展示。

感兴趣的看源码，不感兴趣的直接下载我做的即可。

下载地址：[戳这里](https://github.com/alanhg/alfred-workflows/tree/master/translate)

## 坑-52003错误

在实际开发中遇到了个问题，吐槽下。百度的垃圾果真是出了名的，按照官网API，`使用POST，报一下错，但是GET却可以`。我一度以为是我姿势不对，看了几回API，对比发现是百度的锅。

```
data: { error_code: '52003', error_msg: 'UNAUTHORIZED USER' }
```
## 效果

![](https://static.1991421.cn/2020/2020-10-03-105245.gif)

## 写在最后

毕竟是免费的东西，所以如果出现不稳定，大概率是百度了。



