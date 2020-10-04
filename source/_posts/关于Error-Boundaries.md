---
title: 关于Error Boundaries
date: 2020-10-04 20:27:08
tags:
- React
- Frontend
- Web
---
> React文档中讲到一个概念-Error Boundaries（错误边界），今天正好在读一本书[《Learning React》](https://book.douban.com/subject/34887887/),借着刚读完的熟悉感 + 结合实际的项目，聊下个人的实践认知。


## 解决的问题范畴

> A JavaScript error in a part of the UI shouldn’t break the whole app. To solve this problem for React users, React 16 introduces a new concept of an “error boundary”.

如上为官网开篇的一段介绍，由此可以看出该技术的根本目标是希望UI层的异常不要导致整体的App的崩溃。

注意

- 仅限UI层
- 对于这种处理实际上，可以看作我们函数中经常写的`try catch`
- React开发模式打包，出现了运行异常，在显示我们既定的错误边界render外，还是会展示堆栈错误信息

	![](https://static.1991421.cn/2020/2020-10-04-212106.jpeg)



### 范畴之外

比如我当前的项目，技术栈为React+Redux+Redux-Saga+Axios等，假如是在Saga-effects中出现了未捕获的异常，实际上也会造成whole app的崩溃，Error Boundaries是无法解决这个问题的，因为不在UI层。那怎么办呢，就是针对性对saga要做try catch,比如做个高阶函数-safe-wrapper。

## Error Boundaries实践

这里没什么好写的，官网[例子](https://reactjs.org/docs/error-boundaries.html#gatsby-focus-wrapper)足矣。当然需要注意的是，因为这种设计，实际上我们也可以很方便的捕获了UI层的错误，发送到issue📱服务上。对于Web产品运维，这还是很重要的。


## 写在最后
在实际开发中，越来越喜欢React，因为足够的简单，足够的纯粹。但同时，在这个simple design的Lib下，也学到了很多，比如设计模式，比如编程范式等等。


## 参考文档
- [React Official - Error Boundaries](https://reactjs.org/docs/error-boundaries.html#gatsby-focus-wrapper)
