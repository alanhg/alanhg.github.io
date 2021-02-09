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

1. 两种路由的展示形式不同，HashRouter使用的URL哈希形式(比如https://1991421.cn#posts)来区分各个路由URL，而BrowserRouter使用的传统URL形式(比如https://1991421.cn/posts)来区分

2. BrowserRouter需要后台进行一定的设置，因为用户可能在某个URL下刷新，服务端会首先接到请求，那么需要确保该路由下，返回SPA的宿主页面，当然HashRouter不需要
    ```javascript
    app.get('*', function (req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});
   ```
   
3. HashRouter因为利用的URL Hash，假如页面内部有目录锚点，而目录锚点如果放在URL上就会造成额外的问题，比如这样一个URL`https://1991421.cn/#posts/detail/1234567#comment`如果想获取目录锚点comment，使用location.hash结果将是`#posts/detail/1234567#comment`，这种情况下只能文本匹配。

4. HashRouter地址如果是表单提交，本身hash部分是不会作为地址的一部分发出

### 结论

- 综上可以发现两种路由利弊都有，原则上还是按需所取
- 假如都行，明显采用BrowserRouter会更好些，因为这样不会出现表单提交，业内目录灯新的问题出现，唯一注意的是后台需要一点配置支持。

## SPA路由实现原理

不论是BrowserRouter，还是HashRouter，实际上都是依赖于H5中的History API，







## 写在最后

