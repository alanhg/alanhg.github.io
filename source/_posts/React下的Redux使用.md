---
title: React下的Redux使用
tags:
  - React
  - Redux
  - react-redux
  - frontend
abbrlink: f47dd8fc
date: 2018-12-04 23:44:03
---
![](https://static.1991421.cn/2018-12-02-090726.jpg)

> 最近在做一个A项目的开发，前端技术栈是React+Redux。由于之前React方便基础薄弱(接触个一个小Demo)，而redux更是新鲜事物，所以在开发中不免束手束脚，并且遇到了很多的问题。查官网，查资料，再加上实际Dev，多少有了基本的认识，这里记录下。

对于Redux，会的说简单，不会的说难，真难吗?不难，这里瞎谈下。
 
在说React中Redux的使用之前，先聊几个个问题，搞明白这些，对于Redux的使用会大有裨益。

## 单页应用SPA为什么会存在
要知道，Redux其实是为了解决SPA下的状态管理而生，所以我们要去思考下为什么SPA会诞生，要说以前玩JQ，也没发现需要什么Redux啊？要知道我们不能因为别人用Redux，就去用Redux，别人用React，就去用React。如果一开始就是非必要，何必自找麻烦呢？

推荐一文[《现代 js 框架存在的根本原因》](https://medium.com/dailyjs/the-deepest-reason-why-modern-javascript-frameworks-exist-933b86ebc445)，文中给出了观点和总结。

现代前端框架主要解决 UI 与状态同步的问题

> - 现代 js 框架主要在解决 UI 与状态同步的问题。
- 仅使用原生 js 难以写出复杂、高效、又容易维护的 UI 代码。
- Web components 没有解决这个主要问题。
- 虽然使用虚拟 DOM 库很容易造一个解决问题的框架，但不建议你真的这么做！


## Redux能解决SPA什么问题
SPA使得前端开发更为系统，同时也带来了问题就是状态管理。Redux应运而生。
Redux官网对其进行了简介的说明
> As the requirements for JavaScript single-page applications have become increasingly complicated, our code must manage more state than ever before. This state can include server responses and cached data, as well as locally created data that has not yet been persisted to the server. UI state is also increasing in complexity, as we need to manage active routes, selected tabs, spinners, pagination controls, and so on.

> Managing this ever-changing state is hard. If a model can update another model, then a view can update a model, which updates another model, and this, in turn, might cause another view to update. At some point, you no longer understand what happens in your app as you have lost control over the when, why, and how of its state. When a system is opaque and non-deterministic, it's hard to reproduce bugs or add new features.

## React与Redux区别
上概念【摘自官网】
### React
A JavaScript library for building user interfaces
### Redux
Redux is a predictable state container for JavaScript apps

### react-redux
看了以上概念，就知道，两个类库其实没关系，都是分别解决的不同层面问题，我们开发中因为会同时遇到这两个问题，所以也就存在了两者结合使用的场景----React前端项目下需要Redux进行复杂的状态管理。

在React下使用Redux，一般使用这个类库,你可以理解为说做的React版Redux

## React下Redux使用
OK，了解了大的背景及各个技术的定位目标，就可以着手开始学习了。

Redux的基础学习,建议看官网，记得反复咀嚼。

### 引入Redux
```
npm i redux --save-dev
npm i react-redux --save-dev

```

### 创建Action,Reducer,Store

#### Action

![](https://static.1991421.cn/2018-12-04-153755.png)

#### Reducer

![](https://static.1991421.cn/2018-12-04-153837.png)

#### Store
![](https://static.1991421.cn/2018-12-04-153911.png)


#### dispatch

![](https://static.1991421.cn/2018-12-04-154143.png)

具体代码直接看[这里](https://github.com/reduxjs/redux/tree/master/examples/todos)

#### 3者之前的关系

对于Redux三大支柱有不理解的，看下图

![](https://static.1991421.cn/2018-12-02-134719.jpg)


这里解刨下
- 组件中调用Action的执行，即store.dispatch()
- Action发起动作，需要去给出新的reducer，所以要去计算，而计算的过程就是reducer
- store这个概念是谁的？是redux的，React本来没有，在react的世界，一个组件身上无非就是两个东西，state，prop,state是组件当前状态，prop是父组件传递给子组件的参数。Redux的store最终会反映在组件的prop上供调用。connect的作用就是把数组store连接到目标组件上

### 使用辅助函数
除了本身的redux类库外，推荐增加辅助工具库来规范，优化开发体验。

#### redux-actions-helper
我的项目中使用了这个类库，利用辅助函数来对action	这块操作

```typescript
export const initSettingAction = createAction(
  SettingActionTypes.UPDATE_SETTING,
  (inherit: ISetting, base: ISetting) => ({
    inherit,
    base
  })
);

const updateSettingReducer = (state: ISettingState, action: IAction<{ inherit: ISetting; base: ISetting }>) => ({
  ...state,
  ...action.payload
});

```

好处如下

1. 利用函数强制了action中的参数与type不同级，这点也严格遵守了flux一开始制定的标准，所有的参数都在payload节点下，payload与type同级。
2. IAction类型定义，确保了action这块的类型安全

#### Redux Toolkit
官方现在推出了工具包，新项目可以考虑这个。

[戳这里](https://github.com/reduxjs/redux-toolkit)

## 写在最后
到此应该基础了解差不多了，文章深度没有，多是基础，毕竟内功才王道，知其所以然，剩下的只是熟练的事了。

## 参考文档
- [React 实践心得：react-redux 之 connect 方法详解](http://taobaofed.org/blog/2016/08/18/react-redux-connect/)
