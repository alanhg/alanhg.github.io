---
title: iframe
abbrlink: ede334e1
date: 2021-03-19 18:34:23
tags:
- Web
---

> iframe这种技术并没被淘汰，还是有一席之地，比如WEB广告播放，比如网页Chrome插件，都可能会用到。用户无感更多是在UI操作体验上，但实际上是两个不同的站点服务。对于iframe，这里总结下。

1. 如果iframe包含的站点为同站，则共享父页面的渲染进程，Chrome并不会开启新的进程，如果不同站，则会开启新的渲染进程

   - 共享同一个渲染进程即意味着，如果子页面出现了死循环，父页面会处于等待状态，操作无响应。
   - 需要了解2个概念，同源即`协议;域名;端口一致`，同站即`根域名一致`
     - 举个例子，alan.local页面iframe加载了a.alan.local页面

2. iframe资源加载本身并不阻塞父页面的HTML解析执行，但父页面onload事件在子页面onload之后执行

   - 需要了解页面的几个生命周期
     - window.onload 浏览器不仅加载完成了 HTML，还加载完成了所有外部资源：图片，样式等
     - DOMContentLoaded 浏览器已完全加载 HTML，并构建了 DOM 树，但像图片和样式表之类的外部资源可能尚未加载完成。
     - beforeunload/unload 页面销毁离开

3. iframe作为一种跨域访问资源的方案，对于iframe页面间通讯分以下两种情况

   - 同站

     - 两个站点均设置`document.domain = 'alan-test.local';` 则可以通过JS操作页面元素内容，比如子页面`window.parent.document.getElementById('saveSession')`，父页面操作子页面则是`window.frames['frameId'].document`

   - 非同站

     - 采用CDM(cross document messaging)通讯

       ```javascript
       window.addEventListener("message", (event) => {
         if (event.origin !== "http://example.org:8080")
           return;
       
         // ...
       }, false);
       
       targetWindow.postMessage(message, targetOrigin, [transfer]);
       ```

       