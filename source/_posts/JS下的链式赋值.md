---
title: JS下的链式赋值
date: 2021-03-25 23:11:53
tags:
- 基础
---

> 今天看到群里发了一道JS基础题，以为很简单，但是不小心还做错了，于是这里Mark下。



```js
var yideng = {
  n: 1
};
yideng.x = yideng = {
  n: 2
};
console.log(yideng.x);

```

## ~~错误分析~~

错误的以为等价于如下代码

```js
var yideng = {
  n: 1
  };
yideng = {
    n: 2
 };
yideng.x = yideng;
console.log(yideng.x);
/**
* {n: 2, x: {…}}
* /
```

浏览器或者Node下执行，发现正确结果应该是`undefined`

##   ~~继续错误分析~~

 我重新翻了下JS的赋值运算符。针对链式赋值

> Chaining the assignment operator is possible in order to assign a single value to multiple variables

也就是说实际上JS做的事是将一个值分别赋给了多个变量。即a=b=c应该等价于`b=c;a=c;`



因此上述代码等价代码如下

```js
 var user = {
        n: 1
      };
      user = {
        n: 2
      };
      user.x = {
        n: 2
      };
      console.log(user.x);
```

心想，这回总该对了吧，浏览器运行发现结果是`{n: 2}`还是不对，呃呃呃，问题在哪？- 成员访问点运算符。

## 正确分析

>  成员访问点运算符的优先级是最高的

因此重新再分析代码

```js
var user = {
  n: 1
};

user.x = user = {
  n: 2
};
console.log(user.x);

/**
* user.x这时指向的是一开始的user，将其看成1
* {n：2} 作为新的user，即2
* {n：2}赋值给1的x
* 最后打印2的x，没有这个属性，因此undefined
*/

```



这么简单的题，说实话，挺坑的。不过也暴露了基础不扎实，同时自信品品这道题好几个细节点。



1. 点运算法符优先级高于赋值运算符

2. 链赋值基本逻辑是1个值同时赋给多个变量，并且赋值顺序是自右向左，这点其实也可以做个实验来证明，比如使用Proxy代理对象即可

   ```js
   var superman = {
     name: 'clark'
   };
   
   var batman = {};
   var flashman = {};
   
   const batmanProxy = new Proxy(batman, {
     set: function (target, key, value) {
       console.log(`batman: ${key} set from ${target[key]} to ${value}`);
       target[key] = value;
       return true;
     }
   });
   
   const flashmanProxy = new Proxy(flashman, {
     set: function (target, key, value) {
       console.log(`flashman: ${key} set from ${target[key]} to ${value}`);
       target[key] = value;
       return true;
     }
   });
   
   batmanProxy.name = flashmanProxy.name = superman.name;
   
   ```

   以上代码打印会发现，首先被调用的set方法是flashman的

3. 对象赋值是地址赋值











