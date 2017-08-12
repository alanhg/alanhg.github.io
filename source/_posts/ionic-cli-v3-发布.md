---
title: ionic cli v3 发布
tags:
  - ionic
  - 英翻
abbrlink: c0bfdce
date: 2017-05-21 16:29:06
---
[英文原版](https://blog.ionic.io/announcing-ionic-cli-v3/)
大家好，很高兴的宣布，ionic cli v3版现在可以使用啦！
自从我们发布CLI v3 Beta版和我们的彩蛋，我们已经见证了众多的早期Beta测试者在他们的ionic项目中成功的使用。这些测试者提供了大量的反馈，当然也有机会中奖。事实上，他们中的许多人几个小时内就找到了其中的彩蛋。尤其最近，当开发者在我们上周举办的编程马拉松中成为了Ionic Jedi Hacksters，我们获得了更多的回馈
([编程马拉松战绩在这里](http://blog.ionic.io/become-an-ionic-jedi-hackster/))除了版本改变外，什么使得这个CLI这么特别呢，让我们看下这版CLI的几个关键点吧。

除了版本变化，这版的CLI特殊在哪呢，我们看下以下几个关键点吧:

## 速度+指南
你可能会留意到这版CLI的安装是如此之快，部分原因是在消除了超过90MB的依赖和成千上万行的旧程序code!如今，当你安装CLI的时候，你会得到更小的空间占用，安装时间也会更短。所以，CLI的速度和表现是我们主要考虑点之一。

另一个考虑点是我们要提供更多的帮助、指南和反馈。大量的命令现在提供所需的交互信息，CLI试图在问题出来时，能够是有用的，有效的。命令帮助已经提升。
仅仅加上`--help`参数到任意的命令上，就可以得到详细的输入信息和参数信息。我们也提供普通使用的样例信息，比如试下下面的这句命令`ionic start --help`


## 插件!
我们对插件的架构使用的不同的方法，之前的CLI提供完成的东西，而如今，我们把非必要的命令拆离出，将这些功能以插件形式存在。这使得，在开发特定功能的项目时候，能够按需添加，并且，核心功能保持很小。

对于CLI-v3的首次发版，有以下4个CLI的官方插件

@ionic/cli-plugin-ionic-angular – 提供有用的构建工具和生成器
@ionic/cli-plugin-ionic1 – ionic1项目的CLI
@ionic/cli-plugin-cordova –对于ionic/cordova项目是重要的
@ionic/cli-plugin-proxy – 代理插件

在Beta测试版时候，一个常见的问题是"为什么命令变了"，比如之前是`ionic build`，如今是`ionic cordova build`,我们深感这个是必要的改变，因为我们的开发者正在构建桌面，PWA和其它一些平台的ionic APP,为了去区分这些不同，我们做出了[这个清单](https://docs.google.com/document/d/1r8nTAaJ5hLIJ1DCwBozU-JGV480Du0xCMIg2dj3JRQo/edit)

### 开始吧
确认你有Node 6+ 和 npm 3+

卸载旧版CLI，全局安装新的CLI:

```bash
npm uninstall -g ionic
npm install -g ionic@latest

```

在你的ionic项目下，确保你已经有标准的ionic项目结构体。比如`ionic info`，这个命令将试图校对你的项目类型，和推荐你安装需要的插件。如果你运行`ionic cordova`,将提示你安装cordova插件，如果你运行`ionic --help`，你将看到所有命令列表。
对于ionic/cordova app,你需要安装cordova插件(ionic/cli-plugin-cordova)和项目插件(@ionic/cli-plugin-ionic-angular 或 @ionic/cli-plugin-ionic1)。

对于ionic angular:
```bash
npm install --save-dev --save-exact @ionic/cli-plugin-ionic-angular@latest
npm install --save-dev --save-exact @ionic/cli-plugin-cordova@latest
```

对于ionic 1:
```bash
npm install --save-dev --save-exact @ionic/cli-plugin-ionic1@latest
npm install --save-dev --save-exact @ionic/cli-plugin-cordova@latest
```
CLI也会偶尔提醒你更新这些插件。

## 已知的问题

对于已经发布的CLI V3，我们有些事情正在做

+ `ionic start` 仍然花费很长的时间取下载依赖。(#2231)
+ `ionic start` 目前还不支持可选性，比如从github仓库，一个zip url或者ionic作者的项目 (#1989)
+ 使用`ionic cordova`命令修改`config.xml`有4个空格，对于已存在的APP，会有警告信息。我们写入`config.xml`是因为资源生成和热启。
+ 对于ionic1,一些gulp hook不能被掉起
+ 在安卓设备上，升级到CLI v3在部署时，不能正确的提取

对于CLI更新的完整清单，请查看[CHANGELOG.md](https://github.com/driftyco/ionic-cli/blob/master/CHANGELOG.md#upgrading-from-cli-2),
对于更多文档，请看[README.md](https://github.com/driftyco/ionic-cli/blob/master/README.md)。

有问题？想法？反馈？请在[仓库里](https://github.com/driftyco/ionic-cli)创建Issue，让我们知道。
感谢所有的Beta测试者，尤其感谢那些在仓库上提出有贡献性的Issue、评论和PR的人。