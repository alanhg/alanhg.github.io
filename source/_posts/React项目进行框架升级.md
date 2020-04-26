---
title: React项目进行框架升级
tags:
  - React
abbrlink: 2563b100
date: 2020-03-23 23:23:19
---
> 开源虽免费，版本需谨慎。升级确实存在一定的风险，但如果清晰每次升级的点[fix/feat/breaking change]，这个风险也会随之降低，或者没有。同时长远来看技术始终要与时俱进的，尤其是在做产品迭代。
>
> 目前从事的WEB项目进入了一个新的迭代，于是借着周末的时间，进行下框架升级。


## 动机
升级本身不单单只是改变一些依赖模块的版本号，而是版本号背后的一些改变，功能或者性能，或者设计模式。

这里列举下我相对关注的一些地方

## 关心的几个点

### TypeScript

1. Optional Chaining

比如我们有下面这样的代码

```typescript
user.sayHello&&user.sayHello();

```
因为我们无法确定这个属性是否真的有值，所以这么写，但是现在我们可以改造成以下这样


```typescript
user?.sayHello();

```


2. nullish coalescing

比如我们有下面这样的代码


```typescript

const username=pete.username||alan.username


```

现在可以这么写

```typescript
const username=pete.username??alan.username

```

这不是一样吗？注意，假如是0，那么就有根本性区别了，||会把0当false，而？？严格的只认null和undefined。所以两者还是不同的。


### React

1. Scheduler
2. lazy / Suspense
3. Hooks


### 其它Benefit
1. 因为版本较新，文档，或者本身轮子的BUG都好沟通和追踪
2. 比如依赖的antd组件，因为版本较新，所以一些新的功能点就可以使用了
3. react-redux按照官方的描述，v7会有明显的性能提升


## 升级中遇到的问题
> 升级从来不是简单的更改一些版本号，还是多少会有坑。 这里列举下我遇到的几个问题


### Optional Chaining 写法lint报错
TS的新的写法，在提交lint检测时会报错，所以也需要升级下lint

### prettier的新版配置项缺省值变化
注意 

```
trailingComma: none

```

### react-dom与react版本一致性要求

注意升级这两者要确保一致，否则也会报错

当然还有一些小错，比如Antd升级后部分类型报错，对应修改即可。


## 升级包

罗列下相关升级包

1. TypeScript `~3.3.1 =>  ~3.8.3`
2. react `16.4.2=> 16.8.3`
3. react-dom `16.4.2 => 16.8.3`
5. react-redux `6.0.1 => 7.2.0`
6. antd `3.20.0`=>`3.26.13`
7. prettier `1.14.3`=>`^2.0.5`
8. tslint `5.18.0`=>`^6.1.1`
9. tslint-react `4.0.0`=>`^5.0.0`


## 写在最后

升级后，基本的测试了下，发现并没有任何的问题，完美。

升级从来都是个挖坑，踩坑到填坑的过程。但收益有几点

1. 未来的可能性会更多些，因为技术足够的新
2. 能够平滑的升级，自身对于相关技术的熟悉度一定有了更深的理解和提高。

so，just do it!


## 参考资料
- https://github.com/formatjs/react-intl/blob/master/docs/Upgrade-Guide.md
- https://github.com/formatjs/react-intl/blob/master/docs/Components.md
- https://github.com/facebook/react/blob/master/CHANGELOG.md
- https://www.typescriptlang.org/tsconfig


