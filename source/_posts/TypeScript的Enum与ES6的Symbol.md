---
title: TypeScript的Enum与ES6的Symbol
date: 2020-12-02 09:44:38
tags:
- JavaScript
- TypeScript
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

1. TS用于常量集定义
2. 因为TS枚举类