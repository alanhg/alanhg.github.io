---
title: '[译]Boostrap3 vs 4'
tags:
  - BootStrap
  - CSS
  - 译
abbrlink: cebcfde4
date: 2018-06-20 06:48:15
---
> Bootstrap于1月19日放出了4的正式版，4带来了一些主要的改变，添加了新的组件，废弃了一些。这里是Bootstrap 3与4的区别

|组件|Bootstrap 3| Bootstrap 4|
| --- | --- | --- |
|全局|
|CSS源文件|LESS|SCSS|
|CSS主要单位|px|rem|
|媒体查询单位|px|px|
|全局字体大小|14px|16px|
|缺省字体集|Helvetica Neue, Helvetica, Arial, sans-serif|Uses a "native font stack" (user's system fonts), with a fallback to Helvetica Neue, Arial, and sans-serif|
|栅格化|
|栅格参数|4种栅格系统(xs,sm,md,lg)|5种(xs,sm,md,lg,xl) *Bootstrap 4已经删除了最小断点的的xs,因此col-*覆盖了所有所有设备`不再需要标明这种情况得尺寸了`*
|偏移|用col-*-offset-*去偏移列,例如col-md-offset-4|用offset-*-*去偏移列，例如,offset-md-4.|
|表格|
|黑色主题表格|不支持|增加dark表格样式，用`.table-dark`|
|Table表头样式|不支持|`.thead-light` 和 `.thead-dark`|
|紧缩表格|`.table-condensed`|`.table-sm`|
|状态类|Bootstrap 3 不用`.table-`前缀，例如Bootstrap 3 用`.active`然而Bootstrap 4 用`.table-active`,状态关键词都是(active,success,info,warning,danger)|添加`.table-`前缀来做表格的状态类
|响应式表格|`.table-response`类必须添加到父级div元素上|一样，同时增加了`table-responsive-*`来表明断点`.table-responsive{-sm|-md|-lg|-xl}`|
|表单|
|水平表单|
|复选框与单元按钮|
|表单控件尺寸|
|表单Label大小|


