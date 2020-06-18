---
title: P标签中不能包含块级元素
date: 2020-06-17 09:49:44
tags:
- HTML
---
> 最近在CR时，发现有人在P标签中包含了div块级标签。这实际上是个错误。这篇文章就系统说明下。

## P标签的定位

> HTML <p>元素（或者说 HTML 段落元素）表示文本的一个段落。该元素通常表现为一整块与相邻文本分离的文本，或以垂直的空白隔离或以首行缩进。另外，\<p\> 是块级元素。

> 短语元素（Phrasing content） 规定文本和它包含的标记。 一些Phrasing content就构成了段落.


摘自MDN，按照文档的说法，P标签内是允许短语元素的（Phrasing content）。但是块级元素并不允许。


## P标签中包含块级元素

### HTML中直接包含

浏览器并不报错，但是代码会被自动的纠正

源码如下

```html
 <p>
          <div>
            hello world
          </div>
    </p>
```

浏览器解析后，会是

```html
<p>
    </p><div>
      hello world
    </div>
<p></p>
```

so，这里就会有BUG的风险，比如样式是`p>div`,那就会失效。

### JS下创建DOM

注意假如JS下创建，浏览器并不会`纠正问题`,仍会原样创建DOM元素

```html

<p id="“myPara”">
</p>

<script>
      document.getElementById('“myPara”').innerHTML = ` <div>
            hello world
          </div>`;
    </script>
```

### React等框架

SPA如今很流行，但这些框架仍然是JS，因此如上也是可以P标签包含块元素的，但是会有error报错


![](http://static.1991421.cn/2020/2020-06-17-101621.jpeg)

## 写在最后
虽然说问题并不严重，但遵从实践标准很重要。标准化的HTML，有益于SEO，对于开发也可规避如上的问题，so注意为好。


## 参考文档
- [Why can't the \<p> tag contain a \<div> tag inside it?](https://stackoverflow.com/questions/8397852/why-cant-the-p-tag-contain-a-div-tag-inside-it)
- 