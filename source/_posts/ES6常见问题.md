---
title: ES6常见问题
tags:
  - javascript
  - es2015
  - es6
abbrlink: 4e0ee738
date: 2017-12-12 19:06:23
---
> ES6（ECMAScript2015）的出现，给前端开发人员带来了新的惊喜，它包含了一些很棒的新特性，可以更加方便的实现很多复杂的操作，提高开发人员的效率。
因为使用node和Angular,所以可以直接使用ES6,在实际使用中遇到了一些问题，这里直接mark写。

## 对象添加动态Key

使用[ Computed Property Names](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#Computed_property_names)
```javascript
var key = 'DYNAMIC_KEY',
    obj = {
        [key]: 'ES6!'
    };

console.log(obj);
// > { 'DYNAMIC_KEY': 'ES6!' }
```