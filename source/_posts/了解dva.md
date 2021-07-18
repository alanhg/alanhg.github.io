---
title: '了解dva'
date: 2021-06-27 16:52:05
tags:
- DvaJS
---

> 公司项目有些用到了`DvaJS[D.va]`，为了更好的使用，这些调研总结下。



## 概述

> React and redux based, lightweight and elm-style framework.
>
> dva 首先是一个基于 redux 和 redux-saga 的数据流方案，然后为了简化开发体验，dva 还额外内置了 react-router 和 fetch，所以也可以理解为一个轻量级的应用框架。
>
> dva做了三件事
>
> - 把 store 及 saga 统一为一个 model 的概念, 写在一个 js 文件里面
> - 增加了一个 Subscriptions, 用于收集其他来源的 action, eg: 键盘操作
> - model写法很简约, 类似于 DSL 或者 RoR, coding 快得飞起✈️



可以看出dva主要解决的也是围绕redux的数据流转，同时补充了react-router，fetch。

![](https://static.1991421.cn/2021/2021-07-18-140937.png)





![](https://static.1991421.cn/2021/2021-07-18-153006.jpeg)

## 使用

### dva.js

```javascript
// products-model.js
export default {
  // 在全局 state 上的 key
  namespace: 'products',
  
  // 初始值，在这里是空数组
  state: [],
  
  // 等同于 redux 里的 reducer，接收 action，同步更新 state
  reducers: {
    'delete'(state, { payload: id }) {
      return state.filter(item => item.id !== id);
    },
  },
  
  subscriptions: {
    
  }
};
```



```javascript
// 创建应用，返回 dva 实例
const app = dva({
  initialState: {
    products: [
       { name: 'dva', id: 1 },
      { name: 'antd', id: 2 },
    ],
   },
 });
// 注册视图
           
app.model(productsModel.default);

app.router(() => <ConnectedApp />);

// 启动应用
app.start('#root');
```

#### model复用

dva-model-extend

> Utility method to extend dva model.

https://github.com/dvajs/dva-model-extend

```javascript
import modelExtend from 'dva-model-extend';

const human = {
  state: {
    stomach: null,
  },
  reducers: {
    eat(state, { payload: food }) {
      return { ...state, stomach: food };
    },
  },
};

const benjy = modelExtend(human, {
  namespace: 'human.benjy',
  state: {
    name: 'Benjy',
  },
});
```



## 源码

> 项目使用[lerna](https://github.com/lerna/lerna)进行多包管理

```
├── dva // Official React bindings for dva, with react-router@4.
├── dva-core // The core lightweight library for dva, based on redux and redux-saga.
├── dva-immer // Create the next immutable state tree by simply modifying the current tree
└── dva-loading // Auto loading data binding plugin for dva. :clap: You don't need to write `showLoading` and `hideLoading` any more.
```



### 代码量

>  /packages中JS源码，统计脚本`cloc . --md --exclude-dir=test --include-ext=js`

| Language   |    files |    blank |  comment |                             code `physical lines` |
| :--------- | -------: | -------: | -------: | ------------------------------------------------: |
| JavaScript |       26 |      128 |      110 | <span style="background-color:yellow;">962</span> |
| --------   | -------- | -------- | -------- |                                          -------- |
| SUM:       |       26 |      128 |      110 |                                               962 |

- [sideEffects : false](https://webpack.js.org/guides/tree-shaking/)
- 采用ES写法，对于第三方工具，CJS导出

从代码量也可以看出dva封装的很轻。

### 函数实现

#### dva()

```javascript
// packages/dva/src/index.js
export default function(opts = {}) {
  const history = opts.history || createHashHistory();
  const createOpts = {
    initialReducer: {
      router: connectRouter(history),
    },
    setupMiddlewares(middlewares) {
      return [routerMiddleware(history), ...middlewares];
    },
    setupApp(app) {
      app._history = patchHistory(history);
    },
  };

  const app = create(opts, createOpts);
  //
  const oldAppStart = app.start;
  app.router = router;
  app.start = start;
  return app;
	...
}

```

#### model()

```javascript
// packages/dva-core/src/index.js 
function injectModel(createReducer, onError, unlisteners, m) {
    m = model(m);

    const store = app._store;
    store.asyncReducers[m.namespace] = getReducer(m.reducers, m.state, plugin._handleActions);
    store.replaceReducer(createReducer());
    if (m.effects) {
      store.runSaga(app._getSaga(m.effects, m, onError, plugin.get('onEffect'), hooksAndOpts));
    }
    if (m.subscriptions) {
      unlisteners[m.namespace] = runSubscription(m.subscriptions, m, app, onError);
    }
  }
```



#### subscriptions

```javascript
// packages/dva-core/src/subscription.js
export function run(subs, model, app, onError) {
  const funcs = [];
  const nonFuncs = [];
  // 循环执行各个订阅函数
  for (const key in subs) {
    if (Object.prototype.hasOwnProperty.call(subs, key)) {
      const sub = subs[key];
      const unlistener = sub(
        {
          dispatch: prefixedDispatch(app._store.dispatch, model),
          history: app._history,
        },
        onError,
      );
      if (isFunction(unlistener)) {
        funcs.push(unlistener);
      } else {
        nonFuncs.push(key);
      }
    }
  }
  return { funcs, nonFuncs };
}

```

#### start()

```javascript
// packages/dva/src/index.js 
function start(container) {
    // 允许 container 是字符串，然后用 querySelector 找元素
    if (isString(container)) {
      container = document.querySelector(container);
      invariant(container, `[app.start] container ${container} not found`);
    }

    // 并且是 HTMLElement
    invariant(
      !container || isHTMLElement(container),
      `[app.start] container should be HTMLElement`,
    );

    // 路由必须提前注册
    invariant(app._router, `[app.start] router must be registered before app.start()`);


    //
    if (!app._store) {
      oldAppStart.call(app);
    }

    const store = app._store;

    // export _getProvider for HMR
    // ref: https://github.com/dvajs/dva/issues/469
    app._getProvider = getProvider.bind(null, store, app);

    // If has container, render; else, return react component
    if (container) {
      render(container, store, app, app._router);
      // 热加载
      app._plugin.apply('onHmr')(render.bind(null, container, store, app));
    } else {
      return getProvider(store, this, this._router);
    }
  }

```



#### plugin/use()

dva中对于类的使用只有两个地方，一个是动态加载组件，一个就是插件定义

```javascript
  use(plugin) {
    invariant(isPlainObject(plugin), 'plugin.use: plugin should be plain object');
    const { hooks } = this;
    for (const key in plugin) {
      if (Object.prototype.hasOwnProperty.call(plugin, key)) {
        invariant(hooks[key], `plugin.use: unknown plugin property: ${key}`);
        if (key === '_handleActions') {
          this._handleActions = plugin[key];
        } else if (key === 'extraEnhancers') {
          hooks[key] = plugin[key];
        } else {
          hooks[key].push(plugin[key]);
        }
      }
    }
  }
```



## 写在最后

通过源码阅读可以看到dva封装比较浅，但解决了围绕redux的逻辑组织问题，同时提供了路由配置/订阅，插件拓展。

## 相关文档

- [dva 介绍](https://github.com/dvajs/dva/issues/1)
- [一文彻底搞懂 DvaJS 原理](https://github.com/venaissance/myBlog/issues/20)
- [React + Redux 最佳实践](https://github.com/sorrycc/blog/issues/1)
