---
title: React Props的只读性
abbrlink: 26294c0c
date: 2019-12-22 21:20:49
tags:
- React
---

> 在React组件开发时，Props是不可以修改的。但Why?如何尽可能确保在实际开发中被修改呢？继续喵

![](https://static.1991421.cn/2019-12-22-140603.jpg)

## React中关于Props解释

> Whether you declare a component as a function or a class, it must never modify its own props.
> React is pretty flexible but it has a single strict rule:
> All React components must act like pure functions with respect to their props.

### 结论
1. React类库并没有强制约束不可以修改props,但是规则是不可以修改，是的，这是个`Rule`
2. 函数组件或者类组件都不要修改Props,避免产生副作用

### 举个例子

```javascript
// App renders a user.name and a profile
const App = (props) =>
  React.createElement("div", null, [
    props.user.name,
    React.createElement(Profile, props)
  ]);

// Profile changes the user.name and renders it
// Now App has the wrong DOM.
const Profile = ({ user }) => {
  user.name = "Voldemort"; // Uh oh!
  return React.createElement("div", null, user.name);
};

// Render the App and give it props
ReactDOM.render(
  React.createElement(App, { user: { name: "Hermione" } }),
  document.getElementById("app"));

```

![](https://static.1991421.cn/2019-12-22-134200.png)

如上，虽然在子组件中我们将user.name进行了修改，但是父组件打印的仍然是Hermione，原因？因为props是个对象，本身并没有修改，React组件更新时的新旧比较时浅对比。

## React组件TypeScript定义

```typescript
 class Component<P, S> {
        constructor(props: Readonly<P>);
        ...
```
如上可以看出Props是只读参数，这样确保了一定的安全，假如我们直接赋值，会TSC报错

![](https://static.1991421.cn/2019-12-22-134753.png)

这样就没事了？No,假如参数是个对象类型呢？

![](https://static.1991421.cn/2019-12-22-134839.png)

如上，不会报错，但是个BUG。根本问题在于当前的Type定义无法确保属性的嵌套属性是只读的。关于这点，其实社区已经有讨论和解决方案，但是当前还没有将新的定义合并进去。

讨论[戳这里](https://github.com/DefinitelyTyped/DefinitelyTyped/pull/35210)

当前我们如何确保绝对的不可修改呢？可以将新的定义自己手动放入项目中即可。

## Redux Saga中的Select
在组件中，我们使用Redux的值，是以Props形式进行使用，所以仍然应该只读使用。另一种使用场景是在effects中使用`    const state = yield select();`，那么这里的state也应该只读吗？

YES，select实际上就是调用的store.get(key)，某个state。注意实际上是个对象，那么假如我们在effects中修改了这个对象，实际上就是修改了单一状态树。因此`当我们select拿到状态，注意保持只读性`


## Angular，Vue中的Props?
Angular，Vue中对于父组件传递过来的参数，并没有明确说明不可以修改，但注意本身在使用方式上都是组件，所以建议也不要修改。

## 写在最后

理解这些基本的设计规则及理念，有益于使用这些技术，同时对于设计模式也会有帮助。

## 参考资料

- [React Components and Props](https://reactjs.org/docs/components-and-props.html)
- [Why can't I update props in react.js?](https://stackoverflow.com/questions/26089532/why-cant-i-update-props-in-react-js)
- [为什么说React中的props是只读的](https://github.com/haizlin/fe-interview/issues/924)
