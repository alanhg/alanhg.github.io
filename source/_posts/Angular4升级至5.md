---
title: Angular4升级至5
date: 2018-01-27 14:47:23
tags:
- Angular
- Frontend
---
> Angular5是2017-11-01正式版发布,Angular4是2017-03-23正式版发布，间隔7个月,由于Angular4到5是平滑升级，性能提升,功能增加的同时，浏览器兼容性也没有任何的影响，所以还是有必要升级的。

升级之前，还是有必要了解下有哪些改变呢？

## Angular5有哪些主要改变呢

原文地址:[CHANGELOG](https://github.com/angular/angular/blob/master/CHANGELOG.md)

我这里只大概说下

1.  功能
    表单,路由事件等都增加部分功能
2.  性能
    - 编译器改进，使得增量构建更快
3.  破坏型更新
    - TS要求为2.4.x
    - compiler增加额外依赖
    - i18n，使用新的国际化管道，即可不需要单独导入intl了`intl体积为44KB，对于IE10等浏览器是不小的负担`
    - etc.  
    

## 升级相关模块

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

### Angular4
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-01-27-064154.png)

### Angular5

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-01-27-064154.png)

**单说构建打包出来的体积的话，没变化，但vendor文件消失了，体积都转移到了main中。**