---
title: Redux in Action读书记
date: 2019-10-20 22:00:47
tags:
- React
- Redux
- 读书记
---

> 最近花了2天时间阅读了这本技术书[《Redux in Action》](https://item.jd.com/33402169124.html)

![](http://static.1991421.cn/2019-10-20-074400.png)

结合自己一年+的React/Redux使用，有些反思体会，这里总结一番，大都实际使用中该注意的细节点。

## State为只读
在reducer中，我们`不应该`直接对state进行任何的修改,`effects中也一样`，`注意是不应该而不是不能`。假如我们对原来的state进行修改，程序并不会报错，同时React组件也不会触发重新渲染。

如下为一个reducer纯函数

```javascript
case 'UPDATE_USER_AGE':
     state.age += 1;
     return state;
```

当我们触发该action,通过Redux调试插件，观察state，会看到state其实还是加1了，但是对应React组件显示的数据其实并没有改变，即组件并没有reRender。

state变了，但是react组件不知道，谁的锅？connect的。

### connect函数check的是state的引用

```javascript
const mapStateToProps = function (state) {
    return {
        user: state.user
    };
};
```

redux使用的是`shallow equality check`

如上，我们在组件中配置的是连接redux中的user,user对象引用没变，自己跟自己的引用比，所以一直相等。

so，结论是不直接修改state,不然BUG欢迎你！

## 同步与异步

在react-redux,react-thunk,react-saga使用中，或者说是JS使用中，同步异步这件事是绕不开的。那么在redux范畴中，我们要捋一下。

1. view中dispatch一个aciton是同步的，action=>store是也同步的过程,react组件监听store的变化也是同步，但因为监听到变化要正常执行react的生命周期，所以dispatch一个action，紧接着去获取state的值，`不一定`会是最新的。connect中调用的还是setState,要知道setState是异步的
2. redux-saga的effects中，假如先执行一个action,紧接着select获取redux中的state会是最新的。正如如上1所说到，整个过程都是同步的。
3. redux-thunk的引入使得action本身可以返回一个promise函数，so这个时候dispatch一个function,确实异步了。

## Action定义中参数命名实践

如下为一个action的定义

```javascript
export const setBooksInfo = (books) => ({
    type: 'BOOKS_FETCH_SUCCEEDED',
    books
});
```

业界相对较好的实践是将参数统一封装进payload中，这样做有2个好处。

1. 比如一天有个参数按照意义我们想命名为type，但是却不可以了，因为action本身就有一个type了，但是如果一开始就在payload中那就没这个顾虑了

2. 假如我们有有需要拿到action中所有参数，注意肯定不包括type，那么怎么做呢，如果没有payload，直接放在根，那么`...action`注定了会多个type。

so，业界之所以提倡加上payload有原因的。当然部分action不需要额外的参数，so,payload本身是个可选参。ç


```javascript
export const setBooksInfo = (books) => ({
    type: 'BOOKS_FETCH_SUCCEEDED',
    payload: {books}
});


```
The pattern is commonly referred to as Flux Standard Actions (FSA); more details can be found in this GitHub repository at https://github.com/acdlite/flux-standard-actio

## 容器组件与展示型组件划分实践
因为Redux的引入，React对于组件的划分有了一个实践是划分容器组件和展示型组件，进而在项目中可能划分containers与components文件夹。这个设计一定是有优点的，因为从技术角度彻底分开了依赖redux和不依赖redux的组件。

但，个人非常不喜欢这个实践，我倒觉得react说到底是交互类库，所有组件就是服务于渲染页面，组件划分按照业务去拆分和组织，对于抽象的组件，提炼到shared下即可。没有必要因为redux的关系，直接拆成2块，单个组件是需要还是不需要连接redux，在实践经验和codereview中推进即可。

所以我在前端架构时，不这么做`个人主义看法`。

注意:Redux，React都仅仅是个类库，本身并不约束代码的组织形式。我们可以按照业界流行的模式或者自定义一种模式即可。

## Redux中间件的执行流程

action发起 =》【middleware1,middleware2】=>reducer执行，修改store=>组件监听到store变化，执行钩子周期，进而改变视图

![](http://static.1991421.cn/2019-10-20-092518.png)

## Redux-Saga,Redux-Thunk何时使用

- Saga用于处理复杂和长期运行的进程。
- Saga与thunk作为redux中间件`可以并存`,要知道中间件本身就可以是多个的。
- Thunk及Saga都是为了处理副作用，thunk能做到的Saga都能做到。Saga比Thunk更为强大，如果副作用比较简单，比如一个请求之类的，Thunk就能做到，但比如多个请求，Thunk去做就会让代码更为混乱。

## 性能优化

React,Redux都是轻量级的类库，都不大，性能难道是捕风捉影？NO，再好的牌，乱打的结果就是打烂！做的不好就可能会浪费很多性能。so，小心谨慎。针对Redux，React双剑下的项目，几点要注意。

1. 只关联组件用的store状态，以此避免不必要的渲染。Redux设计下state是单一状态树，理论上完全可以直接关联根状态，BUT科学吗？要知道每个reducer都只是修改了部分的状态。如果直接监听根状态的变化，可能一次reRender都不会，也可能造成不必要的N次渲染。因为如上所说，比较的一直是Shallow Equality。

2. 科学使用React.Component与React.PureComponent.

React.Component并没有实现shouldComponentUpdate，默认返回true。而React.PureComponent对prop及state进行了比较`Shallow Equality`，进而返回true or false.

### 如何比较


看下PureComponent的shouldComponentUpdate源码

```javascript
 if (ctor.prototype && ctor.prototype.isPureReactComponent) {
    return (
      !shallowEqual(oldProps, newProps) || !shallowEqual(oldState, newState)
    );
  }

```


```javascript
const hasOwn = Object.prototype.hasOwnProperty

function is(x, y) {
  if (x === y) {
    return x !== 0 || y !== 0 || 1 / x === 1 / y
  } else {
    return x !== x && y !== y
  }
}

export default function shallowEqual(objA, objB) {
  if (is(objA, objB)) return true

  if (typeof objA !== 'object' || objA === null ||
      typeof objB !== 'object' || objB === null) {
    return false
  }

  const keysA = Object.keys(objA)
  const keysB = Object.keys(objB)

  if (keysA.length !== keysB.length) return false

  for (let i = 0; i < keysA.length; i++) {
    if (!hasOwn.call(objB, keysA[i]) ||
        !is(objA[keysA[i]], objB[keysA[i]])) {
      return false
    }
  }

  return true
}
```

```typescript
 /**
         * Called to determine whether the change in props and state should trigger a re-render.
         *
         * `Component` always returns true.
         * `PureComponent` implements a shallow comparison on props and state and returns true if any
         * props or states have changed.
         *
         * If false is returned, `Component#render`, `componentWillUpdate`
         * and `componentDidUpdate` will not be called.
         */
shouldComponentUpdate?(nextProps: Readonly<P>, nextState: Readonly<S>, nextContext: any): boolean;
```

一句话`PureComponent相比于Component，在shouldComponentUpdate阶段多了一层浅比较`

pureComponent与component区别明确了。另外注意，如果继承React.PureComponent，shouldComponentUpdate不应该再重写。

### 举个例子

```javascript
export class NumberList extends React.PureComponent {

    render() {
        console.log('Class: NumberList, Function: render, Line 6 111(): ', 111);
        const listItems = this.props.numbers.map((number) =>
            <li key={number.toString()}>{number}</li>
        );
        return (
            <ul>{listItems}</ul>
        );
    }
}```


```

这里故意让包含NumberList的父组件重新渲染，但是numbers变量我们刻意不让变动，注意到父组件重新渲染的时候，子组件的console句子没有重新执行，也就是子组件是不会重新渲染的，但是假如我们把继承改成了React.Component。每次父组件渲染，子组件render方法都重新执行。

严格来说，重新执行了render，但是react经过diff计算，发现实际上还是与之前的相同，所以最终并没有真正付出开销生成实际DOM。但执行render和diff也是有成本的，so能避免还是避免吧。

### 使用场景

PureComponent用于【props和state是不可突变数据的组件】。除此情况外我们应该使用Component。

如上例子，NumberList的参数是父组件的state，即不可突变数据，所以适合PureComponent。


## 写在最后

聊聊数笔，权当读书小结。

## 参考资料

- [React.PureComponent](https://reactjs.org/docs/react-api.html#reactpurecomponent)
- [Redux-Saga源码](https://github.com/redux-saga/redux-saga)
- [React PureComponent 使用指南](https://wulv.site/2017-05-31/react-purecomponent.html)
- [JavaScript deep object comparison - JSON.stringify vs deepEqual](https://www.mattzeunert.com/2016/01/28/javascript-deep-equal.html)