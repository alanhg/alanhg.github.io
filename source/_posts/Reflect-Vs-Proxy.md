---
title: JS扫盲之Proxy，Reflect
date: 2021-03-16 23:38:01
tags:
- JavaScript
- Metaprogramming
- 元编程
---

> 前端开发大多时候并没有用到Proxy，但是不代表其没有价值，而是没有掌握它。于是，这里梳理下。



## 元编程

MDN将Reflect，Proxy归类于元编程，那什么是元编程呢。

> **元编程**（英语：Metaprogramming），又译**元编程**，是指某类[计算机程序](https://zh.wikipedia.org/wiki/计算机程序)的编写，这类计算机程序编写或者操纵其它程序（或者自身）作为它们的资料，或者在[运行时](https://zh.wikipedia.org/wiki/运行时)完成部分本应在[编译时](https://zh.wikipedia.org/wiki/编译时)完成的工作。多数情况下，与手工编写全部代码相比，程序员可以获得更高的工作效率，或者给与程序更大的灵活度去处理新的情形而无需重新编译。

以上摘自WIKI，我们可以知道元编程是编程领域的一个概念，非JS所特有。

![](https://static.1991421.cn/2021/2021-03-17-225913.jpeg)

上图摘自https://draveness.me/metaprogramming/

## Proxy & Reflect

Proxy正如其名字，可以对目标对象的set，get，construct操作等进行代理，这样有何好处呢，比如我们可以对值进行转换，或者拦截部分属性访问等。

举个例子

```javascript
const user = { firstname: 'alan' };

const userProxy = new Proxy(user, {
  get: function (target, prop) {
    return target[prop] ? target[prop] : `get prop ${prop} missing`;
  },
  set: function (target, prop, value) {
    console.log(`set prop ${prop} as ${value}`);
    target[prop] = value;
  }
});

console.log(userProxy.lastname); // get prop lastname missing
```

这里，如果访问不存在的属性即会返回missing信息，属性设定值时会打印信息。有时我们可以利用这个切入对象操作，而不污染对象本身。



再者，前端在做表单交互时有时我们希望能够双向绑定，而Proxy就可以实现。







## 参考

- https://stackoverflow.com/questions/39179743/what-is-the-difference-between-proxy-constructor-and-reflect
- https://github.com/Rashomon511/MyBlog/issues/12
