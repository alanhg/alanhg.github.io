---
title: TypeScipt中unknown与any区别
abbrlink: 3aca4119
date: 2020-01-12 22:26:48
tags:
- TypeScript
---
> 关于Unknown的详细具体介绍，文末推荐的文章已是最好，这里不再啰嗦。文章只说下两个类型的根本区别。


any是顶级类型，但弊端就是滥用这个类型，实际上就丧失了类型安全，unknown是为了弥补这个问题。

so。`any类型安全为无，而unknown在具体使用时会很严格。`

![](https://i.imgur.com/0JDoPAB.jpg)


![](https://i.imgur.com/4rX44tk.jpg)


- 当我们无法告诉编辑器a一定是number,TSC不会纵容我们肆意使用toString方法的。但any就可以。

- unknown类型的数据在实际进行操作时，必须进行类型检查，自行判断，缩小类型范围才可以操作，而any却不可以。

## 类型判断

![](https://i.imgur.com/Q0UhWo5.jpg)

如上，返回类型实际上我们写的是`value is number`，为何不写boolean? 试试。so,这里这么写，是为了告诉TSC，类型安全了。

![](https://i.imgur.com/LLhSTz3.png)

## 推荐文章

[[译] TypeScript 3.0: unknown 类型](https://juejin.im/post/5d04ac745188250a8b1fd203)
