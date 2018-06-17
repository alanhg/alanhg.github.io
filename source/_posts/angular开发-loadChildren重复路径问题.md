---
title: Angular开发-loadChildren重复路径问题
tags:
  - webpack
  - Angular
abbrlink: 272c6847
date: 2017-09-24 22:47:26
---
> ng在开发中是对所有的资源进行模块化，随着web的发展，系统会越来越庞大，为了提升性能，往往会使用懒加载，但由于设计原因，可能会出现以下的设计情况

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-24-144753.jpg)

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-24-144849.jpg)

具体的懒加载代码，比如如下:

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-24-145008.jpg)


![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-24-145032.jpg)

这种配置，运行的话，会出现以下错误

错误如下:
```
ERROR in Duplicated path in loadChildren detected: "./security/security.module#SecurityModule" is used in 2 loadChildren, but they point to different modules "(/Users/heqiang/GitHub/angular-demo/src/app/parent/child/security/security.module.ts and "/Users/heqiang/GitHub/angular-demo/src/app/security/security.module.ts"). Webpack cannot distinguish on context and would fail to load the proper one.

```

## 解决方案

+ 在官方仓库issues中，大家给出的方案是以绝对路径形式进行配置
+ 修改模块名称及模块所在文件夹名称，倘若不一样，也就不存在重复问题

但分析这个问题，其实也在于官方cli工具还是存在不足，希望未来的版本可以解决这个。