---
title: 容易出错的export语句
date: 2021-03-17 21:00:17
tags:
- JavaScript
---

> ES6 Module是官方推出的JS模块方案，随着babel，TypeScript，SPA的盛行，这个技术也用的再熟悉不过了，但有时还是会写错。反思错误，觉得是对其认识理解的还不够彻底，这里就Mark下。



![](https://static.1991421.cn/2021/2021-03-17-210232.jpeg)

![](https://static.1991421.cn/2021/2021-03-17-210258.jpeg)



如图即是有时出现的写法错误

- 首先这个错误是TS编译器报的，属于编译报错，与Lint报错不同，lint报错会告诉具体违反的规则，而编译报错会是`ts(code)`，这点需要区分开来

- 错误中`code-1128`与本身我们所编写的程序文件无关，是编译器内部的，翻看TypeScript源码果然找到了相关语句。因此假如遇到TS编译报错看不懂，可以以此Code辅助进行相关问题检索。

  ```typescript
  Declaration_or_statement_expected: diag(1128, ts.DiagnosticCategory.Error, "Declaration_or_statement_expected_1128", "Declaration or statement expected."),
  
  
    function diag(code, category, key, message, reportsUnnecessary, elidedInCompatabilityPyramid, reportsDeprecated) {
          return { code: code, category: category, key: key, message: message, reportsUnnecessary: reportsUnnecessary, elidedInCompatabilityPyramid: elidedInCompatabilityPyramid, reportsDeprecated: reportsDeprecated };
      }
  
  ```

  

回到具体的错误，为什么如上这样写错误，是因为规定即如下，重新翻看MDN。



官方规定导出写法如下

```javascript
// 导出单个特性
export let name1, name2, …, nameN; // also var, const
export let name1 = …, name2 = …, …, nameN; // also var, const
export function FunctionName(){...}
export class ClassName {...}

// 导出列表
export { name1, name2, …, nameN };
                               
// 导出事先定义的特性作为默认值
export { myFunction as default };

// 导出单个特性作为默认值
export default function () { ... }
export default class { .. }
```



注意

- 导出单个对象时需要声明语句，比如let、var、const、function、class等，而导出多个则是用花括号。

- 缺省导出不可以直接export let、var、const声明，如下会报错

  ```typescript
  export default let m= {}
  ```

  

## 写在最后

熟记基本规范，才能高效编程。

