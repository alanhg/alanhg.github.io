---
title: Dictionary vs Map vs Object
tags:
  - JavaScript
  - Map
  - Dictionary
abbrlink: e530636d
date: 2019-10-27 15:16:11
---
> 前端项目使用到了lodash，lodash中有个类型是Dictionary，JavaScript内置对象有Map和Object，三者联系区别在哪，且该如何选择？向下看！

![](https://static.1991421.cn/2019-10-27-061335.jpg)

## lodash中的Dictionary

### 上概念
> 字典(Dictionary)是一种以键-值对形式存储数据的数据结构，JS中的Object，Map，Lodash中的Dictionary都是字典类型的实现。

lodash是啥，一个工具函数类库，具体戳[官网](https://lodash.com/)

lodash源码

```typescript
interface Dictionary<T> {
        [index: string]: T;
    }
```

由此可以知晓

1. lodash的Dictionay是个键为string,值为范型的接口类型,这个定义下的属性`值类型一致`。
2. lodash的Dictionary是Object的实例，so Object的方法也具备。
3. 假如项目中没有引入loash, 自己也可以如上实现个简单的字典类型来使用。

## Map

> `ES6即ES2015时引入了Map类型`

看TS定义源码

```typescript
interface Map<K, V> {
    clear(): void;
    delete(key: K): boolean;
    forEach(callbackfn: (value: V, key: K, map: Map<K, V>) => void, thisArg?: any): void;
    get(key: K): V | undefined;
    has(key: K): boolean;
    set(key: K, value: V): this;
    readonly size: number;
}
```

### Map对象的初始化

```typescript
const stuMap = new Map([[1, 'stu1'], [2, 'stu2']])

```
由此我们知道Map除了本身存储了结构化数据外，还提供了很多属性方法


##  Object

Object为JS的基本对象，基本对象是定义和使用其他对象的基础。Map是Object的实例，当然lodash提供的Dictionary也是。

看TS定义源码

```typescript

interface Object {
    /** The initial value of Object.prototype.constructor is the standard built-in Object constructor. */
    constructor: Function;

    /** Returns a string representation of an object. */
    toString(): string;

    /** Returns a date converted to a string using the current locale. */
    toLocaleString(): string;

    /** Returns the primitive value of the specified object. */
    valueOf(): Object;

    /**
      * Determines whether an object has a property with the specified name.
      * @param v A property name.
      */
    hasOwnProperty(v: PropertyKey): boolean;

    /**
      * Determines whether an object exists in another object's prototype chain.
      * @param v Another object whose prototype chain is to be checked.
      */
    isPrototypeOf(v: Object): boolean;

    /**
      * Determines whether a specified property is enumerable.
      * @param v A property name.
      */
    propertyIsEnumerable(v: PropertyKey): boolean;
}

```


注意：TS项目中我们声明对象类型为{},即等价于类型为hashMap

```typescript
const o:{} = {}
// should be equivalent to

const o:{[key:string]:any} = {}

o.x = 5; //fails
o['x'] = 5; //succeeds
```

## 三者联系与区别

![](https://static.1991421.cn/2019-10-27-072248.png)

1. Object与lodash的Dictionary类似，Dictionary只是值类型一致，但Object的值类型可以是任何类型
2. Map是有序的，可迭代，而Object不是
3. Map的key可以是任何类型，而Object的key只可以是number,string,symbol.

## 如何选择

既然了解了区别，说说常用的场景。

1. 前后端请求和返回一般都是`application/json`,假如我们要定义返回值类型，Object和Dictionary为好,`JSON直接支持Object，但Map还没。`假如返回数据一定是{'':''}，那么可以直接定义为`Dictionary<string>`,假如值类型不统一，可以使用Object或者{},当然具体定义了类型更佳。
2. 如果数据需要考虑顺序及迭代，那么使用Map


## JavaScript中的堆栈
上面讲到的类型都归属于Object类型，而对象类型的存储是在堆内存中，栈内存只是存储了地址下标。所以对象值的拷贝修改要注意，了解下这个有利于类型使用中闭坑。

![](https://static.1991421.cn/2019-10-27-070346.jpg)

## 写在最后
搞明白了三者之间的关系，那就合理使用之。highlight一点，面对一个场景，比如简单的数据，Map,Object,Dictionary都可解决，但为了性能，可读性等，仍然要合理选择，避免挖坑。

##  参考文档

- [Map MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map)
- [Map vs Object in JavaScript](https://stackoverflow.com/questions/18541940/map-vs-object-in-javascript)
- [Object与Map的异同及使用场景](https://juejin.im/post/5c7f6251f265da2dce1f68d3#heading-11)
- [JavaScript中的堆栈](https://segmentfault.com/a/1190000009693516)
