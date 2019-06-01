---
title: 绘图利器PlantUML使用学习
tags:
  - PlantUML
  - UML
abbrlink: 784e2d34
date: 2019-05-26 22:06:31
---
> 最近同事推荐了一个工具`PlantUML`，利用文本来绘制程序的复杂逻辑。体验下觉得不错，这里学习记录下。

![](http://static.1991421.cn/2019-05-26-include_demo.gif)

## 插件下载
Visual Studio Code和JetBrains公司的IDEA等都有对应的插件支持，这里贴下链接。

- Visual Studio Code-[PlantUML](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml)
- JetBrains - [PlantUML integration
](https://plugins.jetbrains.com/plugin/7017-plantuml-integration)

## 上定义

工具有了，开始学习。

### UML是啥

>
统一建模语言（英语：Unified Modeling Language，縮寫 UML）是非专利的第三代建模和规约语言。UML是一种开放的方法，用于说明、可视化、构建和编写一个正在开发的、面向对象的、软件密集系统的制品的开放方法。UML展现了一系列最佳工程实践，这些最佳实践在对大规模，复杂系统进行建模方面，特别是在软件架构层次已经被验证有效。


完整介绍，[戳这里](https://zh.wikipedia.org/wiki/%E7%BB%9F%E4%B8%80%E5%BB%BA%E6%A8%A1%E8%AF%AD%E8%A8%80)

### PlantUML

> PlantUML是款,可以利用文本语言来绘制UML图形的开源工具。PlantUML的语言是一种领域语言。它使用Graphviz来实现流程图的渲染布局。

完整介绍，[戳这里](https://en.wikipedia.org/wiki/PlantUML)

## 图种类
这里只列下图类别

+ 时序图
+ 用例图
+ 类图
+ 活动图
+ 组件图
+ 状态图
+ 对象图
+ 部署图
+ 定时图

各个图的使用场景，有很详细的文章,[戳这里](https://zhuanlan.zhihu.com/p/44518805)

## 常见问题
在了解了常用图和语法之后，实际使用中还是会有些坑，这里列下常见的问题。

### 文件后缀
目前支持*.wsd, *.pu, *.puml, *.plantuml, *.iuml

`个人喜欢.puml，毕竟带了uml方便了解是UML`

### 文本换行
比如图注释，经常文本需要换行，如何实现呢，\n即可

![](http://static.1991421.cn/2019-05-26-140158.png)


## 相关文档

- http://plantuml.com/zh/guide
- https://zhuanlan.zhihu.com/p/44518805