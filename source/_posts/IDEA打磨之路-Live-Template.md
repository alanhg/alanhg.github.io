---
title: IDEA打磨之路-Live Template
date: 2019-08-20 23:18:00
tags:
- IDEA
- WebStorm
- Intellij
- Live Template

---
> IDEA的成功毋庸置疑，18年的时候份额就增长到了50%以上，好在哪呢?作为开发者来说就是太贴心了，很多设计，很多小功能都真正的解决了痛点，提高了效率。
> 最近花了些时间对其中的一项功能-Live Template进行了研究和打磨，这里对此稍微总结和share下。

## Live Templates是什么
> By using live templates, you can insert frequently-used constructions into your code. For example, loops, conditions, various declarations, or print statements.

意思就是利用`live templaces`可以快速插入常用的代码块。

## 秀一把

![](http://static.1991421.cn/2019-08-20-ScreenRecording2019-08-21at00051.gif)

图上为我当前项目前端经常需要这么一个组件类，并且连接了redux及intl，每次写都觉得很浪费时间。于是乎，我就做成了一个模版。

如何做呢，继续看。

## 添加Live Template

### 打开setting-live template

![](http://static.1991421.cn/2019-08-20-153402.png)

_`setting打开 快捷键:command shift A`_

### 添加Live Template

![](http://static.1991421.cn/2019-08-20-153518.png)

### 应用范围设定

即是在哪些环境下，输入简写字符，IDE才提示这套模版。比如这里，我是TypeScript下才使用，便只选择TS

![](http://static.1991421.cn/2019-08-20-154006.png)

### 添加变量

之所以叫live template，就是因为有变量的存在。这里我只控制了组件名称

#### 预定义变量

目前就两个 `$END$`,`$SELECTION$`，`$END$`控制光标位置，而`$SELECTION$`表示选中代码块


[官网介绍-戳这里](https://www.jetbrains.com/help/idea/template-variables.html)

#### 表达式

![](http://static.1991421.cn/2019-08-20-153554.png)

注意表达式可以嵌套，比如我这里是希望组件名称是去后缀文件名称+首字母大写。

#### Skip if defined
解释下这个是什么意思，字面意思就是`如果定义了就跳过`,假如我们这里勾选了，那么光标就会跳过这里进入下一个位置，否则就会停在这里进行修改模式。

假如这里我不选择，即使我们在默认里写了`$END$`，但我们生成模版时，光标会默认在`$ComponentName$`位置

#### 变量缺省值
顾名思义就是当我们没有定义时的默认值，但这里有个小技巧，就是我们可以定义缺省值就是另一个变量值。

![](http://static.1991421.cn/2019-08-20-163400.png)

图上是我在做console模版时设定的，这个好处是什么呢，就是我们存在联动的需求。

![](http://static.1991421.cn/2019-08-20-163530.png)

比如我们在编辑一个变量值时，另一个就会跟着变动。上效果,

![](http://static.1991421.cn/2019-08-20-ScreenRecording2019-08-21at00371.gif)


当进行变量设定后，那一个模版就完成了，点击确定，就可以使用了。


## 总结

一个简单的LiveTemplae就OK了。Code时，liveTemplate可以部分提高我们的生产力，对此我觉得应该做到以下两点。

1. 熟悉IDE下默认LiveTemplate，这些都是前辈们实践中总结出的精华，无论从灵活性和命名上都是很不错的，比如Java下的`sout`,`psvm`,又比如JS下的的`importdefault`,`importitems`等
2. 根据自己项目的情况，Code习惯，将自己常用的提炼为Template，填补默认的不足，比如我就把前端的UT case，console.log，箭头函数等都提炼出来。

但凡重复的工作便成了体力活，而我们需要将这些体力活甄别出来，抽象化，公式化。live template就是个不错的方案，节约了我们时间。so，试试吧。




