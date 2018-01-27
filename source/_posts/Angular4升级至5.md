---
title: Angular4升级至5
tags:
  - Angular
  - Frontend
abbrlink: 1a7d96c3
date: 2018-01-27 14:47:23
---
> Angular5是`2017-11-01`正式版发布,Angular4是`2017-03-23`正式版发布，间隔7个月,由于Angular4到5是平滑升级，性能提升,功能增加的同时，浏览器兼容性也没有任何的影响，所以还是有必要升级的。

升级之前，还是有必要了解下有哪些改变呢？

## Angular5有哪些主要改变呢

原文地址:[CHANGELOG](https://github.com/angular/angular/blob/master/CHANGELOG.md)

我这里只大概说下

1.  功能
    Http请求可以直接设定头部信息了,表单字段增加updateOn blur等选项，路由增加ActivationStart/End事件 etc.
2.  性能
    - 编译器改进，使得增量构建更快
3.  破坏型更新
    - TS要求为2.4.x
    - compiler增加了额外依赖
    - i18n，使用新的国际化管道，即可不需要单独导入intl了
    - etc.  
    

## 开始升级

- CLI升级至1.5及以上，建议最新
`npm install -g @angular/cli`
- 升级项目相关模块包

```
    "@angular/animations": "^5.0.0",
    "@angular/common": "^5.0.0",
    "@angular/compiler": "^5.0.0",
    "@angular/core": "^5.0.0",
    "@angular/forms": "^5.0.0",
    "@angular/http": "^5.0.0",
    "@angular/platform-browser": "^5.0.0",
    "@angular/platform-browser-dynamic": "^5.0.0",
    "@angular/router": "^5.0.0",
    "rxjs": "^5.5.4",
    "@angular/compiler-cli": "^5.2.2",
    "@angular/language-service": "^4.4.6",
    "codelyzer": "~4.1.0",
    "typescript": "2.4.2"

```
    
## AOT打包实际效果

升级后试了下AOT打包，体积情况如下

### Angular4
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-01-27-064154.png)

### Angular5

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-01-27-064154.png)

**单说构建打包出来的体积的话，没变化，但vendor文件消失了，体积都转移到了main中。**

## 写在最后
一个框架的升级，版本迭代，无论如何也是越来越好，这点毋庸置疑，所以对于框架升级，要抱着开放和进取的态度，不要故步自封，充满恐惧。只要合适，只要更好，都值得升级。

比如我在快速的升级后，首先发现有几点对我有益，当然实际上会更多。
1. 比如i18n的变化，NG删除了intl,使用CLDR，原来针对IE11以下和Safari10以下需要加载的intl文件(`47KB`)终于可以不需要了
2. 构建打包文件vendor消失，体积虽然还是算在了main文件中，但还是要承认，文件数量少，意味着浏览器请求链接次数减少，这一定程度还是更好的
3. 增量构建速度，由于改进了编译器，并且升级TS，本身对于编译打包就是有益的，当然这里，由于时间，我没有去详细记录，但是通过官方的介绍，可以肯定的确是变快了。
