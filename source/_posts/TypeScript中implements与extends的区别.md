---
title: TypeScript中implements与extends的区别
tags:
  - TypeScript
  - OOP
abbrlink: 9b18a5df
date: 2020-01-30 20:37:33
---
> 本文聚焦implements与extends的区别，这样有益于高效准确的使用

## implements与extends的定位

### implements

顾名思义，实现，一个新的类，从父类或者接口实现所有的属性和方法，同时可以`重写`属性和方法，包含一些新的功能

### extends
顾名思义，继承，一个新的接口或者类，从父类或者接口继承所有的属性和方法，不可以重写属性，但可以重写方法

## 注意点

1. 接口不能实现接口或者类，所以实现只能用于类身上,即`类可以实现接口或类`
2. `接口可以继承接口或类`
3. 类不可以继承接口，`类只能继承类`
4. 可多继承或者多实现

![](https://i.imgur.com/IkoFHiq.png)

## Java版的implements与extends
Java作为老牌面向对象语言，对比学习下，看下差异点。

1. 同上，接口不能实现接口或者类，类不可以继承接口，`类只能继承类`,可多继承或者多实现
2. 与TS有所区别的是，接口不能继承类，`接口只能继承接口`


![](https://i.imgur.com/ANFdCIZ.png)

## 写在最后
上述也只是抛砖引玉，启发下而已，更多的是要在实际的开发中不断灵活的运用接口和类。


## 参考文档

- [What's the difference between 'extends' and 'implements' in TypeScript](https://stackoverflow.com/questions/38834625/whats-the-difference-between-extends-and-implements-in-typescript)
- [Implements vs extends: When to use? What's the difference?](https://stackoverflow.com/questions/10839131/implements-vs-extends-when-to-use-whats-the-difference/34826272#34826272)
- [面向对象程序设计](https://zh.wikipedia.org/wiki/%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%A8%8B%E5%BA%8F%E8%AE%BE%E8%AE%A1)
- [类与接口](https://ts.xcatliu.com/advanced/class-and-interfaces)
