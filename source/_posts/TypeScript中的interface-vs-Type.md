---
title: TypeScript中的interface vs Type
tags:
  - TypeScript
  - TSLint
  - Source Code
abbrlink: f43bfd61
date: 2019-10-15 10:05:33
---
> 做TS项目，经常会用到interface，和type。一般类型定义我会使用interface,而简单且是约束值的会使用type，比如`type username='bob'|'kelly' `,另外我会通过tslint配置中的`Use an interface instead of a type literal.`来进行束缚。BUT，准确的差异在哪，到底该怎么用呢，没法闹，这里调查且总结一番。

## 官网怎么说

> As we mentioned, type aliases can act sort of like interfaces; however, there are some subtle differences.
>
> One difference is that interfaces create a new name that is used everywhere. Type aliases don’t create a new name
>
> Because an ideal property of software is being open to extension, you should always use an interface over a type alias if possible.
>
> On the other hand, if you can’t express some shape with an interface and you need to use a union or tuple type, type aliases are usually the way to go.


官网介绍[戳这里](http://www.typescriptlang.org/docs/handbook/advanced-types.html#interfaces-vs-type-aliases)

### 划重点

- Type并不是创建一个新的类型，而interface会
- 尽可能使用interface
- 如果不想用接口暴露很多信息，并且想用`联合类型`或者`数组类型`，通常使用Type

## interface-over-type-literal

文章一开始提到的`lint rule-interface-over-type-literal`，可以做到type和interface声明检测。那么判断依据是什么呢，看下rule源码

```typescript
function walk(ctx: Lint.WalkContext): void {
    return ts.forEachChild(ctx.sourceFile, function cb(node: ts.Node): void {
        if (isTypeAliasDeclaration(node) && isTypeLiteralNode(node.type)) {
            const typeKeyword = getChildOfKind(node, ts.SyntaxKind.TypeKeyword, ctx.sourceFile)!;
            const fix = [
                // "type" -> "interface"
                new Lint.Replacement(typeKeyword.end - 4, 4, "interface"),
                // remove "=" and trivia up to the open curly brace of the type literal
                Lint.Replacement.deleteFromTo(node.type.pos - 1, node.type.members.pos - 1),
            ];
            // remove trailing semicolon if exists
            if (ctx.sourceFile.text[node.end - 1] === ";") {
                fix.push(Lint.Replacement.deleteText(node.end - 1, 1));
            }
            ctx.addFailureAtNode(node.name, Rule.FAILURE_STRING, fix);
        }
        return ts.forEachChild(node, cb);
    });
}

```

- isTypeAliasDeclaration即节点是否使用type进行类型声明
- isTypeLiteralNode即节点是否是个嵌套类型

### 举个例子

针对上面的rule有个UT，正好说明问题。依次说下例子中的几个类型定义跑rule的结果及原因

1. Fail,嵌套类型
2. Ok
3. Fail,嵌套类型
4. Pass,嵌套类型
5. OK,较为特殊，但不属于嵌套类型，不满足`isTypeLiteralNode`

```
type T = { x: number; }
     ~                  [0]

type U = string;
type V = { x: number; } | { y: string; };
export type W<T> = {
            ~ [0]
    x: T,
};
type Record<T, U> = {
 	[K in T]: U; 
}

[0]: Use an interface instead of a type literal.```

## 写在最后

到此为止，应该明白了两者的差异了。so继续享受TS带来的类型安全吧。

## 参考资料

- [Type Aliases](http://www.typescriptlang.org/docs/handbook/advanced-types.html#type-aliases)
- [Typescript 中的 interface 和 type 到底有什么区别](https://juejin.im/post/5c2723635188252d1d34dc7d)