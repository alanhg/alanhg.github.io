---
title: '[翻译]webpack3:发布'
tags:
  - 英翻
abbrlink: 24e981e7
date: 2017-07-25 12:18:09
---
![It’s finally here. And it’s beautiful.](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-29-1-Ac4K68j43uSbvHnKZKfXPw.jpeg)

原文网址[webpack-3-official-release](https://medium.com/webpack/webpack-3-official-release-15fd2dd8f07b)

webpack v2发布以来，面向社区，我们做出了一些承诺，我们将发布一些你们投票的功能点。此外，我们也承诺以更快、更稳定的周期去发布它们。

不到一年之久的`beta`版，发版之间并没有破坏型的变化,我们承诺这样做，因为是你们，是社区使得webpack如此繁荣。

webpack团队宣布，我们发布了`webpack3.0.0`,你如今可以下载或者更新它。

`npm install webpack@3.0.0 --save-dev`
或者
`yarn add webpack@3.0.0 --dev`

从webpack2升级到webpack3,除了在终端执行更新指令，应该不需要做什么。我们将此作为一个主要的改变，是因为内部的改变，会影响一些插件。

截止目前,我们已经见到98%的用户更新没有什么破坏型的改变。

## 亮点

正如我们所提到的，我们致力于发布那些你们投票所需要的功能。正是由于Github的贡献，来自于我们的支持者和赞助者的支持，我们能够解决任何的问题。

### Scope Hoisting 作用域提升
`作用域提升`是webpack3的旗舰级功能，webpack的一个取舍就是当构建打包的时候，每个模块都打包再单独的函数闭包中去。这些包装函数使得JS在浏览器下运行时较慢的。
相比之下，像Closure Compiler和RollupJS'hoist'这样的工具可以将所有模块的作用域连接成一个闭包，并使得你的代码能够有更快的执行效率。

![体积大小对比](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-29-124018.jpg)

如今随着webpack3的到来，你可以添加下面的插件到你的配置文件中，从而开启这个功能：

```javascript
module.exports = {  
  plugins: [
    new webpack.optimize.ModuleConcatenationPlugin()
  ]
};
```
作用域提升特别是`ECMAScript Module`语法实现的功能。因为这个Webpack可以根据你正在使用什么模块和其它条件，从而回退到正常的构建。

为了解是什么触发的这些回退，我们针对CLI添加一个参数`--display-optimization-bailout`,这个标记将告诉你是什么导致的回退操作。

![fallback](http://or0g12e5e.bkt.clouddn.com/blog/2017-07-30-074058.jpg)

因为作用域提升将会删除一些函数，所以你将会看到较小的体积减少。然而，显著的提升是JS在浏览器中的运行速度。如果你有升级前后显著的对比数据，
欢迎回复一些数据，我们很荣幸去分享这些。

### Magic Comments 魔法注释

当我们在webpack2中引入了动态导入标记(`import()`),用户表示，他们不能够像`require.ensure`那样创建命名chunks。

我们现在引入叫做魔法注释，你可以通过行内注释的方式明确chunk名称

```
import(/* webpackChunkName: "my-chunk-name" */ 'module');
```
虽然这些是我们在v2.4和v2.6已经发布的功能点，但是我们努力去稳定和修复这些功能中的bug,现在已经在v3落地。如今已经赋予了动态导入语法,具有与require.ensure一样的灵活性。

想了解更多的消息，请看我们[最新文档中关于代码分部分中高亮的这些功能点。](https://webpack.js.org/guides/code-splitting-async)


## 接下来是什么

这里有些是我们希望带给你们的东西
+ 更棒的构建缓存
+ 更快的初始化和增量构建
+ 更好的Typescript体验
+ 改进长期缓存
+ WASM模块支持
+ 改进用户体验

## 感谢

我们所有的用户、贡献者、文档作者、博主、赞助者和所有的维护者都是帮助帮助我们确保webpack在未来几年成功的股东。

基于此，感谢所有人。如果没有你们是不可能的，我们迫不及待分享未来的东西。

没时间取做贡献?想以其它形式提供支持?通过捐助到我们的`open collective`成为一个支持者或者赞助者。Open Collective不仅帮助支持我们的核心团队，也支持那些利用空闲时间
花费了大量时间改进组织的贡献者。
