---
title: 废弃的componentWillReceiveProps
tags:
  - React
abbrlink: e5374ca5
date: 2020-06-15 22:45:19
---
> React v16.3+已标注`componentWillReceiveProps`为不提倡，17将予以删除，那么这个周期函数为什么要被废弃呢，弊端在哪里，及新的同需求新写法又是如何呢。这篇文章我来梳理下这个函数


![](https://static.1991421.cn/2020/2020-06-15-231959.jpeg)


## componentWillReceiveProps的触发时间
顾名思义即props发生变化时触发，但是实际上props不变也会触发。当父组件重新渲染，子组件的componentWillReceiveProps即会触发。so, `componentWillReceiveProps不单单只是在props变化才触发。`

## componentWillReceiveProps的使用

1. 有时我们的state是依赖于props，因为我们setState可能是在这个时候执行。但注意setState这个操作是个异步的，而state变化也会触发新的render
2. componentWillReceiveProps中如果执行副作用，存在内存溢出的风险，比如发起异步action，更新redux状态数据，进而引发组件props更新，循环触发componentWillReceiveProps


基于以上的问题，官方废弃该函数，那么如上的需求我们又该如何去做呢。

## 应该如何去做
1. 比如state的更新依赖于props，那么我们可以使用新的静态函数`getDerivedStateFromProps `
2. 如果是副作用，应该在didUpdate,didMount及用户交互操作中去执行


## 项目中规避这种废弃方法的使用
我们可以配置相应的lint规则，确保这类代码不存在，这样也减少了将来框架升级带来的改写成本。

`yarn add eslint-plugin-react -d`

具体介绍，[戳这里](https://github.com/yannickcr/eslint-plugin-react)

## 写在最后
这里聊的是React，对比NG，NG中的父组件渲染更新，子组件的change方法并不是重新trigger，so,框架不同，这些基本的钩子区别还是挺大的。


## 参考文档
- [react-lifecycle-methods-diagram](https://projects.wojtekmaj.pl/react-lifecycle-methods-diagram/)
- [React.Component](https://reactjs.org/docs/react-component.html)
