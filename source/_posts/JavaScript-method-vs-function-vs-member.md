---
title: JavaScript method vs function vs member
date: 2020-03-01 17:01:49
tags:
- JavaScript
- TypeScript
---
> 一直对这三个概念，模糊不清，于是决定梳理下。

![](https://i.imgur.com/IOvJYBA.jpg)

## Method

> A method is a function which is a property of an object. There are two kind of methods: Instance Methods which are built-in tasks performed by an object instance, or Static Methods which are tasks that are called directly on an object constructor.
> 
> 一个方法就是一个函数，是对象的属性之一。有两种类型的方法：实例方法是由对象实例执行的内置任务，另一种是静态方法，在对象构造函数内直接调用的任务。

以上摘自MDN


## Function

> Generally speaking, a function is a "subprogram" that can be called by code external (or internal in the case of recursion) to the function. Like the program itself, a function is composed of a sequence of statements called the function body. Values can be passed to a function, and the function will return a value.
> 
> In JavaScript, functions are first-class objects, because they can have properties and methods just like any other object. What distinguishes them from other objects is that functions can be called. In brief, they are Function objects.

以上摘自MDN

## Member

成员这个概念体现在一个接口或者抽象类里,成员可以是个方法，也可以是个变量值。

以上为个人理解

## Difference between Function, Method and Constructor calls

在`Effective JavaScript`一书中，有这么一小节。
> If you’re familiar with object-oriented programming, you’re likely accustomed to thinking of functions, methods, and class constructors as three separate things. In JavaScript, these are just three different usage patterns of one single construct: functions.

也就是说`函数，方法，类的构造函数，都只是单个构造对象的三种不同的使用模式`。

### 需要注意

1.  方法调用将被查找方法属性的对象作为调用接收者。
2. `函数调用`将全局对象（处于严格模式下则为undefined）作为其接收者，一般很少使用函数调用方法来调用方法。
3. 构造函数需要通过new运算符调用，并产生一个新的对象作为其接收者。

### nonmethod
有些方法不是在一个特定对象中被call，这种方法就是nonmethod，如下即是


```javascript
function hello() {
    return "hello, " + this.username;
}
hello(); // "hello, undefined"
```


## tslint - prefer-function-over-method
在tslint规则中有这样一条rule，方法中没有用到的this时，警告，提示修改为函数。

为啥呢，看到stackoverflow中一个非常好的解释

### 举个例子

```typescript
// ts
class A {
    fn1() {}

    fn2 = () => {}
}

// js
var A = (function () {
    function A() {
        this.fn2 = function () { };
    }
    A.prototype.fn1 = function () { };
    return A;
}());
```

如果继承这个类，重写fn2函数呢，怎么办

```typescript
class B extends A {
    private oldFn2 = this.fn2;

    fn2 = () => {
        this.fn2();
    }
}
```
将fn2改为方法,再看一下如何重写。

```typescript
class A {
    fn1() {}

    fn2() {}
}

class B extends A {
    fn2() {
        super.fn2();
    }
}
```

### 结论
1. 方法，函数，在编译后是不同的。
2. 单从性能上来看，`函数是面向类这个对象而不是类的每一个实例，所以更内存友好。`
3. 规则的意义是，类实例里的方法没有用到this，说明每个实例都是一样的，从开销来说比较浪费，所以建议切换为函数。

## Implement Members vs Override methods

IDEA或者Webstorm中的生成代码功能可以提高效率，在TypeScript 类中，当唤起生成快捷键时，注意到会有两个选项`Implement Members`与`Override methods`

![](https://i.imgur.com/GjO75od.png)

那么这两个什么区别呢。

1. 如上member部分有说明，成员更多体现在一个抽象类，接口中，而当我们具体写实现时，就会有用，比如我们声明一个接口类，有A，B两个属性，当我们实例化一个接口变量时.
	![](https://i.imgur.com/89FT1SJ.png)
	
2. 当我们写组件类时，比如想重写钩子，就需要选择override methods,因为React.Component是个类，而不是接口，毕竟也是有完整实现的。


## 写在最后
到此为止，认知似乎得到了进一步的提升。

## 参考文档
- [Method - MDN](https://developer.mozilla.org/zh-CN/docs/Glossary/Method)
- [Implementing/Overriding Members](https://www.jetbrains.com/help/rider/Code_Generation__Implementing_Overriding_Methods.html)
- [Function declarations or expressions for class methods?](https://stackoverflow.com/questions/39048796/function-declarations-or-expressions-for-class-methods)
- [effective javascript](https://learning.oreilly.com/library/view/effective-javascript-68/9780132902281/ch03.html)
