---
title: TypeScript下的类型转换
tags:
  - TypeScript
  - JavaScript
abbrlink: 61b15ad0
date: 2019-08-18 16:33:21
---
> 故事的起因是，同事在项目中遇到的一个问题。
> 
> 在做页面表单时声明了一个类型A，A有4个属性，但是表单渲染是5个字段，在获取表单值的时候，做了_类型转换_` as A`，但是打印发现还是5个字段。不是做了转换吗？他问我怎么回事？怎么解决呢？我告诉他可以显式的删除多余的属性。但具体原因，我却有些哑口无言。对此，我告诉同事，我下去再研究下，不盲目告诉他原因。于是便有了这篇文章，也谢谢我的同事，一个疑问暴露了这块的知识空白。

废话不多说，开始了解。

## 来个例子

我做个小的Demo来复现下同事所描述的问题。

![](http://static.1991421.cn/2019-08-18-074625.png)

![](http://static.1991421.cn/2019-08-18-074307.png)

![](http://static.1991421.cn/2019-08-18-074328.png)

看到输出，我们应该明白，as并没有做到类型转换，类型转换中，多余的参数[height]并没有被删除。

我所提供的解决方案是增加delete操作

![](http://static.1991421.cn/2019-08-18-074833.png)

问题可以如此解决，但疑惑仍在，我们需要继续搞明白。

## TypeScript下有类型转换吗
首先的问题，是会不会TS下的类型转换不是这么操作的呢，或者说根本没有类型转换呢。因为我们要知道TS说他是JS的超集，也就是说他依然是JS。

果不其然，沉痛的告诉大家，`TS下是没有类型转换的`。TS下只有类型断言，类型推断。as foo 与 <foo>做的是类型断言而不是类型转换。

### 类型断言
> TypeScript 允许你覆盖它的推断，并且能以你任何你想要的方式分析它，这种机制被称为「类型断言」。TypeScript 类型断言用来告诉编译器你比它更了解这个类型，并且它不应该再发出错误。

如何使用类型断言呢？两种方式

#### <foo> 
```typescript
let foo: any;
let bar = <string>foo; // 现在 bar 的类型是 'string'
```

#### as foo 
```typescript
let foo: any;
let bar = foo as string; // 现在 bar 的类型是 'string'
```

#### 注意
当在 JSX/TSX 中使用 <foo> 的断言语法时，这会与 JSX 的语法存在歧义：

let foo = <string>bar;</string>;
因此，为了一致性，建议使用 as foo 的语法来为类型断言。

### 类型断言与类型转换
> 它之所以不被称为「类型转换」，是因为转换通常意味着某种运行时的支持。但是，类型断言纯粹是一个编译时语法，同时，它也是一种为编译器提供关于如何分析代码的方法。

## 如何做类型转换
TS本身是不支持类型转换的， 但本身这种场景却是存在的。

如果要实现，如何做呢，目前我所想到的办法正如上面的问题一样，需要自行去将属性值赋予新的类型对象上。

## 类型推断
上面也提到了类型推断，这里也提下。

> TypeScript 能根据一些简单的规则推断（检查）变量的类型，你可以通过实践，很快的了解它们。

以下几个场景，都可以进行类型推断
- 定义变量
- 函数返回类型
- 赋值
- 结构化
- 解构

[具体demo戳这里](https://jkchao.github.io/typescript-book-chinese/typings/typeInference.html)

### 个人建议
类型推断一定程度简化了我们的代码量，比如`const a = 1;`,写不写number都是无关紧要的，确实不写会好些，但对于较为复杂的函数之类的，`如果不能一眼看出类型，建议能进行类型声明更好。`

## TypeScript的编译运行原理
搞明白了TS下没有类型转换，那么接下来有必要了解下TS的原理。

![](http://static.1991421.cn/2019-08-18-141566115980_.pic.jpg)

图来自最近看的一本书《Programming TypeScript》

so,我们可以明白TS本身只是多了一个类型系统，通过类型断言，类型推断，能够提前发现一些明显的错误。

## Java下的类型转换
上面我们一直在说TS，这里来看看Java，横向对比有助于我们理解。那Java下的类型转换是什么样。

### 介绍

> There are two casting directions: narrowing (larger to smaller type) and widening (smaller to larger type). Widening can be done automatically (for example, int to double), but narrowing must be done explicitly (like double to int)

### 上例子

![](http://static.1991421.cn/2019-08-18-142340.png)

我们还延续上面的例子，图上，我们将子类对象类型转换为父类对象，打印对象，会发现属性果然没有了height。so，Java下的类型转换，对应的属性会变化。

当然，你会发现，第一句打印也没有height了，为什么，因为我们做转换的时候，是对象引用，我们改变了原对象。

## 写在最后

在逐步学习中会发现，TypeScript与Java等高级语言还是不同的。so,我们需要结合背景，使用场景对其理解和学习。

但同时也有一点需要知道，本身语言也在相互借鉴与发展，说不定以后什么样呢。

共勉。

## 相关文档
- [深入理解 TypeScript](https://jkchao.github.io/typescript-book-chinese)
- [TypeScript](https://www.tslang.cn/docs/handbook/basic-types.html)
- [Tyepscript cast object to parent object](https://stackoverflow.com/questions/41528375/tyepscript-cast-object-to-parent-object)