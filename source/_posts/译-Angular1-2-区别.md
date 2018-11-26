---
title: '[译]Angular1 2 区别'
tags:
  - Angular
  - 译
abbrlink: c259d3c3
date: 2018-05-22 17:55:11
---

原文链接:[点击这里](http://www.learnangularjs.net/differencebetweenangularjs1vsangularjs2.php)

## 写在前面
北京时间，当前NG的版本已经是v6.0.3,现在讨论1，2差异还有意义吗?有，2，4，5，6的更新更多是一些功能，编译器等等，至于模块，组件，管道，注入，指令，路由等等这些都未曾变过。所以无伤大雅。放宽心，继续看吧。

## 1与2的差异性
> 我们讨论下Angular1.x与Angular2的区别，你将会了解到过时的Angular 1.x与Angular 2的进步之处。以下是它们之间的一些区别:

1. Angular 2 是重写的全新的框架，并不是Angular1.x的简单升级。
2. 早期Angular1.x中的控制器的被Angular 2新引入的web标准组件。
	![](//static.1991421.cn/blog/2018-05-22-093030.jpg)
3. Angular 1.x使用 $scope，而在Angular 2或者4里，你将不会找到它，相反使用zone.js来做代码检测。
4. Angular 2或4更多的聚焦移动版的支持，而在之前的1.x则受限于一定范围
5. Angular 2 用TypeScript来开发，TypeScript有大量的语法糖及是JavaScript的超集，它具备了ES6的所有规格，然而如果是Angular1.x，并没有这样的概念。
6. Angular 2 用层级依赖注入系统，并且它实现了基于单向树的改变检测，这提升了表现
7. Angualr2中依赖注入的实现方式是构造函数
8. 在Angular2本地变量定义使用hash前缀
9. 结构化指令标记已经从"ng-repeat"改变为"*ngFor"
10. 小驼峰命名规范在Angular 2 中使用，比如构建指令使用是"ngClass"和"ngModel"，	而1中是"ng-class"和"ng-model"
11. 只有一个方式去启动angular,而在1中有两种方式，一个是用"ng-app"属性，一个是通	过代码
12. 在Angular1.x中，"$routeProvider.when()"被用于配置路由，在2中，我们使用@RouterConfig{(...)}。1中的"ng-view"被改为"",路由现在是独立的模块，因此我们需要导入它。两个或者更多的新的配置被要求去使得路由生效。一方面路由配置OK是添加[ROUTER_DIRECTIVE]作为指令，另一方面是添加在providers list中。Angular 1.x中ng-href使用，而在2中被改为"[router-link]"。
```html
<ul>
  <li><a [routerLink]="['Home']" href="">Home</a></li>
  <li><a [routerLink]="['Contact']" href="">Contact</a></li>
</ul>
```
13. 之前我们在1中使用的比如"ng-href","ng-src","ng-hide"，现在已经都被废弃，因为我们现在可以用心的参数"href"，“src”,"hides"去获得同样的输出
14. 1中的单向数据绑定指令"ng-bind"，在2中我们使用[property]。
15. 1中的双向数据绑定"ng-model"，在2中我们使用“[(ngmodel)]”
16. 对比2，Angular1.x更易启动，仅仅添加类库开启一个Angular1.x项目。但是2依赖4个重要文件，zone.js,system.js，shim.js,reflect-metadata和安装程序node.js，TypeScript，缺一个，我们都不能启动Angular2 项目。

![](//static.1991421.cn/blog/2018-05-23-065813.jpg)

希望你作为一个读者已经理解了Angular1.x与Angular 2的差异性。


