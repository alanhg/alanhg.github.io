---
title: margin-top的百分比设置
tags:
  - CSS
abbrlink: 7710da21
date: 2021-02-18 20:44:28
---

> margin-top、margin-bottom、padding-top、padding-bottom的值支持百分比设定，而百分比是基于容器即父元素的宽度而非高度来计算的(refer to [logical width](https://drafts.csswg.org/css-writing-modes-4/#logical-width) of containing block)，这点平时容易忽视，这里总结下。

## 举个例子

```css
   .margin-container {
        background: #214177;
        color: #fff;
        width: 600px;
        height: 500px;
      }
      .margin-child {
        width: 200px;
        height: 100px;
        margin-top: 10%;
        background-color: #82a6cb;
      }
```

![](https://static.1991421.cn/2021/2021-02-18-230011.jpeg)

如图child的`margin-top`的高度为60px即600*10%，padding-top类似。

## 注意

- padding，margin支持百分比，而border是不支持百分比的
- 这里是容器宽度即父元素宽度而非元素自身的宽度

## 为什么这么设计

除了注意这个冷门知识点之外，更应该思考的是为什么这么设计，查了[相关资料][#Oh Hey, Padding Percentage is Based on the Parent Element’s Width]，解释如下。

2. 如果基于容器的高，那么会陷入`循环依赖`，容器的高需要依赖于所有容器内元素的高和margin，而如果元素的margin又依赖了容器的高，这是无解的。浏览器的宽与高并不相同，宽是有限的，都是可以确定的长度，而高度是无限的。
2. 如果基于自身又违背了整体的设计，比如字体百分比，基于的就是父元素的字体大小。



## 写在最后

以上即个人认知，欢迎斧正。

## 参考资料

- [Oh Hey, Padding Percentage is Based on the Parent Element’s Width]:https://css-tricks.com/oh-hey-padding-percentage-is-based-on-the-parent-elements-width/

- https://www.hongkiat.com/blog/calculate-css-percentage-margins/
- https://drafts.csswg.org/css-box-3/#margins

