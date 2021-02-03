---
title: JavaScript数组中的undefined项
tags:
  - JavaScript
  - 基础
abbrlink: f9d9a7c6
date: 2021-01-27 15:29:58
---

> 最近在开发中遇到了数组遍历次数不对的问题，原因是未初始化，由此发现数组遍历次数不见的与数组长度一致。这里就总结下这个坑。



## 举个例子

```javascript
 let array = [undefined, , 1, 2, 3];
      console.log(array[0]); // undefined
      console.log(array[1]); // undefined

      array.forEach((item, idx) => {
        console.log(item, idx);
      });
```

输出结果如下

![](https://static.1991421.cn/2021/2021-01-27-153630.jpeg)



## 分析

1. 赋值数组项为undefined或者未初始化，值都会是undefined

2. 遍历时有赋值的都会遍历，但没有赋值则直接跳过

   比如有时需要控制循环固定次数，可能会这么去写，注意这里的fill确保赋值数组项为undefined，假如省略这个，则遍历次数为0

   ```javascript
    new Array(10).fill().forEach((_, idx) => {
           console.log(idx + 1);
    });
   ```

   



##   相关讨论

- [JavaScript 'in' operator for `undefined` elements in Arrays](https://stackoverflow.com/questions/22448330/javascript-in-operator-for-undefined-elements-in-arrays)
- [How does JavaScript's forEach loop decide to skip or iterate through “undefined” and “null” elements in an Array?](https://stackoverflow.com/questions/38658103/how-does-javascripts-foreach-loop-decide-to-skip-or-iterate-through-undefined)
