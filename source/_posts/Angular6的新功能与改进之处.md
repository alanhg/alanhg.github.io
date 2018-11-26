---
title: Angular6的新功能与改进之处
abbrlink: 6db7e744
date: 2018-02-14 00:08:28
tags:
- Angular
---
![Angular](//static.1991421.cn/blog/2018-02-13-160906.jpg)
> 按计划Angular6将会在3月底发正式，当前最新版是`6.0.0-beta.3`.

当然Angular6较之5将会使开发更容易，体积更小，速度更快。

## Angular6的提升与功能
+ CLI集成Service Worker支持
    - `ng generate universal <name>`
    - `ng build --app=<name>`
+ CLI改进了Universial与APPShell的支持
    - `ng generate app-shell [ --universal-app <universal-app-name>] [ --route <route>]`
+ 改进了装饰器错误信息
+ TypeScript2.5.x支持
    - `npm install typescript@'~2.5.3'`
+ 许多有价值的功能
+ 添加nativeElement支持
+ 重新引入Query Predicate
+ 对于项目组件，添加缺失的生命周期测试
+ 描述safety worker
+ 添加afterContentInit和afterContentChecked
+ 针对language service的一些修复
  - Typescript2.6的`resolveModuleName`要求传递的路径以'/'分隔
+ 移动init hooks到TView
+ 纠正项目化组件中onDestroy的顺序
+ 针对指令定义，添加类型和钩子
+ 针对CLI render3的应用，支持体积追踪
+ 修复Universial下的plat-detection例子
+ 添加canonical视图查询
+ 编译器关于reflect changes的一些提升
+ 重命名**QueryPredicate**为**LQuery**
+ 重命名**LQuery**为**LQueries**及相关
+ **允许HttpInterceptors注入到HttpClient**
     - 之前，拦截器中注入HttpClient会报循环依赖错误。
     - 现在可能直接在烂机器的构造函数中声明HttpClient对象了
+ 添加navigationSource和restoredState到NavigationStart
     - 当前，NavigationStart是无法知道导航被强制触发还是location改变 
+ 删除注释的生成
+ 修复在窄屏下SideNav高问题

英文原文:[点击这里](https://www.code-sample.com/2018/01/whats-new-in-angular-6.html)

想了解更详细的功能及BUG情况，请查看官方仓库，[点击这里](https://github.com/angular/angular/blob/master/CHANGELOG.md)
