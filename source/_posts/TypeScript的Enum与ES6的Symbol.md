---
title: TypeScript的Enum与ES6的Symbol
tags:
  - JavaScript
  - TypeScript
abbrlink: 7956c651
date: 2020-12-02 09:44:38
---
> JS的基本数据类型在ES6到来时增加了Symbol基本类型，而ES6即ES2015发布也已经5年半时间。
> 
> 但实际的开发中，我并没有使用过Symbol，因为在TS的语言环境下，我似乎更不考虑用它了，因为TS下有个枚举类型的存在。但认真学习调研后，结论是理解错了。
> 
> 这里就mark下两者的区别，明晰区别，意义，才能更健康合理的使用。


## TypeScript中的Enum

首先TS只是中间语言，开发语言，而TS最终还是要compile为JS，因此这个类型本身也只是一种包装。

比如我们定义这样一个枚举

```typescript
enum Config {
  CSV,
  JSON
}
```

TSC编译后可以看到会是这样

```typescript
var Config;
(function (Config) {
    Config[Config["CSV"] = 0] = "CSV";
    Config[Config["JSON"] = 1] = "JSON";
})(Config || (Config = {}));
```

而再看看TS官方对于Enum的描述

> Enums are one of the few features TypeScript has which is not a type-level extension of JavaScript.

> Enums allow a developer to define a set of named constants. Using enums can make it easier to document intent, or create a set of distinct cases. TypeScript provides both numeric and string-based enums.


因此，可以下结论

1. TS用于常量集合定义
2. 因为TS枚举类只是个工具类型，最终编译完只是个JS对象

## ES6的Symbol
Symbol是ES6新增的数据类型，其目的是用于表示对象属性的唯一标识符，防止对象属性冲突。

贴出MDN上官方描述

> The data type symbol is a primitive data type. The Symbol() function returns a value of type symbol, has static properties that expose several members of built-in objects, has static methods that expose the global symbol registry, and resembles a built-in object class, but is incomplete as a constructor because it does not support the syntax "new Symbol()".  

> Every symbol value returned from Symbol() is unique.  A symbol value may be used as an identifier for object properties; this is the data type's primary purpose, although other use-cases exist, such as enabling opaque data types, or serving as an implementation-supported unique identifier in general.  Some further explanation about purpose and usage can be found in the glossary entry for Symbol.


因此，可以下结论

1. Symbol值唯一，即使`Symbol('hey') === Symbol('hey')`也是false
2. Symbol可以用于表示私有属性，因此比如JSON序列化，Object,keys都是无法获取到属性。


## 写在最后
以上介绍的很关键，但也很粗糙。对于使用来说，还是一句话合适即可。比如对象属性如果仅仅是前台使用，并且只是为了唯一区分，那么Symbol就很合适，如果还需要序列化传输到后台，那么枚举合适。

done!
