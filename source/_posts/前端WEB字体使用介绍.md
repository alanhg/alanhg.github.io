---
title: 前端WEB字体使用介绍
tags:
  - Frontend
  - WebFonts
  - CSS
abbrlink: 8e1d6bad
date: 2019-08-11 11:48:21
---
> 最近在做的一个WEB项目，刚拿到UI设计师给出的效果图,于是花几天时间，对整个项目的样式做了规划和调节。其中字体方面使用的并不是系统默认字体，而是`lato-regular，lato-bold`,so需要做下字体的导入设定了。这块虽不难，但之前并没有系统梳理过，so，这里查查资料，结合之前的使用，总结一番。

## WEB字体基础知识

### font-family属性
网页中关于字体设定，我们会使用`font-family`或`font(简写属性)`属性，CSS中关于font-family属性介绍如下

```The font-family CSS property specifies a prioritized list of one or more font family names and/or generic family names for the selected element.```
大致意思就是对于目标元素，字体会使用我们标明的字体集，并且按照设定的字体优先级。

#### 字体设定生效原理
我们设定字体后，网页进行显示去找浏览器，`浏览器会从终端系统层面读取对应字体`。假如设定的字体，系统层面没有安装，那么浏览器会按照优先级使用下一个字体设定。但是假如指定的多个字体系统都没有呢？那么浏览器就会走浏览器层面设定的默认字体了。

so,为了保证显示一致性，我们进行字体设定时，一定要尾部加上几个确保系统安装了的字体。

![](http://static.1991421.cn/2019-08-09-161335.jpg)

```css
.a {
    font-family: medium-content-sans-serif-font, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
```

如上为medium中对于a元素的字体设定，注意到前面的几个字体或为自定义的，或为各个系统不同的，而最后一个字体sans-serif是各个系统都存在的。

### 前端三要素&WEB字体所在范畴
以前刚开始做前端，就天天说，前端三元素，是谁呢？HTML，CSS，JavaScript。

WEB字体属于谁？CSS，这也许是个废话，但请先记住。

## 自定义字体导入

### 导入方法

前端三要素，对应也就是3种方法。

1. @import

	我们的前端CSS这块使用了less预处理器，在less下，我们这样来进行的自定义字体导入

	![](http://static.1991421.cn/2019-08-09-161644.jpg)
	
	_注意_
	- URL可以是相对路径也可以是绝对路径。假如是跨域地址，需要访问权限设定
	- @font-face为CSS3特性，不同浏览器对于字体文件的类型支持.
		Internet Explorer 9, Firefox, Opera,Chrome, 和 Safari支持@font-face 规则.	Internet Explorer 9 只支持 .eot 类型的字体, Firefox, Chrome, Safari, 和 Opera 支持 .ttf 与.otf 两种类型字体.

注意： Internet Explorer 8 及更早IE版本不支持@font-face 规则.

2. Standard方式

	```html
<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Condiment'>
	```
3. JavaScript 方式
这个办法怎么做呢，简单！JS不是能操作HTML元素吗，所以我们就可以动态添加link即可。

```javascript
document.head.innerHTML += '<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Condiment">';

```
注意，我们动态添加的CSS，JS都会在添加成功后，加载执行。

## 字体图标
关于字体设定，就那么点东西，上面都已经说完了。但这里稍微拓展说下现在常用的字体图标。
图标的使用最早就是图片，现在相对较好的方案是字体图标和SVG了。

字体图标的实现原理这里说下

1. SVG图标设计
2. 图标转化为Font字体文件
3. CSS语义化图标样式，伪元素content控制图标对应的Unicode编码

原理大致如上，使用字体图标，我们就不用像以前一样那么繁琐的管理图片资源了，另外矢量方案，不会失真。

但，缺点也很明显。比如字体要么单色，要么渐变色。这点要注意。

### 推荐的字体图标方案
常用的字体图标方案是FontAwsome和IconFont，我做项目关于第三方使用，一般会在这两个里面去权衡选择。

但两者各有优缺点。FontAwsome的图标整体一套是一个风格，so灵活性就少了些，另外一套下来体积不小。而IconFont跟淘宝一样，喜欢的就加入到`购物车`,最后打包下载即可。选哪个？看场景需求喽。

## 写在最后

很多年前，我惊艳和疑惑Apple官网的颜值，困惑为什么它网页的字体比其它的网页漂亮舒服，后来从事网页开发才明白，人家那是加载了个性化字体~苹方字体~。时间过的好快，很多网页现在都已经做了字体加载了。字体加载确实会增加前端体积上的负担,但体积问题带来的延迟，可以各种手段的进行缓解和解决，比如CDN，比如GZIP，比如HTTP2。用户体验只能追求更好，并不能压缩。so，前端始终要向为了给用户呈现更美更好的服务和事物而努力。

![](http://static.1991421.cn/2019-08-11-034634.jpg)

## 相关文档
- [使用 Google Fonts 为网页添加美观字体](https://www.ibm.com/developerworks/cn/web/1505_zhangyan_googlefont/index.html)
- [苹方字体](https://zh.wikipedia.org/zh-hans/%E8%8B%B9%E6%96%B9)
- [](https://zhuanlan.zhihu.com/p/47737638)