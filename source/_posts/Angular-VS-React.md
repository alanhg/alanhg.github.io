---
title: Angular VS React【译】
date: 2018-10-28 22:41:41
tags:
- 译
- medium
---
![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-030052.jpg)

[原文地址](https://medium.freecodecamp.org/a-comparison-between-angular-and-react-and-their-core-languages-9de52f485a76)

这篇文章，我们将去比较2018年度两大流行WEB技术，同时了解它们的历史，核心差异，使用的核心语言【TypeScript,JavaScript】等等。总体上，这些技术使得开发者能够模块化、组件化来重用，修改，和维护他们的Code
文章的目的并非寻找最佳技术，相反是去对比，突出和阐明一些误读。我们也聚焦在长期里对我们重要的，而非那些细枝末节。

你应该了解，两种技术的对比并无法完全Cover。Angular是一个大而全的MVC框架，而React是一堆开源包集成进去的类库。
注意！这里的技术代指Angular和React。

## 列出问题
- Angular和React的核心差异
- TypeScript特别之处是什么
- 这些技术为什么流行
- 当前开源项目状态如何
- 大厂用的最多的是哪个技术
- 静态类型语言影响代码质量和开发周期吗

接下来的内容将基于这些问题而给出答案

## 关键性比较
这是一个对比，Angular(左)，React(右)

![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-081158.jpg)

值得一提，React在虚拟DOM上的表现是非常棒的，你可能早有耳闻。如果没，我会解释下。

### 问题
假设在一个HTML标记块中，我们想更新一个用户的出生日期

### 虚拟DOM
只更新当前HTML版本与上次的差异。这点与GitHub中，监测文件的变动很相似。

### 传统DOM
更新整个HTML树结构

## 有什么关系
就上面的需求而言，没问题。但假如在一个页面，我们处理20-30个异步数据请求，每个请求我们都替换整个HTML block,那么这将影响用户体验。

需要更多上下文？看[这里](https://medium.com/@hidace/understanding-reacts-virtual-dom-vs-the-real-dom-68ae29039951)

先回到一开始

## 历史
我们需要知道点历史（上下文），这些提供我们一些视角，可能对于未来会有影响。
> 我不深入讨论Angular与AngularJS的事情，这方面有很多[资源](https://www.angularjswiki.com/angularjs/history-of-angularjs/)了。一句话，Google用Angular替代了AngularJS,TypeScript替代了JavaScript。

回到ES4/ES5的时代，JavaScript的学习曲线真的很高。如果你来自Java,C#,C++的世界，面向对象OOP的世界，然后学习JavaScript的话，是真的不直观，换句话说，很蛋疼。

这并不是因为语言写的差，而是因为目的不同。JavaScript的目的是为了异步，比如用户交互，数据绑定，过渡/动画，等等。不同的动物有不同的行为。

## 流行性
Angular与React在2018属于两大流行WEB技术。

Angular比React有更高的检索度，但这并不意味着React与Angular好。但这表明人们有兴趣，同时要知道，用户可能会输入AngularJS或者Angualr，所以其实搜索度更高。

确定无疑的是：两种技术都在发展，未来很光明。但我们也知道，AngularJS后来发生了什么，这点可能React也会发生。不过这就是商业的本质，我们自己也如此。


![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-141924.jpg)
Google Trends Angular vs React

## 开源
React有超过100K的star,拥有1200贡献者，接近300个issue等待解决。
React有一个上市时间的优势，因为它已经发布了3年，这点优于Angular，这也就意味着面对真实世界的问题和通过了严格的测试，总而言之，已经发展成为一个适应性和灵活性兼备的前端类库。

而Angular，有6倍多的issue数，但我们别忘了，Angular是一个框架，而且因为Angular发布于2016年，所以有较少的开发者在使用它。

![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-083818.jpg)

## 大厂都在用什么技术
React最初是Facebook开发用来优化和解耦组件开发。Chris Cordle的[一篇文章](https://medium.com/@chriscordle)指出React在Facebook的使用率是高于Angular在Google。

那么谁在用这些技术呢?
### React
- FaceBook
- AirBnb
- Uber
- Netflix
- Instagram
- Whatsapp
- Dropbox

### Angular
- Eat24
- CVS shop
- onefootball
- Google Express
- NBA
- Delta

## TypeScript和JavaScript(ES6+)

如果只对比Angular与React，而不聚焦核心语言是会误导大家的。
![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-085755.jpg)

就用户基础而言，JavaScript是较大的，但TypeScript正在增长，所以谁有知道再过10-15年，将会带来什么呢。

![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-142152.jpg)
Google trends — TypeScript and JavaScript


TypeScript最初是MicroSoft开发用来简化JavaScript的。2012年发布，是一个编译器，这意味着，你可以在TypeScript文件写ES5代码。

一般而言，TypeScript为面向对象背景的开发者，提供了流畅的过渡，需要注意，TypeScript在ES5时期发布，而ES5还不是一个面向对象语言。

简而言之，你可以通过原型链来实现面向对象和类。但是对于OOP背景开发者，这是很困难的。所以当你选择TypeScript，会觉得很熟悉和舒服。

然而，过去的几年，JavaScript已经有了大量的改变，比如模块，类，扩展操作符，箭头函数，模板字符串等等。总之，这将允许开发者能够写出声明式代码，这将支持OOP语言的特性。

## 静态和动态语言
一个静态语言意味着你可以定义变量的类型（String,Number,Array等）。你可能会问，为什么这是重要的。
假如你想用汽油加油，有一单重要的是，用合适的油，如果你不知道，你可能要买新车了。
当然，严重程度与编程不同，但在某些情况下会是如此。想想，如果你正在开发一款大型应用， 你想知道传参类型，否则你会破坏代码。
好吧，如果你还是困惑，看这里。

### 静态类型特性

![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-105507.jpg)

Static typed property comparison between JavaScript and TypeScript

### 静态类型参数

![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-105559.jpg)
Static typed argument comparison between JavaScript and TypeScript

我已经了解到，大多数开发者相信，静态类型语言意味着可依赖的代码，大多数时候是好于动态类型语言的。坦率讲，很难印证这个观点，因为这个取决于开发环境，开发者的经验和项目本身的要求。

### 调查结果

- 静态类型语言因为要修复类型问题，需要花费更多的时间
- 动态类型语言是易读易写
![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-142938.jpg)

调查指出，平均而言，当开发者使用动态类型语言时，可以小幅度修改就可以节约开发时间。
如果你想深入这个话题，可以阅读这篇文章[which states that you may not need TypeScript (or statically typed languages).](https://medium.com/@_ericelliott)


## 选哪个
所以话题不仅关于Angular和React，而且也聚焦于你愿意投资时间在什么语言上。说实话，这个并不很重要。
但假如我们不得不去选时，似乎TypeScript相对JavaScript亮点并不多。我并不明白为什么人民会忽视ES6+，无论如何，如果你不是类型粉丝，那么在.ts文件中编写ES6代码没有任何阻力。只是如果你需要它，随时可以。

这里有一个简单类声明例子


![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-105913.jpg)

TypeScript


![](http://or0g12e5e.bkt.clouddn.com/2018-10-28-105921.jpg)

JavaScript (ES6)


## IMO
静态类型会更结构化，安全，易读，和更容易去协作（避免传入不期望的值）。然而，当动态类型开发的话，我们有灵活性和创造性，聚焦于开发，而不用过多关注类型，接口和泛型等等。

过去我所构建的Web-Apps,我没有使用静态类型，同时也并没有任何大的问题存在。这并不意味着我不喜欢静态，仅仅是我还不需要它，但也许将来就需要了。


## 补充
- React有效的处理了内存管理
- Reac使用JavaScript(ES6)，ES6于1995年发布
- Angular使用TypeScript,TypeScript于2012年发布
- 静态类型语言很赞，但没它你也可以做的很好
- 动态类型语言可以花费较少的时间，和更高的灵活性
- 假如你一直从事动态类型语言的工作，那么学习静态类型语言会是一个挑战
- TS是ES6+加上类型和一些其它的特性


## 结论
你选择框架亦或类库可能会影响你编程所花费的时间和你的预算。如果你有一个C#，Java，或者C++开发者团队，我会建议你选Angular，因为TypeScript与这些语言相比有太多的相似点。
最好的推荐时以Angular和React去初始化一个应用，然后再做决定前去评估语言和工作流。
正如之前提到的，所有的技术都有自己的优点和相似性，这真的取决于应用提出什么样的要求。
如果想去了解Web生态

- [核心Web理念](https://medium.freecodecamp.org/learn-these-core-javascript-concepts-in-just-a-few-minutes-f7a16f42c1b0)
- [重要的JavaScript方法](https://medium.freecodecamp.org/7-javascript-methods-that-will-boost-your-skills-in-less-than-8-minutes-4cc4c3dca03f)
- [创建自定义Bash命令(Linux/MacOS开发者)](https://codeburst.io/learn-how-to-create-custom-bash-commands-in-less-than-4-minutes-6d4ceadd9590)


