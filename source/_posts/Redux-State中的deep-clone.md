---
title: Redux State中的deep clone
tags:
  - Redux
  - 前端性能
abbrlink: 30eed327
date: 2020-03-07 00:02:56
---
> 最近前端出现了性能问题，页面操作会越来越卡顿，最终导致内存溢出。元凶肯定就是开发人员-我们自己,而凶器呢-deepclone

![](https://i.imgur.com/Tuu8qLW.jpg)

比如有这样一个reducer

```typescript
const updateDetailReducer = (state: IDetailState, action) => {
  const detail = _.cloneDeep(state);
  return { ... detail, ...action.params };
};
```

这个有问题吗？从结果来说确实没问题，因为它正常更新了状态。

但是却是糟糕的，因为`cloneDeep `。如上我们对detail进行了深拷贝，所以detail这个对象及其所有属性，每个都是全新的。假如connect监听了detail这个状态值及其子状态的组件有几十个，那么这个页面就要崩溃了，或者说操作次数越多，就越卡。要知道组件参数修改，都会引起重新渲染，这里大部分属性我们是不变的，但`因为使用了深拷贝，所以相关联的所有组件都要进行重新渲染。结果就是性能降低及冗余的性能开销。`

## shouldComponentUpdate
上述使用了深拷贝，就会造成了N多个的组件的重新渲染。因为，`react的shouldComponentUpdate钩子是进行的浅对比`【基本类型比较值，对象类型 比较引用地址】

## lodash的cloneDeep
上述用到了lodash的cloneDeep,就顺带理清cloneDeep与clone及JS原生我们会用到的JSON.parse(JSON.stringify())的区别。记得之前在用深拷贝一个对象时，用JSON.parse(JSON.stringify())报错，但是cloneDeep却可以，所以说，这三者确实有着区别的。

### cloneDeep

`迭代进行拷贝`

```javascript
const a ={info:{name:'xxx'}};
const b=_.cloneDeep(a);

console.log(a===b); // false

console.log(a.info===b.info); // true

console.log(a.info.name===b.info.name); // true
```

### clone
`不迭代进行拷贝`

```javascript
const a ={info:{name:'xxx'}};
const b=_.clone(a);

console.log(a===b); // false

console.log(a.info===b.info); // true
```

### JSON.parse(JSON.stringify())

与cloneDeep非常相似，但注意	`only work with Number and String and Object literal without function or Symbol properties.`
 
所以单说进行深拷贝，cloneDeep是更全面安全的。

```javascript
const a ={info:{name:'xxx'},formatter:()=>this.info.name + '@'};
const b=JSON.parse(JSON.stringify(a));

console.log(typeof a.formatter); // function

console.log(typeof b.formatter); // undefined
```

## 写在最后
这个问题的发现到解决实际上很快，但是背后的问题却值得去思考。

1. redux是单一状态树，每个reducer都会去改变状态树的一部分，但注意，并不是需要改变状态树整个本身
2. reducer中并非不可以用深拷贝，但是一般是不需要使用的，同时深拷贝的树越是顶级，影响波及的组件可能就越多，所以要慎之又慎。


## 参考文档

-  [Deep-cloning of Redux state](https://medium.com/@timoshenko.evgeny/deep-cloning-of-redux-state-dc9ac8ff618c) 
-  [3 Ways to Clone Objects in JavaScript](https://www.samanthaming.com/tidbits/70-3-ways-to-clone-objects/) 
-  [Using shouldComponentUpdate()](https://developmentarc.gitbooks.io/react-indepth/content/life_cycle/update/using_should_component_update.html)