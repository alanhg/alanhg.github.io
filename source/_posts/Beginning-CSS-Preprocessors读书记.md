---
title: Beginning CSS Preprocessors读书记
date: 2020-04-14 12:06:36
tags:
- Reading
- CSS
---
> 最近快速阅读一本书《Beginning CSS Preprocessors》， 书中讲解的less,sass，compass使用略显过时，但整体读下来还是有几点收获和想法的，这里Mark下。

![](http://static.1991421.cn/2020/2020-04-14-174815.png)

##  预处理器的使命与其宿命

1. CSS并不遵循DRY原则，所以实际上我们书写的样式中存在大量的重复，而预处理的使命是提高可维护性，灵活性，尽可能的DRY。
2. 预处理器只是将一种形式的样式写法转换为目标CSS写法，所以也就意味着预处理器并不会赋予样式新的功能，只是提高了开发层次的体验。我们现在经常用TS来代替JS开发，但是最终还是会编译为JS。从这个角度来看，两者相似。

![](http://static.1991421.cn/2020/2020-04-14-183611.png)

### 预处理器要用吗
如果WEB过分简单，预处理器用否无关紧要，但站点样式趋向于复杂，为了可维护性，预处理器确实值得使用。有了变量，嵌套，函数，函数，我们可以大幅减少CSS代码量

## less与sass的同与不同
1. less是在sass之后推出的，为了降低学习门槛，less本身兼容了css的写法
2. less的括号结构进而影响了sass，sass后来吸取了less的一些优点，推出了scss，所以技术这东西也是互相影响的
3. sass支持的逻辑判断，less并不支持从这个角度来看sass更为强大。但正如上面所说，强大只是提高了开发体验，同样的输出样式，less也可以做到。

## Compass不再维护
compass于2016年8月开始已经不在维护，但严格来说它并不是死了，只是以另外一种形式存在而已，哪怕只是理念。

扯远点，MacBook系列现在已经被apple砍掉，但是MacBook的一体式机身，USB-C都在之后的MBP身上得到了应用和升级。so，技术都是一样的。

![](http://static.1991421.cn/2020/2020-04-14-221308.png)

## Mac自带Ruby环境

1. ruby是一种编程语言
2.  Mac系统自带ruby，比如我当前的系统是macOS 10.15.4 ,ruby版本是`3.0.3`，多说一点，Mac也自带Python环境。话说为什么Mac要预装ruby和python呢。我觉得应该是一些自带应用`也许是XCode`确实用到了。
3. gem 是 Ruby 的一个包管理器，它提供一个分发 Ruby 程序和库的标准格式，还提供一个管理程序包安装的工具

## 雪碧图

1. 雪碧图的目的是为了减少网络请求，降低网页请求开销，通过定位来显示目标图片
2. 当前我们使用雪碧图，实际上可以直接通过webpack的插件做到


## 写在最后
- 以上这些点，之于我即是在阅读完这本书后得到的些许收获。
- 最近一直瞎忙读书太少了，不得不说，读书确实是系统补充知识的，拓宽视野的好方式

## 参考文档
- [CSS Sprites: What They Are, Why They’re Cool, and How To Use Them](https://css-tricks.com/css-sprites/)
- [Compass用法指南](https://www.ruanyifeng.com/blog/2012/11/compass.html)