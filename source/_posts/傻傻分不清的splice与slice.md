---
title: 傻傻分不清的splice与slice
date: 2021-03-01 23:11:54
tags:
- JavaScript
- 基础函数
---

> 身为前端er，在过去的几年经常使用这两个函数但是真的傻傻分不清，总是需要使用使用看API，或者TS定义，还是抵消，最好的办法还是脑子里彻底记住，毕竟漫威英雄啥的咱不是记得都门儿清吗。so，还是功夫用的不够。
>
> 这里就mark下两者的区别，用于记忆。

## splice

### 单词含义



![](https://static.1991421.cn/2021/2021-03-01-231952.jpeg)



绞接，捻接



### 函数说明

Array.prototype.splice()

> The **`splice()`** method changes the contents of an array by removing or replacing existing elements and/or adding new elements [in place](https://en.wikipedia.org/wiki/In-place_algorithm).

所以，当数组需要增删修改元素时，可以使用该方法。



注意，函数会改变数组本身。



## slice

（切下的食物）薄片，片；小铲

### 单词含义

![](https://static.1991421.cn/2021/2021-03-01-232140.jpeg)



### 函数说明

String.prototype.slice()

> The **`slice()`** method extracts a section of a string and returns it as a new string, without modifying the original string.

Array.prototype.slice()

> The **`slice()`** method returns a shallow copy of a portion of an array into a new array object selected from `start` to `end` (`end` not included) where `start` and `end` represent the index of items in that array. The original array will not be modified.

所以，当字符串或者数组需要获取子集时，可以使用该方法。



注意，函数不会改变字符串或数组本身。对于数组来说，slice返回的新数组只是浅拷贝。



## 写在最后

- 除了这两个函数，还有个相似的比如split，但因为更为常用，所以并不会记混。
- so，理解的同时还是多用。