---
title: no-nested-ternary
date: 2020-05-23 21:04:11
tags:
- eslint
- JavaScript
- Code Style
---
>  三元表达式在简单的判断取值中使用，还是很简洁的，但是当遇到嵌套逻辑时，可读性就变得很差，实际项目中，我是这么要求团队=》禁用。

```js
var foo = bar ? baz : qux === quxx ? bing : bam;
```

## no-nested-ternary

为了约束这类代码的存在，eslint中会增加`no-nested-ternary`。

规则介绍[戳这里](https://eslint.org/docs/rules/no-nested-ternary)

当然，对于易读性，我们可以加括号来提高易读性，但事实证明并不能解决问题。so，不建议这么做。

那么这类逻辑的等价替换应该如何去写呢。


## 等价替换的方式

1. if else
2. switch
3. 构建对象



上述方式就可以替换我们原本的嵌套三元表达式写法。

