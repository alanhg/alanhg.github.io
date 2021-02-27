---
title: window.opener
date: 2021-02-27 14:51:22
tags:
- Chrome
- 浏览器工作原理
- JavaScript
---

> window.opener并非JS新特性，但有时却被忽视了，这里总结下它的价值

## window.opener作用

> The [`Window`](dfile:///Users/qhe/Library/Application Support/Dash/DocSets/JavaScript/JavaScript.docset/Contents/Resources/Documents/developer.mozilla.org/en-US/docs/Web/API/Window.html) interface's `**opener**` property returns a reference to the window that opened the window, either with [`open()`](dfile:///Users/qhe/Library/Application Support/Dash/DocSets/JavaScript/JavaScript.docset/Contents/Resources/Documents/developer.mozilla.org/en-US/docs/Web/API/Window/open.html), or by navigating a link with a `target` attribute.

即opener赋予了操作另一个文档的能力，当然不是每一个页面都可以。

这种能力还是有用武之地的，举个例子，A页面点击连接打开了B页面，我现在希望B在点击某个按钮时，A刷新，如何实现呢，opener也许就可以。

## opener存在的条件

有时在控制台尝试window.opener发现返回为null，因为opener存在也需要满足一些条件

1. 同站点
   - 同站点与同源不同，同站点要求相对宽松，即协议，根域名相同即可
2. 是否有连接关系，
   - A连接B，一般有几种方式，a连接，JS执行打开新标签页，iframe包含。
   - 如果直接地址栏输入访问B，则AB无连接关系

若满足以上条件，那么A打开B，B即可访问到window.opener，同时页面也共享同一个渲染进程。

Chrome下也提供了GUI来查看渲染进程情况。如何操作呢，点击三个点的设置=>更多工具=>任务管理器即可查看。

![](https://static.1991421.cn/2021/2021-02-27-150827.jpeg)



如下这个截图中同站点的两个Tab页就在同一个进程下。

![](https://static.1991421.cn/2021/2021-02-27-151017.jpeg)



但稍微改造下网页程序有时又会发现下面的情况即不在同一个渲染进程。

![](https://static.1991421.cn/2021/2021-02-27-151122.jpeg)



### noopener

上述情况下，有时明明是A点击到了B，AB也同站点，但浏览器仍然是分别开启了独立的渲染进程。WHY？因为网页进行了特殊的设定。

无论是window.open还是a标签都有属性可以设定noopener对应也有值opener，当设定了noopener，则A打开B时，B会打开一个新的渲染进程，即B也无法通过window.opener来操作A。



### 注意

Chrome下，测试发现比如A标签，当不手动设定`rel='opener'`，浏览器会开启新的渲染进程。



## 同一个渲染进程的利弊

好处自然是资源共享，对于浏览器用户来说也降低了资源开销，但坏处即如果标签页A死了，那么B也一样会死。因此利弊也很明显，权衡去做即可。

## 写在最后

正如一开始提到提到的B操作A页面，opener即是一个选择，注意这点即可。

