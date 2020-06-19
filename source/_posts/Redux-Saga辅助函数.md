---
title: Redux Saga辅助函数
abbrlink: 1f923ddb
date: 2019-12-28 18:52:33
tags:
- Redux
- Redux-Saga
- Ajax
---
> 项目代码中，大家人云亦云的使用`takeEvery`辅助函数,实际上大错特错，应该按需使用。Saga的官方文档确实写的很差，于是翻源码，做测试，对此理解的透彻了些，这里Mark一番。


![](https://static.1991421.cn/2019-12-28-104500.jpg)


## 辅助函数

###  takeEvery

官方介绍如下

```
 * `takeEvery` allows concurrent actions to be handled. In the example above,
 * when a `USER_REQUESTED` action is dispatched, a new `fetchUser` task is
 * started even if a previous `fetchUser` is still pending (for example, the
 * user clicks on a `Load User` button 2 consecutive times at a rapid rate, the
 * 2nd click will dispatch a `USER_REQUESTED` action while the `fetchUser` fired
 * on the first one hasn't yet terminated)
 *
 * `takeEvery` doesn't handle out of order responses from tasks. There is no
 * guarantee that the tasks will terminate in the same order they were started.
 * To handle out of order responses, you may consider `takeLatest` below.
```

#### 注意

1. takeEvery不可以保证effects结束顺序与发起顺序相同。
2. 每发起一个action，即会执行一个effects

### takeLeading

```
 * Spawns a `saga` on each action dispatched to the Store that matches
 * `pattern`. After spawning a task once, it blocks until spawned saga completes
 * and then starts to listen for a `pattern` again.
 *
 * In short, `takeLeading` is listening for the actions when it doesn't run a
 * saga.
```
#### 注意
1. takeLeading监听的action，只有不阻塞时，才会执行。换句话说，只有当前action没有在执行的saga，发起才work。

### takeLatest

```
 * Spawns a `saga` on each action dispatched to the Store that matches
 * `pattern`. And automatically cancels any previous `saga` task started
 * previously if it's still running.
 *
 * Each time an action is dispatched to the store. And if this action matches
 * `pattern`, `takeLatest` starts a new `saga` task in the background. If a
 * `saga` task was started previously (on the last action dispatched before the
 * actual action), and if this task is still running, the task will be
 * cancelled.
```
#### 注意
1. takeLatest监听的action,如果action被派发，此时有在执行的effects,则会被取消，进而执行新的action。

## 上例子

```javascript
function* fetchUserEffects(action) {
  console.log(`这是第${action.payload.count}次`);
  const userInfo = (yield call(getUserInfo)).data;
  yield put(setUserInfoAsync(userInfo));
  yield delay(1000);

  const userHistory = (yield call(getUserHistory)).data;
  yield put(setUserHistory(userHistory));
}
```
注意到count作为计数器，每点击按钮一次加一，第一次为1。

### takeEvery

`  yield takeEvery('USER_FETCH', fetchUserEffects);`,连续发起4次`USER_FETCH`。

![](https://static.1991421.cn/2019-12-28-101807.png)

![](https://static.1991421.cn/2019-12-28-101304.png)

![](https://static.1991421.cn/2019-12-28-101125.png)

注意，action发起了4次，所以可以说明没发起一次action,对应坚挺的saga就会执行一次。

### takeLeading

当我们设定为takeLeading,连续发起4次`USER_FETCH`，注意到只有第一次的被执行。

![](https://static.1991421.cn/2019-12-28-102605.png)

### takeLatest
当我们设定为takeLatest,连续发起4次`USER_FETCH`，注意到其实saga执行还是4次，但是只有最后一次`完整执行`。

![](https://static.1991421.cn/2019-12-28-102820.png)

![](https://static.1991421.cn/2019-12-28-102834.png)

![](https://static.1991421.cn/2019-12-28-102852.png)

#### WHY ?

正如上面官网介绍，假如之前的saga还在执行，则会取消，执行最新的。而我们新的点击时，老的saga还停留到delay阶段，所以会立即取消，因此才会出现上述4次打印和userInfo，但只有最后一次的userHistory。

#### 关于call api
假如第一次effects执行到一句call api,正在请求中，状态，那么当发起新的`USER_FETCH`，那么这个API请求会取消掉吗？不会！取消的意思是老的generator函数不会继续next,但当前进行的动作还是会执行完。


## 使用建议

- 假如saga是检索，考虑到用户可能更新了检索条件，这时使用takeLatest，毕竟之前在执行检索已经无意义。
- 假如saga执行的是计数器之类的，那么每次都会影响记录的数据，这时使用`takeEvery `
- 假如saga执行的操作，输入和输出都一定是一样的，那么应该使用takeLeading，毕竟再次重复执行，毫无意义并且增加开销。

一句话，还是要根据实际情况使用。


## 参考文档
- https://redux-saga-in-chinese.js.org/docs/basics/UsingSagaHelpers.html
