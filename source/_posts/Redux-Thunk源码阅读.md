---
title: Redux-Thunk源码阅读
tags:
  - source
  - Redux
  - Redux Thunk
abbrlink: e91dd993
date: 2019-10-05 16:52:42
---

> redux-thunk是redux解决异步的中间件。
> 
> 举个例子，我们需要fetchUser拿到用户信息，然后存到redux中。如果没有thunk，我们需要在组件中fetchUser.then，然后dispatch一个action存到redux中，假如这个操作有多处需要，那么fetchUser.then这个就需要重复，存在一定的代码重复。thunk加入的话，我们可以把fetchUser.then(dispatch action)整体作为一个action进行复用。因为thunk改写了dispatchAPI，我们还是dispatch去用而已，但是已经不是个pure action了。

 ![](http://static.1991421.cn/2019-10-05-025840.jpg)
 
 
## thunk引入

先看下项目中如何配置thunk。

```javascript

const middleWares = [sagaMiddleware, thunk, routerMiddleware(history)];
const store = createStore(rootReducer(history), compose(applyMiddleware(...middleWares), reduxDevtools));
```


## 项目结构

知道了thunk的作用及使用方法，可以开始看thunk源码了。

仓库地址:[戳这里](https://github.com/reduxjs/redux-thunk)

可以看出，thunk项目非常小，主程序文件只有一个`src/index.js`


```json
├── .babelrc 		   
├── .editorconfig  
├── .eslintrc 
├── .gitignore
├── .travis.yml 	
├── CONTRIBUTING.md
├── LICENSE.md
├── README.md
├── package-lock.json
├── package.json
├── src
│   ├── index.d.ts	
│   └── index.js  
├── test
│   ├── .eslintrc
│   ├── index.js
│   ├── tsconfig.json
│   └── typescript.ts
└── webpack.config.babel.js 

```

通过目录树，可以Get到以下信息

1. babel作为项目编译器
2. editorConfig控制编辑器风格
3. eslint控制代码风格
4. git作为版本管理
5. travis作为CI构建工具
6. 使用npm，而非yarn作为包管理器
7. 源码仍然使用JS来写，增加了TS定义文件，来确保TS项目下的类型安全
8. thunk打包支持commonJS,ES,UMD
9. thunk虽然代码不多，但也有UT，使用的chai

上述基础信息若有不足，实属吃惊，自行谷歌。

thunk是补充和拓展了redux的一些功能。要理解thunk的源码，需要看下redux的部分源码，这样可以理解两者是如何衔接的。

## Redux源码

> redux源码已采用TS进行编写

这里贴出部分相关Code

```typescript
export default function applyMiddleware(
  ...middlewares: Middleware[]
): StoreEnhancer<any> {
  return (createStore: StoreCreator) => <S, A extends AnyAction>(
    reducer: Reducer<S, A>,
    ...args: any[]
  ) => {
    const store = createStore(reducer, ...args)
    let dispatch: Dispatch = () => {
      throw new Error(
        'Dispatching while constructing your middleware is not allowed. ' +
          'Other middleware would not be applied to this dispatch.'
      )
    }

    const middlewareAPI: MiddlewareAPI = {
      getState: store.getState,
      dispatch: (action, ...args) => dispatch(action, ...args)
    }
    const chain = middlewares.map(middleware => middleware(middlewareAPI))
    dispatch = compose<typeof dispatch>(...chain)(store.dispatch)

    return {
      ...store,
      dispatch
    }
  }
}

```

compose操作是什么？看下对应的实现，注意注释，这是一个组合函数，从右向左依次执行。

compose属于JS函数式编程范畴，有疑问，可以[戳这里](https://llh911001.gitbooks.io/mostly-adequate-guide-chinese/content/ch5.html)


```typescript
/**
 * Composes single-argument functions from right to left. The rightmost
 * function can take multiple arguments as it provides the signature for the
 * resulting composite function.
 *
 * @param funcs The functions to compose.
 * @returns A function obtained by composing the argument functions from right
 *   to left. For example, `compose(f, g, h)` is identical to doing
 *   `(...args) => f(g(h(...args)))`.
 */
export default function compose(...funcs: Function[]) {
  if (funcs.length === 0) {
    // infer the argument type so it is usable in inference down the line
    return <T>(arg: T) => arg
  }

  if (funcs.length === 1) {
    return funcs[0]
  }

  return funcs.reduce((a, b) => (...args: any) => a(b(...args)))
}

```

注意到上面的middlewares=>chain=> dispatch=>return，thunk作为中间件最终返回作为enhancer,传入createStore函数


```typescript
export default function createStore<
  S,
  A extends Action,
  Ext = {},
  StateExt = never
>(
  reducer: Reducer<S, A>,
  preloadedState?: PreloadedState<S> | StoreEnhancer<Ext, StateExt>,
  enhancer?: StoreEnhancer<Ext, StateExt>
): Store<ExtendState<S, StateExt>, A, StateExt, Ext> & Ext {

...
  if (typeof enhancer !== 'undefined') {
    if (typeof enhancer !== 'function') {
      throw new Error('Expected the enhancer to be a function.')
    }

    return enhancer(createStore)(reducer, preloadedState as PreloadedState<
      S
    >) as Store<ExtendState<S, StateExt>, A, StateExt, Ext> & Ext
  }

...
}
```

enhancer会执行，接下来执行返回的函数。当配置了thunk作为中间件时，thunk就是这里面的chain。接下来看下thunk

## thunk源码

只有短短12行

> redux-thunk


```javascript
function createThunkMiddleware(extraArgument) {
  return ({ dispatch, getState }) => (next) => (action) => {
    if (typeof action === 'function') {
      return action(dispatch, getState, extraArgument);
    }

    return next(action);
  };
}

const thunk = createThunkMiddleware();
thunk.withExtraArgument = createThunkMiddleware;

export default thunk;
```

返回的是个柯里化函数，可以看出，如果传入的参数是函数，就执行函数，否则就跟以前一样dispatch(plainObject)

## redux-saga与redux-thunk的不同
这里聊到了redux-thunk,就也提一下另一个中间件方案 redux-saga.

redux-saga也是redux中间件，一开始举例子fetchUser然后存储到redux，如果用saga也可以实现。so对于单个项目，这两者是可以彼此替代的。但两者还是有不同。

thunk是将action改造成了函数，我们还是正常的dispatch来触发整个操作，而saga并不改变action,而是监听action,发起指定的action,就按顺序执行一系列操作。所以两者还是有根本性不同。 

> 目前我参与的项目，已经弃用了thunk，而使用redux-saga

## 写在最后

1. 单站在使用角度，saga更为灵活，开发及测试的维护性都会更高些。但并不是说thunk就不好。假如项目足够的简单，数据流转逻辑简单清晰，thunk足够。但假如，存储到redux的数据依赖多个请求，并且逻辑复杂，如果使用thunk，不免会陷入回调地狱，这时saga就可以让代码变得清晰可维护。
2. thunk源码足够简单轻巧，一句话来说就是改写redux的dispatch API，使得可以变成函数，从而我们可以dispatch一个异步方法。
3. 看看源码，确实有助于提升自己的基础，另外也知道了与这些作者的差距，so,继续加油。

## 参考文档

- [redux-thunk 源码全方位剖析](https://sosout.github.io/2018/09/09/redux-thunk-source-analysis.html)
- [柯里化](https://zh.wikipedia.org/wiki/%E6%9F%AF%E9%87%8C%E5%8C%96)
- [大佬，JavaScript 柯里化，了解一下？](https://juejin.im/post/5af13664f265da0ba266efcf)