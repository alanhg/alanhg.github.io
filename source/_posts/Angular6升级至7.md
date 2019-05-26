---
title: Angular6升级至7
tags:
  - Angular
abbrlink: ac1f4e2e
date: 2019-05-26 17:20:56
---
![](http://static.1991421.cn/2019-05-26-092129.jpg)

Angular7正式版于[2018年10月18号](https://github.com/angular/angular/blob/master/CHANGELOG.md)发布，距今半年时间了，再不跟，就落伍了。

因为个人博客平台是Angular6，所以趁机升级下，正好了解下7。

另NG当前最新版是8.0.0-rc5了。最新版情况请看官网。

## Angular7有哪些主要改变呢

1. CLI提示
2. 应用表现
3. Material CDK
4. 提升Selects的可访问性
5. Angular Elements
6. 生态发力【Angular console,@angular/fire,NativeScript,StackBlitz】
7. 更新依赖[TypeScript3.1,Rxjs 6.3,Node10]

简单翻一下，官方博客的[新版说明](https://blog.angular.io/version-7-of-angular-cli-prompts-virtual-scroll-drag-and-drop-and-more-c594e22e7b8c)，具体的API使用上，看文档吧。

### 个人看法
我觉得这些都没啥，目前NG的版本管理就这样，偶数才是大头，奇数就是为了过渡。期待的IVY还是没出来呢，等着吧。

废话不说，看升级。

## 升级版本

这里直接贴出我成功升级前后的版本变化。

![](http://static.1991421.cn/2019-05-26-085831.png)

*注意*
- core-js升级到3会报错，所以这里还是维持2.x

仅仅将这些包的版本变化后，运行及打包都没问题，还是比较顺利的。

## 体积变化
前端的体积大小一直是个值得关注的点，毕竟体积越小，加载速度也就越快。这里贴下升级前后的体积截图。当前项目小，所以体积变化并不算明显，但还是能够看出来main变小了些，大概`减少了18%`

### 升级前-v6
![](http://static.1991421.cn/2019-05-26-084034.png)

### 升级后-v7
![](http://static.1991421.cn/2019-05-26-085639.png)



## 关于升级的官方指南

之前博客有提过，官方维护有升级指南，当然这个很粗，照着做也是会有坑的
这里只提供下，具备参考意义 

[https://update.angular.io/](https://update.angular.io/)


## 