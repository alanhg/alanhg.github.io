---
title: JIT vs AOT
date: 2020-12-06 20:43:39
tags:
---
> 在玩Angular时候，会遇到这两个编译方式AOT，JIT，但是玩React时却不提及，难道是NG所独有的？当然No，玩java也会提及JIT。这里就聊下> 在玩Angular时候，会遇到这两个编译方式AOT，JIT，但是玩React时却不提及，难道是NG所独有的？当然No，玩java也会提及JIT.这里就聊下所两者。

如有错误，欢迎斧正。

## 上定义
这里取[Angular](https://angular.io/guide/aot-compiler)上的一段解释说明。

- JIT：just-in-time
	
	Just-in-Time (JIT), which compiles your app in the browser at runtime.

	![](https://static.1991421.cn/2020/2020-12-06-210909.jpeg)

	
- AOT: ahead of time
	
   Ahead-of-Time (AOT), which compiles your app and libraries at build time.

	
    ![](https://static.1991421.cn/2020/2020-12-06-210919.jpeg)



## 例子分析
以NG的一个demo为例来说明下。

采用JIT编译与AOT编译代码是不同的，JIT编译后的代码并不是浏览器引擎可以正常执行的JS。正如定义所提到的，JIT需要运行时编译，比如Angular的语法，浏览器并不理解，因此就需要内置一个编译器，因此，JIT编译后代码整体会大些，很大占比是因为内置编译器。

比如NG中的一个指令routerLink，JIT编译后的代码中我们仍然可以看到这样的代码块。

![](https://static.1991421.cn/2020/2020-12-06-211217.jpeg)


但是在AOT编译后的代码中并不会存在这类代码。

## React,Java

React之所以不提到JIT，AOT并不是说不存在这个诉求，对于高级语言编译，都会存在这两种模式的选择。React不提及，是因为React本身并不同时提供2种方式，编译打包会将JSX编译为JS，因此可以说React只有AOT编译。

Java其实是JIT编译，因为当我们打包一个Spring WEB，会生成一个jar或者war包，解压缩后会看到一堆的class文件，但这些文件并非机器码，而是Java由java文件到机器码中间的一种-Java字节码，按理说JIT编译就会很慢，但是实际运行中除了一开始加载的慢，后期并没有感觉到慢，这是因为JVM有一套算法，将高频执行字节码编译为机器码，确保更快执行响应。


![](https://static.1991421.cn/2020/2020-12-06-210824.jpeg)



## 参考文档
- https://stackoverflow.com/questions/46777779/is-there-a-aot-for-reactjs-like-the-angular-4-0-has
- https://angular.io/guide/aot-compiler
