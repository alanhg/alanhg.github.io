---
title: 我为什么讨厌lodash
tags:
  - lodash
  - JavaScript
abbrlink: c37a2771
date: 2020-02-16 14:35:26
---

![](https://i.imgur.com/zrcrYJD.jpg)

> 在做项目开发，及CodeReview时，我一直推荐Team降低对于lodash的依赖，多用原生写法，发现有人用，我就会关注下，并且反复去问为什么要用lodash。这里我就解释下为何这么讨厌它。


1.  lodash提供了很多的工具函数，有你知道的和你不知道的，过渡使用也就造成了过渡依赖，你可能最终的结果是`了解lodash，而不了解原生JS,防止因为大量使用lodash，而废弃了对于原生JS的学习`
2. 依赖lodash，现实来说`构建包的体积也会随之增大`，当然在带宽，网速很快的今天，似乎这个体积，我们不用过度care
3. 在原生和Lodash提供的方法都可以完成某个功能之时，用lodash可能意味着`性能更差`。
4. lodash的方法很多考虑的情况非常全，所以某种程度`容错性也就强`，但要知道不报错有时比报错更危险。比如find,get，不报错，但一定对吗？
5. lodash的某些方法比如get方法，实际上使得`类型信息丢失`，同时，路径访问参，丧失了静态分析能力，比如重构，这里就会不易发现。
6. lodash的某些方法，如果不熟悉可能会出错，比如isEmpty，要知道`_.isEmpty(true)`结果是true


## 对待lodash的使用态度
1. 完成特定功能，优先使用JS原生写法，当然考虑到目标浏览器兼容性
2. lodash的导入，采用ES模块按需导入，一定程度降低构建打包体积
3. 推荐一个仓库-[You-Dont-Need-Lodash-Underscore](https://github.com/you-dont-need/You-Dont-Need-Lodash-Underscore)，透过这个仓库，我想也可以了解大牛们是如何看待lodash的，同时可以了解到如何用原生实现等价功能
4.  不是说不让用，但反感和排斥，不假思索，就是用lodash解决一个功能的，因为我认为这些人，在这样做的时候，不去思考原生是否能够做到，不去考虑性能，用一句感性的话就是毫无负罪感。
5. 对于那些lodash的无脑粉，也许有一天，开发环境中没有了lodash依赖，你们又怎么办呢。
