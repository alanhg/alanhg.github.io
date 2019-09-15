---
title: Webpack HMR介绍
date: 2019-09-15 23:21:05
tags:
- Webpack
- HMR
- React
---
> Webpack有个HMR功能，这个特性在1.x的时候就有了。但我一直没有去特意关注过，最近因为在改进开发体验,牵扯到改动这里。所以决定梳理下这个，也以此加深对Webpack的理解。

![](http://static.1991421.cn/2019-09-15-140154.jpg)

## 上概念

先上官网概念

> Hot Module Replacement (HMR) exchanges, adds, or removes modules while an application is running, without a full reload. This can significantly speed up development in a few ways:

- Retain application state which is lost during a full reload.
- Save valuable development time by only updating what's changed.
- Instantly update the browser when modifications are made to CSS/JS in the source code, which is almost comparable to changing styles directly in the browser's dev tools.

假如不开启HMR，每当修改代码【HTML,JS,CSS】，整个页面需重载，但是当我们开启HMR，我们只需要加载我们修改了的模块即可。这样从速度上来说，也会更快。另外因为整个WEB需要重载，我们也会丢失一些WEB的状态信息，比如我们单例化存储的一些信息，重载可能就会丢失，so，这不是很不爽。HMR就这样应运而生了。

## 原理

了解下HMR的实现原理，有益于我们知道HMR的能力范围。

1. 当编辑器里修改了程序文件
2. 文件系统识别出修改的程序，告诉Webpack
3. Webpack重新编译打包，通知HMR Server
	- 打包文件明明上都会有hash值，只要源文件有变化，打包出来的文件就会有新的hash值
	
4. HMR Server使用Websocket通知HMR Runtime需要更新，HMR Runtime根据消息请求对应的更新
	- 通知使用Websocket
	- 请求新的模块文件使用HTTP请求

5. HMR Runtime替换模块

![](http://static.1991421.cn/2019-09-15-151747.jpg)

## Angular下如何开启HMR
了解了HMR是什么东西，我们就来看看Angular，React,Vue下都是如何开启HMR的。

官方讲解的比较详细。这里不赘述。详细文档戳这里:[Angular Configure Hot Module Replacement](https://github.com/angular/angular-cli/blob/master/docs/documentation/stories/configure-hmr.md)

- 假如仍有问题，可以看我的[例子](https://github.com/alanhg/blog-admin)，测试可用

### 注意
- 如上所述，HMR是Webpack的功能，并非Angular官方提供和支持。
- index.html宿主页面修改，是不会触发热更新，JS，CSS会，因为开发模式下，JS，CSS都会是JS模块形态

![](http://static.1991421.cn/2019-09-15-142429.jpg)

## Create React App下开启HMR
React系，初始化前端项目一般会使用Create React App脚手架，所以列下该脚手架下如何去开启HMR。另外React项目下有个React-Hot-Loader插件，一般会用到它。那两者什么区别和关系呢

### Webpack HMR 和 React-Hot-Loader区别
- React-Hot-Loader 是 Webpack 的第三方 loader，它针对 React 应用提供了更强大的热替换功能
- React-Hot-Loader 使用了 Webpack HMR API，针对 React 框架实现了对单个 component 的热替换，并且能够保持组件的 state。

由此，我们知道了两者并不是一个东西，Webpack HMR与框架无关，而React-Hot-Loader是为React量身打造的。

### 该用哪个
个人认为既然React-Hot-Loader比Webpack HMR更react化，我们没必要不优先使用更契合react的方案吧。

### 配置开启

1. install React-Hot-Loader

	```
	$ npm install react-hot-loader
	```
	这里，我安装的^4.12.13版本，注意，该版本与"react-router-dom": "^4.3.1"有冲突，将router升级到v5可以解决。

2. 	index.js下开启hot loader
	
	```javascript
	if (module.hot) {
    module.hot.accept('./routes', () => {
        const nextRoutes = require('./routes').default; // Again, depends on your project
        ReactDOM.render(
            <Provider store={store}>
                <Routes/>
            </Provider>,
            document.getElementById('root')
        );
    });
}
	```


弹射出Webpack配置，会注意到，其实dev配置下，HMR是开启的，只是前端代码中没有配置联通而已。

仍有问题，可以查看我的例子-[戳这里](https://github.com/alanhg/react-demo)

## JHipster-React下开启
JHipster是一个开发平台，可以自动化生成一个完整和现代的Web应用程序或微服务架构。我最近接手的项目很多都是基于此搭建的。so这里也啰嗦下jhisper初始化的react项目如何开启HMR。

index.tsx下打开如下代码即可。

```typescript
if (module.hot) {
  module.hot.accept('./app', () => {
    const NextApp = require<{ default: typeof AppComponent }>('./app').default;
    render(NextApp);
  });
}
```
Webpack中关于HMR的相关配置默认都是开启的。

仍有问题，可以查看我的例子-[戳这里](https://github.com/alanhg/jhipster-starter)

## Vue下开启
因为本人不玩vue，所以这里就只贴个链接，需要的自行去看吧。

[戳这里](https://vue-loader.vuejs.org/guide/hot-reload.html)

## 写在最后
- 这里只是简单的描述，通过文章，可以达到能用，也仅此而已。
- 更多细节，建议读读Webpack源码
- HMR或者React-hot-loader本身用到的技术都很简单，但是能够将其运用解决实际的一个问题，这才是值得学习的地方。有时，我们应该尝试去运用所学的技术解决一个通用的问题，而非只是盲目重复的铺业务代码。对吗？想想。

## 相关文档

很多宝贵的知识都是别人的，这里贴下

- [Angular Configure Hot Module Replacement](https://github.com/angular/angular-cli/blob/master/docs/documentation/stories/configure-hmr.md)
- [Webpack Hot Module Replacement](https://webpack.js.org/concepts/hot-module-replacement/)
- [How to add Hot Module Reloading (HMR) to a React app](https://developerhandbook.com/webpack/how-to-add-hot-module-reloading-to-a-react-app/)
- [Webpack HMR 和 React-Hot-Loader](https://zhuanlan.zhihu.com/p/30135527)
- [Webpack HMR 原理解析](https://zhuanlan.zhihu.com/p/30669007)
- [Understanding Webpack HMR](https://www.javascriptstuff.com/understanding-hmr/)