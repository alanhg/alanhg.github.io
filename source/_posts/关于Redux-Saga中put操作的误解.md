---
title: 关于Redux-Saga中put操作的误解
date: 2019-09-22 21:28:13
tags:
- Redux-Saga
---
> 关于saga中的effects，我们正常使用似乎也没什么问题。但昨天CodeReview中的一个问题-put action是异步的吗？这样一个simple的问题，我没法给出绝对正确的答案，True or False我不确定。so，通过看saga源码，官方文档及DEMO测试，我来给出准确的答案，同时加深对于saga的了解。

![](http://static.1991421.cn/2019-09-22-112434.jpg)

先说结论不一定，如果action没有任何中间件处理或者异步阻塞，那么是同步的，如果有，则是异步的。

WHY？开始啰嗦！

## 什么是effect
> effect即side effect，即副作用。副作用是计算机科学中的一个概念，Saga并非原创
> 
> 副作用是啥？在计算机科学中，函数副作用指当调用函数时，除了返回函数值之外，还对主调用函数产生附加的影响。例如修改全局变量（函数外的变量），修改参数或改变外部存储。

概念摘自维基百科，[戳这里](https://zh.wikipedia.org/wiki/%E5%87%BD%E6%95%B0%E5%89%AF%E4%BD%9C%E7%94%A8)

saga中将effect分了很多类型，类型分类如下

```javascript
export const effectTypes: {
  TAKE: 'TAKE'
  PUT: 'PUT'
  ALL: 'ALL
  RACE: 'RACE'
  CALL: 'CALL'
  CPS: 'CPS'
  FORK: 'FORK'
  JOIN: 'JOIN'
  CANCEL: 'CANCEL'
  SELECT: 'SELECT'
  ACTION_CHANNEL: 'ACTION_CHANNEL'
  CANCELLED: 'CANCELLED'
  FLUSH: 'FLUSH'
  GET_CONTEXT: 'GET_CONTEXT'
  SET_CONTEXT: 'SET_CONTEXT'
}

```
so，我们平时Call或者Put是会发起不同的effect.

## 什么是阻塞及非阻塞
saga中有这样一对概念，什么意思呢？

> A Blocking call means that the Saga yielded an Effect and will wait for the outcome of its execution before resuming to the next instruction inside the yielding Generator.

> A Non-blocking call means that the Saga will resume immediately after yielding the Effect.

意思就是阻塞调用将会等其执行完最终输出，而非阻塞的将会在effect call后恢复继续执行

官方解释，[戳这里](https://redux-saga.js.org/docs/Glossary.html)

### put操作是阻塞还是非阻塞？
在effects中，发起action，是用`put`函数，而put是非阻塞的，非阻塞是用`putResolve`。

### 除了put操作还有什么操作呢
1. 看官网
2. 看源码

这里不啰嗦，

### effect函数哪些阻塞，哪些不阻塞

通过看saga源码，我梳理了下【请叫我雷锋】

function|block|
---|---|
take| Blocking
call| Blocking
all| Blocking
put| Non-Blocking
putResolve| Blocking
fork| Non-blocking
cancel| Non-blocking
join| Blocking
cps| Non-blocking


### 关于非阻塞的误解
看了上面的介绍，`似乎`会有个`成熟的认识`，put一个action是异步的?

#### 举个例子

假定user信息初始化为null

initState
```json
{
    'name': null,
    'age': null
}
```

effects

```javascript
function* fetchUserEffects() {
    const user = (yield call(getUserInfo)).data; // {"name": "alan","age": 29}
    yield put(setUserInfo(user));
    console.log('Class: fetchUserEffects, Function: fetchUserEffects, Line 8 yield select(): ', yield select(state => state.user));
}
```

reducers

```javascript
 case 'USER_FETCH_SUCCEEDED':
      console.log('Class: , Function: user, Line 7 (): ', action.user);
      return {
      ...action.user
      };

```
如上，假如是异步，似乎effects中打印出来的user信息应该是空，然而。。。

![](http://static.1991421.cn/2019-09-22-095336.jpg)

结果是user信息非空，也就是说yield put一个action,reducer执行完毕且更新到store后才继续执行接下来的操作。

`之前异步的理解是错误的`那，`非阻塞`到底指的是什么呢？查了下GitHub，也有人提出了这个[疑问](https://github.com/redux-saga/redux-saga/issues/1921)，读了再读才恍然大悟。

1. 对于上面的例子，put是发起一个action，这个是同步操作。so接下来取的store信息一定会是最新的。
2. 非阻塞意思是假如这个action中有中间件，或一些异步操作造成了store信息更新不及时，那么effects中并不会等着这些操作执行完，即会继续执行接下来的操作。


#### action改造为异步

我们引入thunk，具体如何配置，看官网。

thunks

```javascript
export const fetchUser = (user) => (dispatch) => {
    getAddress()
        .then((res) => {
            dispatch(setUserInfo(user));
        })
        .catch((error) => {
            console.log(error);
        });
};

```

effects

```javascript
function* fetchUserEffects() {
    const user = (yield call(getUserInfo)).data;
    yield put(fetchUser(user)); // 修改点
    console.log('Class: fetchUserEffects, Function: fetchUserEffects, Line 8 yield select(): ', yield select(state => state.user));
}

}

```

如上，执行发现`effects中打印出来的user信息为空`

![](http://static.1991421.cn/2019-09-22-130732.jpg)

#### put换成putResolve
按照官网所讲，putResolve为阻塞的。个人觉得应该打印顺序与上面相反，BUT，修改后，发现打印结果与上述一致！

这点无法理解，so官方询问中，等答案！猜测thunk这种情况还是无法满足阻塞条件？

### 补充点

在搞清楚阻塞非阻塞问题的同时，通过组件render打印和put之后打印发现，put发起一个action，返回状态到effects中是明显慢于组件中监听的。
我觉得这样也理所应当。把redux和effects分开的话，当我们执行完一个action，修改了store状态，redux执行了自己的监听函数,同时通知出去，so才会出现组件中先知道，当然这只是我的推断。

## 写在最后
- 虽然还有盲区，但至少对于saga中put操作有了更多的了解，并不是put操作一定完整执行才执行下一步操作。
- 个人看法，渐渐搞明白技术的各个细节点，才能渐渐用好一个技术。
- 在检索资料的时候，总会发现资料虽多，但千篇一律，尤其中文的，还是多多有自己的沉淀吧，转发或者抄袭对于个人提升丝毫无益。

## 参考文档
- [函数副作用](https://zh.wikipedia.org/wiki/%E5%87%BD%E6%95%B0%E5%89%AF%E4%BD%9C%E7%94%A8)
- [redux-saga](https://github.com/redux-saga/redux-saga)
- [redux-saga official doc](https://redux-saga.js.org/docs/Glossary.html)
- [redux-thunk](https://github.com/reduxjs/redux-thunk)
