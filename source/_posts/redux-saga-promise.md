---
title: redux-saga-promise
tags:
  - Redux-Saga
  - Promise
abbrlink: 79db3a0
date: 2020-02-02 14:50:54
---
> redux saga使得一个action发起后，我们进行大量的操作[异步，同步]，这些操作依次处理，但本身发起这个action确是个异步。
>
>那么问题来了，存在一个场景，如果我们发起一个action，等待action结束执行某个动作， 这个需求怎么解决呢，目前我们的方案是2个，1. 使用回调，假如需要执行多个动作呢，可能会存在多个回调。并且遇到回调，我们要小心，避免陷入回调地狱。2.effects中，数据最终流转到redux状态树，我们在组件中判断状态的变化情况，来了解是否action执行结束。但思考下，难道saga中effects的执行一定最终是将某些值存入redux状态树吗，假如我们支持返回值，那么就可以打破这个了吧。
> 如上两个方案都可以解决问题，但都有其弊端，因此，问题聚焦，就是action是否可以promise化？

## redux-thunk
提到了action promise化，就先提一下thunk，thunk的本质就是中间件形式，先执行了某个异步方法，再执行真正的个action。但是thunk的缺点是做不了丰富的异步动作编排，所以saga作为竞争对手解决了这个问题。

thunk不是我们当前问题的菜。、

## redux-saga-promise
偶然间看到了这个仓库，大致读了下，发现可以解决当前的需求。

### 使用
因为官方文档及demo已经够清楚了，这里就不再赘述。可以参考我的[提交](https://github.com/alanhg/react-demo/commit/52f7ef7a287a51407d00d89cc04f2cdf09ea8df8)

#### 注意点
1. 这里的监听，不要写actionType，而是直接挂action对象，原因很简单，就是实际上这个异步action的type名字并不是我们定义的type

![](https://i.imgur.com/YDQupne.png)

2. 假如WEB启动报错`regeneratorRuntime is not defined`，是因为WEB没有导入regeneratorRuntime,解决办法，我的博客中检索即可，有专门文章去说这个问题


## 写在最后
 熟悉前端的大神们，可能知道[dva.js](https://github.com/dvajs/dva)，框架本身已经对saga做了封装，使得action promise化，如果嫌上述的问题都太麻烦，可以直接使用该框架。

 但越是高级的技术，越是隐藏了很多细节，假如遇到了问题，很大程度就只能干等，因为依赖也就越重，所以利弊明显。

 个人建议，少用框架，自己去搭建符合自己,Team，技术栈的架子。
