---
title: JS扫盲下的原型链
date: 2021-03-24 20:50:32
tags:
- JavaScript
- JS基础
---

> 原型链是JS基础知识之一，翻阅那么多的文章，不如自行总结一下，温故而知新。
>
> 关于原型链，绕不开几个关键词，prototype,proto,constructor,new等，这里总结下。



如有错误，欢迎斧正。

1. `prototype`是函数身上的属性，`__proto__`是对象身上的属性，`constructor`是对象身上的属性

2. 实例化对象的`__proto__`指向的是创建该实例的原型对象，实例原型的`constructor`会是构造函数，实例原型的`__proto__`指向的是上一级，如果没有其它的对象原型，那就会是Object的实例原型。

   关于这点，可以参考下面这张图，摘自网上。

![](https://static.1991421.cn/2021/2021-03-24-231347.jpeg)

3. constructor这个构造函数，存在于两个地方，一个是es6类写法下的构造函数，一个就是如上对象的构造函数属性。es6 class本身就只是个语法糖，底层原理还是原型链，因此都是一个意思，即构造函数即创建该实例的函数。
4. 原型链指的是继承链条上的各个对象，而不是函数。



### 原型链的好处

区分于类继承方式的一种继承，比较灵活，比如B.prototype=new A()，当我们创建B的实例即可拥有A的方法。



## 测试题

收集以下几道题来测试下理解。

### 题1

```javascript
function Fn(){
    var a = 12
    this.getName = function(){
        console.log('private getName')
    }
}

Fn.prototype.getName = function (){
      console.log('public getName')
}

var fn = new Fn()
var fn1 = new Fn()
// 1，2
console.log(fn.a)
console.log(fn.getName())
// 3，4，5
console.log(fn.getName === fn1.getName)
console.log(fn.__proto__.getName === fn1.__proto__.getName)
console.log(fn.__proto__.getName === Fn.prototype.getName)
//6，7
console.log(fn.hasOwnProperty ===Object.prototype.hasOwnProperty)
console.log(fn.constructor === Fn)
/* 输出
*   undefined
*   private getName
*   false
*   true
*   true
*   true
*   true
*/
```

### 题2

```javascript
function P() {}
var p1 = new P();
P.prototype.age = 18;
P.prototype = {
  constructor: P,
  name: 'zz'
};
P.prototype.num = 20;
P.prototype.age = 20;
console.log(p1.name);
console.log(p1.age, 'dd');
console.log(p1.num);
var p2 = new P();
console.log(p2.name);
/**
 * 输出
 * undefined
 * 18 dd
 * undefined
 * zz
 */
```

### 题3

```javascript
function test() {}
console.log(test.prototype.constructor.constructor);
/**
 * 输出
 * [Function: Function]
 */
```



## 写在最后

理解这些基本的概念，才是写好代码的基础。



## 参考资料

- https://github.com/mqyqingfeng/blog/issues/2