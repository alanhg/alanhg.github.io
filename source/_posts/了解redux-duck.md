---
title: 了解redux-duck
date: 2021-06-20 18:42:41
tags:
- Saga-Duck
- Redux
- Ducks
---

> 最近参与维护一些项目，其中有用到saga-duck，一脸茫然，于是了解了下，有点收获，这里Mark。



![](https://static.1991421.cn/2021/2021-06-20-234753.jpeg)



## 关联技术点

saga-duck的学习，延伸出duck，extensible-duck，redux-saga，这些都有必要提下。

### Duck

`一种模式/观点`，当使用redux时，我们往往将`{actionTypes，actions，reducers}`三种物理分离，实际上很多操作不存在不同业务场景的复用，将其放在一起组织似乎更合理。

这种思想实际上希望将redux这块的代码进行模块化管理，而非生硬的按照功能类别划分。

### extensible-duck

duck模式的一种实现，并且支持redux-saga

### redux-saga

redux-reducer本身只是纯函数，每次操作即一种状态转化为另一种状态，我们固定输入一定即固定了输出，所以reducer都是纯函数。而很多时候会有一些异步操作等，这些操作存在副作用，因此redux-thunk，redux-saga即为了解决这个环节的问题而存在。只是saga更为复杂&强大些。

### saga-duck

saga-duck大部分是借鉴的extensible-duck，官方文档描述是extensible-duck没有考虑支持redux-saga，并且组合使用不太方便，因此才开发了这个工具库。不过extensible-duck已经支持了saga。

因此extensible-duck/saga-duck等选其一即可。

## saga-duck实践

官方demo及我这里的[demo](https://github.com/alanhg/react-demo/blob/d6e17c1cc1eaf421e348b456f6a6f1d9f0ccdd67/src/components/duck-test/test-duck.js#L14-L14)已经可以说明白，这里不再反复说明。

我的理解即

1. 单一业务下的数据流转包含副作用处理都可以在一个duck下进行组织处理
2. 如果有类似的可以做继承/组合进行复用

### 遇到的坑

#### Class constructor Duck cannot be invoked without 'new'

如果打包遇到该错误即编译这块的事。saga-duck包JS为ES6，而如果我们项目本身编译后是ES5，因此运行中不会有new，而对于ES6 class不使用new运算符志直接使用则会报以上错误，解决办法可以将saga-duck包含在babel编译的范围内

```js
{
            test: /\.(js|jsx|mjs)$/,
            include:
              [
                paths.appSrc,
                /\/node_modules\/saga-duck/, // 关键部分
              ],
            loader: require.resolve('babel-loader'),
            options: {
              configFile: './.babelrc.json',
              cacheDirectory: true
            }
          }
```



## saga-duck原理

duck本身只是提供了类的形式进行redux相关代码组织，整个封装即duck，然后当new一个duck时，会创建redux store。

```js
const duckRuntime = new DuckRuntime(new MyDuck());
const ConnectedC = duckRuntime.connectRoot()(DuckTest);

const ConnectedComponent = () =>
  <Provider store={duckRuntime.store}>
    <ConnectedC />
  </Provider>;
```



```js
  constructor(duck: TDuck,  ...middlewares: any[]){
    this.duck = duck;
    let options: DuckRuntimeOptions
    if(middlewares.length === 1 && typeof middlewares[0] === 'object'){
      options = middlewares[0]
    }else{
      options = {
        middlewares
      }
    }
    this.middlewares = options.middlewares || [];
    this.enhancers = options.enhancers || [];

    this._initStore();
  }
```



```js
  /**
     * 创建redux store
     */
  protected _initStore() {
    const duck = this.duck;
    const sagaMiddleware = (this.sagaMiddleware = createSagaMiddleware());
    const enhancer = compose(
      applyMiddleware(sagaMiddleware, ...this.middlewares),
      ...this.enhancers,
    );
    this.store = createReduxStore(<any>duck.reducer, <any>enhancer);
    this.addSaga(duck.sagas);
  }
```



## 写在最后

正如开始所说，duck是一种模式，理解这点就不难使用。



## 相关文档

- https://cyrilluce.gitbook.io/saga-duck/
- https://github.com/erikras/ducks-modular-redux
