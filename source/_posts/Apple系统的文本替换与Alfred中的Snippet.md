---
title: Apple系统的文本替换与Alfred的Snippet
tags:
  - Alfred
  - Mac
  - 效率
abbrlink: a6dc1db3
date: 2020-11-30 23:23:49
---
> 一直以来很喜欢使用Alfred的Snippet，将常用的文本块录入，同时还支持配置一些参数，平时可以节约输入重复文本的时间。比如之前我们经常进行CR,结束后需要一个简单的总结，为了提升总结效率，我就做了Snippet。
> 
> 但是Snippet的弊端是Alfred只存在于MacOS，身为Apple全家桶用户表示不爽。因为Apple系统本身就存在文本替换支持，于是我不得不将一部分的文本块放在系统层配置，这样才可以跨Apple设备支持。但两者的同时使用也必会带来使用混乱问题。于是，我思考了两者的协作问题，这里mark下。

## Alfred Snippet VS Apple Text Replacement
首先先梳理下两者的不同。

1. 平台局限性
	
	- Alfred仅支持Mac，没有iOS版，有一个remote App，但本质只是远程操控了下Mac版App的一些功能，非真正的iOS移植版
	- Apple的文本替换，会利用iCloud同步到各个设备，一经修改，所有设备都可即时使用
2. 功能局限性
	- Alfred的Snippet本身支持各种变量，另外可以借助workflow，实现更强大的替换，且也可以控制最终光标的位置，总之强大
	- Apple的文本替换就比较简单，仅仅只是字符串之间的替换
	- Mac系统上，文本替换在EN状态下输入不是所有App下都work，比如MacDown，或者Chrome的地址栏，而上述App在中文下Work.对比设备，比如iPhone，iPad则EN还是中文都work。估计是文本替换是存在App适配问题。

## 统一约定

### 文本前缀

文本替换虽然好，但是如果本身文本比较没有特征，在实际的高频输入中就会经常意外触发。为了解决这个问题，就必须制定一个前缀，这里我采用`t`,比如codereview，就会是`tcodeview`。

之所以这么制定也是有些考虑因素

1. 字母优于特殊符号
	
	因为这套文本替换方案也会经常在iPhone中使用，而手机键盘的布局决定字母前缀的话，可以在不切换键盘的基础上快速实现文本替换，这样效率更高
2. t means text，也更好联想记忆，具备友好性

![](https://static.1991421.cn/2020/2020-11-30-235158.jpeg)


![](https://static.1991421.cn/2020/2020-12-01-000153.jpeg)


### 文本短语划分

- 如上所说Alfred并不跨终端，因此对于日常简单的文本短语，比如手机号，家庭地址，邮箱等高频输入的简单文本，在Apple系统层面进行配置
- 对于工作中使用的复杂的，且主要在桌面端解决的，在Alfred中配置

## 效果

### Alfred Snippet
	
![](https://static.1991421.cn/2020/2020-11-30-233141.gif)

### Apple Text Replacement

![](https://static.1991421.cn/2020/2020-12-01-000442.gif)


## 写在最后

感兴趣的试试如上设定，高效才是王道。






