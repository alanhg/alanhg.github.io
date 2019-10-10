---
title: React调试-插件篇
tags:
  - React
  - Redux
  - Debug
abbrlink: a007e202
date: 2019-10-10 10:08:01
---
> React组件调试，除了万能油console之外，可以利用react-devtools及Redux DevTools辅助工具。因为Team总会来新人，为了快速入门，这里小结一番。

![](http://static.1991421.cn/2019-10-10-013611.jpg)

_插件安装需要上Chrome商店，如果还不会科学上网，上不了谷歌。我的天，恳请您换职业。当然，b本着人道主义关怀，还是说下怎么解决在不能上谷歌的情况下如何插件安装_

## 获取插件

[https://crxextractor.com/](https://crxextractor.com/)
输入，插件商店地址，点击即可下载crx。拖拽到chrome中即可安装。

## react-devtools

react-devtools是fb`官方`出品插件。源码地址[戳这里](https://github.com/facebook/react/tree/master/packages/react-devtools)

`一句话：插件主要用于react组件结构分析，组件状态监测。`

## 检测元素

![](http://static.1991421.cn/2019-10-10-react-devtools.gif)

假如应用复杂，对于某块展示内容，我们需要快速定位对应的组件代码，那么这个功能就非常有用了。

### 检测不起作用？
maybe检测不起作用，可能是以下原因

1. webpack mode不能是production,该模式下会压缩代码，导致插件检测出错

### context,host元素干扰太多

添加filter

![](http://static.1991421.cn/2019-10-10-react-devtools-1.gif)

## Redux DevTools
该插件用于redux状态检测及调试分析。当然假如app没有应用redux，这个插件当然不需要了。

![](http://static.1991421.cn/2019-10-10-013952.jpg)

1. 右侧的tab工具栏，比如diff,辅助查看每个action执行前后的状态对比
2. 下部工具栏支持导入导出数据JSON等

`一句话：插件服务于我们调试分析redux状态树的数据流`

## 推荐资料

- [What's New with React Dev Tools 4](https://www.youtube.com/watch?v=QFKZmBMgvus)