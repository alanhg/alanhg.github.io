---
title: Intellij IDEA常用插件
tags:
  - Intellij IDEA
  - Plugins
  - 插件
abbrlink: f80c2b95
date: 2019-10-13 22:17:53
---
> Jetbrains系列产品大行其道，原因是用起来确实高效。从本身IDE的功能强大，到快捷键的丰富支持，再到插件生态的丰富等等。一切铸就了它无愧是当前最强IDE。
> 
> 这里列出我在用的几款插件

## Plugins

1. JRebel for intellij
	
	喜欢这个插件的原因是在开发Spring应用时候，可以不用反复重启。节约了碎片化的时间。
	
2. Markdown Navigator
	
	虽然IDEA有自带的MD插件，但是我喜欢这个插件，目前的主要原因是能够一键生成和更新目录。作为一个MD文档爱好者，这点非常key。注意，插件分免费和付费版，付费版才有目录生成的功能。
	
3. Lombok
	
	节约部分代码，比如set,get方法

4. PlantUML integration
	
	对于程序中一些逻辑，有时需要画图来体现。比如流程图，时序图
	
5. String Manipulation
	
	经常会有字符串变量转大蛇式写法，有了这个插件可以快速实现。这个插件是补充了IDE本身对于字符串常用操作的不足。
	
## 注意

大部分IDEA的插件都可兼容WebStorm等产品。

##  插件无法满足？

自己写，比如我就写了一个服务于Team的CodeReview.- [bookmarkex4idea](https://github.com/alanhg/bookmarkex4idea)

Plugin SDK等着你去开发。[SDK](http://www.jetbrains.org/intellij/sdk/docs/welcome.html)

## 写在最后

1. 插件是为了弥补本身IDE自带功能的不足，完成一些个性化或者特定的需求。打磨熟练，可以很大的提升生产力
2. 插件虽好，但不要贪。控制量，否则1是使用混乱低效，2是插件多了也提高了IDE的性能开销。