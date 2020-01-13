---
title: NPM间接依赖包版本问题
date: 2020-01-13 23:07:02
tags:
- NPM
---

> Package.json中有依赖和开发依赖，但这些依赖都可统称为直接依赖，而我们依赖的包本身也可能依赖一些包，那这些依赖的包版本是如何管理的呢，并且当我们项目直接依赖了A 1.x，而间接包依赖了A 2.x,最终我们是安装的1.x还是2.x呢？

![](https://i.imgur.com/oZRflfJ.jpg)

## 答案
`实际上，两个版本会并存`,package.json中记录的是棵依赖树，对应node_modules下的存储也如此。

举个例子，项目中依赖了`@types/react`,而依赖的`@types/react-router-dom`间接依赖了`@types/react``

![](https://i.imgur.com/JobaOGw.png)

![](https://i.imgur.com/hVzK25v.png)

#### 注意

这里的`*`表示任意版本，所以安装时就会安装最新版本。

### 执行yarn install

![](https://i.imgur.com/x1nFysu.png)

![](https://i.imgur.com/uALbGRS.png)

如上可知，实际上项目中安装了两个版本的`@types/react`。其中一个`16.8.25` 在node_modules根下，另一个`16.9.17` 在`@types/react-router-dom`下。

## 错误
当有了两个版本的`@types/react`,执行打包命令，报错

![](https://i.imgur.com/s70mYk4.png)

## 解决办法
去掉直接依赖`@types/react`，重新执行安装，我们会看到一个`16.9.17`` 在node_modules根下，`@types/react-router-dom`下没有了`@types/react`。重新执行构建命令，不再报错。


## 结论
1. 当我们的包间接和直接依赖了同一个包的不同版本，在安装时，实际上都会安装
2. 包直接和间接依赖了同一个版本时，包会在根路径下，当存在多版本时，那么包会在对应依赖该包的路径下

## 参考文档

- [Understanding the npm dependency model](https://lexi-lambda.github.io/blog/2016/08/24/understanding-the-npm-dependency-model/)
- [Understanding npm dependency resolution](https://medium.com/learnwithrahul/understanding-npm-dependency-resolution-84a24180901b)
