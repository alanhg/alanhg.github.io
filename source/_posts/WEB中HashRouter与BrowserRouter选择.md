---
title: Web中HashRouter与BrowserRouter选择
date: 2021-02-05 18:38:50
tags:
- Web
- Router
---
> SPA技术下，对于前端路由，有两个选项HashRouter，BrowserRouter，针对这两个选择，也是有利有弊，需要根据实际情况去选择，这里就总结下。

![](https://static.1991421.cn/2021/2021-02-06-110349.png)



## HashRouter vs BrowserRouter

1. 两种路由的展示形式不同，HashRouter使用的锚点(比如https://1991421.cn#posts)来区分各个路由URL，而BrowserRouter使用的传统URL(比如https://1991421.cn/posts)来区分各个URL

2. BrowserRouter需要后台进行一定的设置，而HashRouter不需要
    ```javascript
    app.get('*', function (req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});
   ```
   
3. HashRouter利用的锚点Hash，假如应用比如业内有目录锚点，会造成额外的问题，比如这样一个URL`https://1991421.cn/#posts/detail/1234567#comment`如果想获取目录锚点comment，使用location.hash结果将是`#posts/detail/1234567#comment`，这种情况下只能文本匹配。

4. HashRouter地址如果是表单提交，本身hash部分是不会作为地址的一部分发出



综上可以发现两种路由利弊都有，原则上还是按需所取，但假如都行，明显采用BrowserRouter会更好些，因为这样不会出现表单提交，业内目录灯新的问题出现，唯一注意的是后台需要一点配置支持。



## SPA路由实现原理





## 写在最后

