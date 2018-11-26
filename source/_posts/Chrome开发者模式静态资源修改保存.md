---
title: Chrome开发者模式静态资源修改保存
tags:
  - Chrome
abbrlink: 94e48ed
date: 2018-10-22 23:23:25
---
> 有这样一个场景，我们Chrome下打开开发者模式修改某网页的前端资源，进而达到某个效果，但是刷新即丢失，有办法可以保存吗？yes!Chrome 65更新了一个功能叫local overrides

## 看效果
![image](https://user-images.githubusercontent.com/9245110/47299125-19973a80-d64c-11e8-93eb-c8169efaed04.png)


## 做法

### 添加override文件夹
![image](https://user-images.githubusercontent.com/9245110/47299883-d938bc00-d64d-11e8-9e29-4adc9d342cd3.png)

![image](https://user-images.githubusercontent.com/9245110/47299868-d1791780-d64d-11e8-8c71-c1be87f5976a.png)

### 存储到override
比如我们访问百度搜索，选择baidu这个html网页，单击右键，选择save for overrides.我们会在overrides栏目下及物理磁盘选择的文件夹里看到这个html文件

###  修改文件
我们可以在chrome下修改，你会发现这个文件浏览状态下是可以修改的，俨然就是个编辑器，同时也可以直接修改本地系统下的文件。
修改后，在打开开发者模式情况下刷新页面，会发现修改成功。
![wx20181022-231557](https://user-images.githubusercontent.com/9245110/47301061-96c4ae80-d650-11e8-81d6-7d54368d1e01.png)

目前使用，只可以修改静态资源，比如XHR异步请求是不可以修改的。
## 相关链接
- [Chrome 的local overrides](https://zhuanlan.zhihu.com/p/36677472)
