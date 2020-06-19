---
title: JSX.Element vs React.ReactNode
tags:
  - source code
  - React
  - antd
  - TypeScript
abbrlink: e62ac8ea
date: 2019-09-28 12:44:18
---
> 最近看antd源码关于render元素有这样两个类型定义 JSX.Element,React.ReactNode，心生疑惑，两者有何差异呢，这里Mark下。

先说大结论【俗称废话】，两者不一样

## JSX.Element与React.ReactNode等价？

![](https://static.1991421.cn/2019-09-28-040933.jpg)

创建一个Card组件，参数content定义为JSX.Element,如果传参为数组元素，是直接报错的。改为`JSX.Element[]`或者`React.ReactNode`均OK。

![](https://static.1991421.cn/2019-09-28-041055.jpg)

那是不是意味着这样就等价了呢？

## JSX.Element[]与React.ReactNode等价？
No,ReactNode的类型定义如下

```typescript
type ReactNode = ReactChild | ReactFragment | ReactPortal | string | number | boolean | null | undefined;
```
也就说可以接受各种类型，而Element一定要是个React Element[当然可以是原生Element]

```typescript
 interface ReactElement<P> {
        type: string | ComponentClass<P> | SFC<P>;
        props: P;
        key: Key | null;
    }
```
比如上面例子，如果类型定义为JSX.Element，content要是个数字就会报类型错误。

## 技术性解释
摘自大神的回答
> Quote @ferdaber: A more technical explanation is that a valid React node is not the same thing as what is returned by React.createElement. Regardless of what a component ends up rendering, React.createElement always returns an object, which is the JSX.Element interface, but React.ReactNode is the set of all possible return values of a component.


- JSX.Element -> Return value of React.createElement
- React.ReactNode -> Return value of a component

## antd里的类型定义
明白了差异，再重新看antd里关于这个类型的使用，似乎也就更理解了。
比如对于常用的Table组件，render方法与renderColumnTitle采用了不同的类型定义。why？因为两者确实情况不同

![](https://static.1991421.cn/2019-09-28-043512.jpg)

### render 使用JSX.Element

![](https://static.1991421.cn/2019-09-28-044507.jpg)

因为table组件最终一定返回一个组件元素，不可能是个数字，字符串等

### renderColumnTitle使用React.ReactNode

![](https://static.1991421.cn/2019-09-28-044027.jpg)

如上renderColumnTitle返回的可能只是个数字，字符串等，并不是个元素对象


## 写在最后
正确合理使用类型定义，可以避免一些BUG，同时也提升代码可读性。TS的大量使用使我觉得类型这块着实充当了一部分文档的作用。


## 参考文档
- [react-typescript-cheatsheet](https://github.com/typescript-cheatsheets/react-typescript-cheatsheet)
- [ant-design source code](https://github.com/ant-design/ant-design)
