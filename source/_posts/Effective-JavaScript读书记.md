---
title: Effective JavaScript读书记
tags:
  - JavaScript
  - Book
abbrlink: 2b69f266
date: 2020-02-24 08:39:37
---
> 断断续续才把这本书读完
> 
> 这本书以菜谱的方式讲述了JS的关键点，学到了很多，Mark下

![](https://i.imgur.com/BwrqWcB.png)


## 版本

1. ES是标准，JS是实现，我们网页中的JS是客户端执行，所以客户端即浏览器不同，对于JS，乃至HTML，CSS的支持也就不同。所以才有我们常说的兼容性问题，相同的JS在不同浏览器下的执行结果也不见得相同。
2. 因为现在有了TypeScript,Babel，我们在开发中实际上可以书写较新的ES，比如ES6，7，8，而利用TSC和Babel编译到目标JS版本，同时对于不支持的语法，加入polyfill

## 数字计算

1. 和其它语言如 Java 和 Python 不同，JavaScript 中所有数字包括整数和小数都只有一种类型 — `Number`。它的实现遵循 IEEE 754 标准，使用 64 位固定长度(8个字节)来表示，也就是标准的 double 双精度浮点数（相关的还有float 32位单精度)
2. 理论上用有限的空间来存储无限的小数是不可能保证精确的。所以注定了一定存在精度问题，比如我们的1/3。
3. 因为空间有限，所以也就存在`大数危机`，因为64位是有限的，最大值也是确定的`9007199254740991`，那么超了呢，所以危机就一定存在，好在会有个新的内置类型BigInt
4. BigInt的作用就如它表意的名字一样=》为了更大的整数值，当然它还是8个字节

![](https://i.imgur.com/tuALQHR.png)

![](http://static.1991421.cn/2020/2020-05-10-150502.jpeg)

注意：这个问题并不只是在 Javascript 中才会出现，几乎所有的编程语言都采用了 IEEE-745 浮点数表示法，任何使用二进制浮点数的编程语言都会有这个问题。但比如Java因为有BigDecimal这个类直接使用所以问题没那么凸显而已。


![](http://static.1991421.cn/2020/2020-05-10-154451.jpeg)


### 浮点数计算精度问题

使用现成的类库，推荐 big.js&mathjs。原理是将浮点数转化为字符串，模拟实际运算的过程

## 原始类型优于封装对象

- 比如声明字符串，我们可以`new String('hello')`,`String('hello')`,`'hello''`,但是要知道new String实际上是一个String对象，并不是基本数据类型。
- 对于基本类型，一般不要new 对象wrapper来声明。


## 分号插入的局限
如下code,sample1运行OK,sample2不是我们预期的返回结果，why?因为自动分号插入(automatic semicolon insertion, ASI)的存在，它在JS的语法解析阶段起作用

```js
var name = "ESLint"
var website = "eslint.org";

console.log(name);
console.log(website);
```

```
function sayName(){
return
{
    name: "ESLint"
};
}

console.log(sayName()); // undefined
```

### 注意
- ASI 是备胎（第二选择），在遇到行结束符 (Line Terminator) 时，编译器总是先试图将行结束符分隔的符号流当作一条语句来解析（其实有少数几个特例：return、throw、break、continue、yield 、++ 、 --），实在不符合正确语法的情况下，才会退而求其次，启用 ASI 机制，将行结束符分隔的符号流当作两条语句（俗称，插入分号）。
- 上述说的特例是不允许行结束符存在的。如果语句中有行结束符，parser 会优先认为行结束符表示的是语句的结束，这在 ECMAScript 标准中称为限制产生式 (restricted production)。


## 变量作用域


## 高阶函数
高阶函数的特征是将函数作为参数，或者返回结果是函数，所以比如Array.map,sort这些方法，都是接收一个函数。高阶函数是一种方式，抽象代码，提高可复用性。so,可以训练吧。


### 数组和字典

字典与数组相比，数组是有顺序之分的，而字典并没有。forin一个字典数据，顺序可能不是我们想象的那样,如下即是一个例子。因为便遍历时，key都会parseFloat，得到值然后排序。


```js
const userMap = {
  hello: "alan",
  '1': "helen",
};

for (const key in userMap) {
  console.log(key);
}

// 1
// hello
```

### 注意
- 对象key永远是字符串，即使遍历的对象是个数组


## undefined值

像Java,C等语言中表示"空"值，而JavaScript比较特殊，有null与undefined之分。
	
### 相同点

null与undefined相等性测试的结果是true,`console.log(null==undefined); \\ true`，undefined值之派生自null值。

## 并发

- JavaScript为了避免复杂性，而实现单线程执行
- 浏览器是多进程，要不chrome为啥这么占资源呢
- 无论是多线程，多进程，协程，也都是为了进一步更好的利用计算机资源


### 进程
> 进程是应用程序的执行实例，每一个进程都是由私有的虚拟地址空间、代码、数据和其它系统资源所组成；进程在运行过程中能够申请创建和使用系统资源（如独立的内存区域等），这些资源也会随着进程的终止而被销毁。而线程则是进程内的一个独立执行单元，在不同的线程之间是可以共享进程资源的，所以在多线程的情况下，需要特别注意对临界资源的访问控制。

如下，系统进程管理，我们可以看到chrome进程不止一个。

![](http://static.1991421.cn/2020/2020-05-10-224423.jpeg)

### JS的单线程特点与promise.all并行加载不矛盾
- promise是一种模式，一种组织异步代码的方式，它解决了之前的回调地狱，但还是异步。
- promise all是将一堆的异步执行，然后一次性的取出。prmoise all开启的N个异步，彼此是不影响的

## 写在最后

1. 开发者优秀与否的一个标志是优秀的开发总能解释为何这样设计，这样做，而非优秀的往往是说不出所以然的。
2.  这本书读完觉得实际上JS并没有那么难，或者说高级语言都没有那么难，明白其设计目的，设计模式，玩起来应该更为轻松些。


## 引用文章
- [这一次，彻底弄懂 JavaScript 执行机制](https://juejin.im/post/59e85eebf265da430d571f89)
- [浮点数](https://zh.wikipedia.org/wiki/%E6%B5%AE%E7%82%B9%E6%95%B0)
- [JavaScript 浮点数陷阱及解法](https://github.com/camsong/blog/issues/9)
- [JS计算误差小谈](https://juejin.im/post/5c493ebb6fb9a049c0436077)
- [【读书】编写高质量JavaScript代码的68个有效方法](http://pelli.ren/gitbooks/my_js_part/js/effective.javascript.html)
- [What is Typecasting in Java and how does it work?](https://www.edureka.co/blog/type-casting-in-java/)
- [JavaScript 中精度问题以及解决方案](https://www.runoob.com/w3cnote/js-precision-problem-and-solution.html)
- https://www.ctolib.com/docs/sfile/effective-javascript/index.html
