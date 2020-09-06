---
title: Chrome调试小技巧
tags:
  - Chrome
abbrlink: fc06d2d1
date: 2020-07-30 23:00:13
---

> 了解一些Chrome的小技巧，可以节约时间，提升效率，这里记录下平时摸索到的一些点。

## 拷贝请求部分数据

比如拷贝返回body体，可能习惯了在请求详情的response tab页，双击全选，但是操作实际上不方便的，最快的方式如下。


![](https://static.1991421.cn/2020/2020-07-30-230111.jpeg)




## 选择多个资源类型
按住⌘，即可选择多个



![](https://static.1991421.cn/2020/2020-07-30-230146.jpeg)


## designMode

控制台开启后，可以直接编辑页面，有时基于页面编辑修改后，直接给业务演示还是比较方便的，省下来截图PS的麻烦。


```javascript
document.designMode='on'

```
