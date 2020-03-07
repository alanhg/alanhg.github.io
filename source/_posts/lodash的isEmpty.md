---
title: lodash的isEmpty
date: 2020-03-07 22:29:19
tags:
- lodash
---
> 正如之前的文章所说，我很讨厌lodash,因为在明明可以原生高效实现的时候，用lodash表现出来的只是懒惰，不假思索与对JS基本功的不扎实。但是假如足够的清晰时，适当使用并没有问题，因为何必重复造轮子呢。


今天翻了下isEmpty这个函数的源码，因为对这个函数，之前存在一些误解。比如下面这样

```javascript
console.log(_.isEmpty(1)); // true
console.log(_.isEmpty('1')); // false
```

## isEmpty
官方文档这么写道

> Checks if value is an empty object, collection, map, or set.
> 
> Objects are considered empty if they have no own enumerable string keyed properties.
> 
> Array-like values such as arguments objects, arrays, buffers, strings, or jQuery-like collections are considered empty if they have a length of 0. Similarly, maps and sets are considered empty if they have a size of 0.


就是说主要用于空对象，集合，类数组值判断。

## 举例子

```javascript
console.log(_.isEmpty(null)); // true
console.log(_.isEmpty({})); // true
console.log(_.isEmpty('')); // true
console.log(_.isEmpty(undefined)); // true
console.log(_.isEmpty(1)); // true
```
## 源码
通过源码来看下这几种情况都是如何判断的

```javascript
function isEmpty(value) {
  if (value == null) {
    return true  // null，undefined 返回true
  }
  if (isArrayLike(value) &&
      (Array.isArray(value) || typeof value === 'string' || typeof value.splice === 'function' ||
        isBuffer(value) || isTypedArray(value) || isArguments(value))) {
    return !value.length //  '' 返回true
  }
  const tag = getTag(value)
  if (tag == '[object Map]' || tag == '[object Set]') {
    return !value.size 
  }
  if (isPrototype(value)) {
    return !Object.keys(value).length
  }
  for (const key in value) {
    if (hasOwnProperty.call(value, key)) {
      return false
    }
  }
  return true // 数字1, { }  返回true
}
```

## 细节

1. null == undefined

```javascript
console.log(null==undefined); // true
console.log(null===undefined); // false
```
一开始的相等判断而不是严格相等，注意到null,undefined结果是true,其实也好理解，毕竟两者都是空值的意思。

2. Object.prototype.toString()
	
	getTag方法中主要就是Object.prototype.toString(value)。
	
	官方文档描述是 toString() 方法返回一个表示该对象的字符串。
	
	```javascript
	const a={};
	console.log(a.toString());  \\ [object Object]
	```


## 参考文档

- [undefined与null的区别](https://www.ruanyifeng.com/blog/2014/03/undefined-vs-null.html)
