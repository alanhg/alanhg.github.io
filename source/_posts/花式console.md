---
title: 花式console
tags:
  - console
  - JavaScript
  - 代码黑科技
abbrlink: b1f43e66
date: 2020-07-04 15:24:31
---
> 技术人员习惯性查看网页console，我们会发现有些网页会输出一些炫酷的console信息，当然国内基本上都是招聘。但一直有个疑问怎么做到的呢。

趁着周末研究了会儿，这里mark下。

## 举例子
先贴几个例子。

比如百度的

![](https://static.1991421.cn/2020/2020-07-04-152507.jpeg)


比如知乎的

![](https://static.1991421.cn/2020/2020-07-04-152548.jpeg)


看到这里有2个疑问，颜色样式及文本LOGO这种字符画如何做到的，肯定不会手打出来的吧。


## 实现

1. console支持样式输出，具体配置项可参考[这里](https://developer.mozilla.org/zh-CN/docs/Web/API/Console)
	
	举个例子
	
	```js
	console.log("%cThis will be formatted with large, blue text", "color: blue; font-size: x-large");
	```

2. 比如hire这种字符画，可以使用[在线服务](https://www.kammerl.de/ascii/AsciiSignature.php)即可，比如图片转换可以使用[这个包](https://github.com/IonicaBizau/image-to-ascii),转换为ascll即可。

## 贴下我的

了解后，快速在我的博客平台实现了下，枯燥的console瞬间多了一分乐趣。

![](https://static.1991421.cn/2020/2020-07-04-154412.jpeg)


​	

