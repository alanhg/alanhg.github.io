---
title: window.open引发的认知强化
date: 2020-04-02 09:27:34
tags:
  - JavaScript
---
> window.open这个方法是加载新的资源，一般我们都是打开一个新的网页URL，但是在一次codereview时，我注意到team的成员写了这么一个地址

```javascript
window.open('../../static/template.xlsx')

```

此时项目开发路径情况是这样

```

│── home
│       └── banner
│           └── index.tsx
└── static 
    └── template.xlsx

```




毫无疑问，这个确实是有问题的。构建后，static是一级目录。所以实际上配置的路径应该是`static/template.xlsx`。

但以上不是关键，关键在我一度认为这个写法是`不能正常本地运行`的，因为毕竟其实这个资源地址，并不是WEB访问的地址，而是本地项目资源管理地址，但我自测了下发现确实可以的。于是这就暴露了个认知问题。于是我翻看了下资料。梳理下相关的几个认知

1. URL 
  
	> A Uniform Resource Locator (URL), colloquially termed a web address,[1] is a reference to a web resource that specifies its location on a computer network and a mechanism for retrieving it. A URL is a specific type of Uniform Resource Identifier (URI),[2][3] although many people use the two terms interchangeably.[4][a] URLs occur most commonly to reference web pages (http), but are also used for file transfer (ftp), email (mailto), database access (JDBC), and many other applications.

	也就是说URL代表着网络资源地址，当然这个资源`可以是静态资源也可以是动态资源`。

2. URL`可以是相对路径，也可以是绝对路径`

	路径中可以用 .. ，在浏览器开出处理URL时，会转化相对路径为绝对路径

	如下两个路径地址实际上是等价的，注意第二个里面存在`../`

	```html
https://ss1.bdstatic.com/5eN1bjq8AAUYm2zgoY3K/r/www/cache/static/protocol/https/soutu/img/camera_new_x2_fb6c085.png


https://ss1.bdstatic.com/5eN1bjq8AAUYm2zgoY3K/r/www/cache/../cache/static/protocol/https/soutu/img/camera_new_x2_fb6c085.png

	```

3. 本地开发模式情况下，项目路径与构建打包路径都work的原因
   
   3.1 本地Webpack dev server 暴露的是WEB服务即整体的资源，并不是部分，并没有拦截策略，所以只要localhost:3000/**,可以找到，实际上都是可以正常访问的，当然实际上线我们的资源托管容器是有各种安全策略的，所以才存在即使有该资源也不一定可以访问的情况。

   3.2  开发模式下，TypeScript每个独立的文件确实存在，Webpack能够找到上述的相对路径资源地址，所以`../../static/template.xlsx`work 。

开发模式下之所以`static/template.xlsx` work【毕竟这个路径并不是真正的开发文件路径】的原因是，我们使用了 CopyWebpackPlugin

  
	```javascript
	new CopyWebpackPlugin([
    ...
      { from: './src/main/webapp/static/', to: 'static' },
    ...
    ])
	```

## 写在最后
1. 如上开发者地址确实错误，但是假如有loader支持下自动处理，实际上也可以没问题的。类似于我们的CSS in JS,CSS处理一样
2. 透过这个小的细节，强化下，自己的认知。


