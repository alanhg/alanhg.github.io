---
title: Redux Saga测试库比较
tags:
  - Redux
  - generator
  - JavaScript
abbrlink: a5ff9a78
date: 2019-05-19 22:30:38
---

原文地址:[Evaluating Redux Saga Test Libraries](https://blog.scottlogic.com/2018/01/16/evaluating-redux-saga-test-libraries.html)

> 最近项目中使用Redux-saga来解决复杂的异步操作逻辑。发现redux-saga的官网并不怎么友好，建议还是多看其它资料。偶然看到这篇文章不错，姑且一翻，兴许帮到些朋友。

![](http://static.1991421.cn/2019-05-19-142842.jpg)

> 如果你是Redux Saga粉，你会留意到有许多库可以协助你去测试saga.这篇文章聚焦于测试saga的不同方法，描述了当下流行的5种测试库适合的场景。

- 原生测试（不借助辅助库）
- [redux-saga-tester](https://github.com/wix/redux-saga-tester)
- [redux-saga-test](https://github.com/stoeffel/redux-saga-test)
- [redux-saga-testing](https://github.com/antoinejaussoin/redux-saga-testing/)
- [redux-saga-test-plan](https://github.com/jfairbank/redux-saga-test-plan)
- [redux-saga-test-engine](https://github.com/timbuckley/redux-saga-test-engine)

首先，简单介绍下

##什么是Saga

redux store即不可变的全局应用状态。修改状态数据，只能通过派发一个action,action的处理是通过reducer函数。reducer的作用是接收action,修改状态，返回新的状态。

这种方法使得redux易于测试，但这也就意味着reducer受限于存储的状态。比如，我们如何去请求一个API呢？在函数编程中，由于其不可预测性，对外部影响的依赖性和时间依赖性。这被认为是不纯的side effect 。 side effects在reducer中没有用处。

再看Redux Saga。Saga用派发一个action作为信号，异步处理了副作用，你的Redux应用得到了很好的分离：reducer用来更新state状态，副作用被放在saga中执行。当然，除了saga，我们也可以选择使用redux-thunk,但在过去一段时间，我越来越欣赏saga，我觉得它是更好的选择，更值得使用。

使用redux中间件链将所有东西连通起来。当一个action被发起，Redux通过一些列中间件传递这个aciton,reducer在之后运行。Redux Saga是个中间件,它会生成在reducer更新状态后运行的结果。这看起来很奇怪，但当你考虑到你希望拿到最新值时，你会明白这个道理。

Redux saga的中间件负责启动，暂停和恢复saga，及执行一个saga到另一个saga的effect。

## Effects副作用
下面的saga call一个API，然后派发一个action(成功或失败)

```javascript
import { call, put } from 'redux-saga/effects';

// Action creators
const loadUser = username => ({ type: 'LOAD_USER', payload: username });
const loadUserSuccess = user => ({ type: 'LOAD_USER_SUCCESS', payload: user });
const loadUserFailure = error => ({ type: 'LOAD_USER_FAILURE', payload: error });

// Selectors
const getContext = state => state.context;

// Reducer
const defaultState =({
  loading: false,
  result: null,
  error: null,
  context: 'test_app'
});

function reducer(state = defaultState, action) {
  switch(action.type) {
    case 'LOAD_USER':
      return { ...state, loading: true };
    case 'LOAD_USER_SUCCESS':
      return { ...state, loading: false, result: action.payload };
    case 'LOAD_USER_FAILURE':
     return { ...state, loading: false, error: action.payload };
    default:
      return state;
  }
}

// Saga
function* requestUser(action) {
  try {
    const context = yield select(getContext);
    const user = yield call(getUser, action.payload, context);
    yield put(loadUserSuccess(user));
  } catch (error) {
    yield put(loadUserFailure(error));
  }
}
```
(注意，下面的测试，我都会使用这个reducer和saga做测试)

`function*`表明这个saga是个[generator](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)函数。当一个generator函数yield一个值到call的函数时，generator的执行会被暂停，直到call的函数通过next或者throw向前进行。另外可以传递值回到generator函数，然后generator继续运行，到下一个yield或者return。

在上面的例子里，saga yield了一个JavaScript对象返回，从一个call到select,call,put。这些对象就是effects，他们就是一些异步操作的描述，表现为redux saga的中间件。select表示从state中选择数据，call用来调用一个函数，put来派发一个action。除此以外还有其它一些复杂的操作符，但这3个是最常用的。

## 测试Saga

由于两个原因，effects的描述和执行是分离的，对于测试非常有价值。首先，由于测试不需要直接调用外部函数，因此很容易进行模拟。所需要的只是将模拟的返回值传递回来，所以可以使用断言去判断相等否。另外，这些effects仅仅只是对象，

在我的调研中，我发现有不同风格的Saga测试。

1. 测试顺序正确性
我们可以简单的一步步yield effect，从而测试一个saga。这样，你可以断言去做相等性检查。用.next或者.throw去一步步执行，这样去测试saga是最简单的。

通常，这种办法的测试适合在单元测试级别，因为我们需要隔离每个单独的saga。这种一步步的去测试，聚焦于yield effects的正确顺序。跳过其中的一步是可以的，仅仅需要手动去做下。有时需要深入到准确的顺序才能在测试中捕获。比如，我又一个saga，协调轮询API断点，这就意味着，确保延迟和选择effects在既定的顺序发生，从而确保使用最新的数据。这个测试方法就可以很好的进行测试。然而这样一个saga如果重构了的话，那么相关的测试都会失败。和所有测试一样，有个原则，就是我们可以冒险去测试代码做了什么，而不是代码应该做什么。


2. 记录你在意的的effects
除了断言saga yield effects的顺序之外，有另一个方法提供更大的灵活性。有时不希望断言select在特定的时间点触发，因为我们是不care，我们仅仅需要知道它发生了。

这个风格的测试，需要事先对于select和call的一些mock，这个saga开始运行，结束时，你可以做一些断言。支持这种风格的类库提供了effects的历史，同时也提供了比简单断言发生的事情更多的功能。

这个风格的测试旨在断言在一个特定的effect下的结果，这点是很接近集成测试的，然而还是有很多单元测试的特征。

将其放入不同的桶中是困难的。作为一种方法，它绝对比上面的风格更接近集成测试，但仍然具有单元测试的许多特征。实际上， 运行saga的实体会收集（记录）所有的effects，以便你根据需要进行断言。

这种方法提供了更为稳定的测试，改变时不那么脆弱。通常会看到支持这种测试方式的测试库也可用于覆盖确切排序方式，适用于需要更具说明性的时候。


3. 集成测试
在这个测试粒度的最顶端，有集成测试saga方法。如果是一个单元测试，你的saga会被隔离出来，而集成测试扮演的是一个mock中间件环境。他们提供了saga，reducer tree和初始化state。当saga开始时，一些effects（比如select,call）能够被应用于state,mock值可以被其它effects mock，比如(call)

一般这些测试比单元测试会慢一些，但从根本上说，这只是上述方法的拓展。这种测试比较适合于，需要管理复杂的工作流和需要状态协作的场景。集成测试的断言仍然可能涉及测试准确的顺序，或者执行期间发生的effects,它们还可以在最终状态，甚至执行中的某个时刻对状态进行断言。


## 库对比
每个测试库都以稍显不同的方式实现了上述的风格之一，本文简要介绍下每个库。

### Native Testing

原生测试是在没有任何辅助类库的帮助下，手动触发，一步步的去执行，断言每一个effects。当我们需要测试yield effects的顺序时，非常有用。

当saga有分支逻辑时，Redux Saga提供了`cloneableGenerator`工具函数去消除测试代码中的重复部分。saga generator函数作为参数被包裹起来，返回一个可以正常执行的新generator函数。当一个分支出现时，创建一个clone对象，在这个地方分叉。


一个完整的例子如下:

```javascript
describe('with redux-saga native testing', () => {
  const generator = cloneableGenerator(loadUserSaga)(loadUser('sam'));
  const user = { username: 'sam', isAdmin: true };

  it('gets the execution context', () => {
    const result = generator.next().value;
    expect(result).toEqual(select(getContext));
  });

  it('calls the API', () => {
    const result = generator.next('tests').value;
    expect(result).toEqual(call(getUser, 'sam', 'tests'));
  });

  describe('and the request is successful', () => {
    let clone;

    beforeAll(() => {
      clone = generator.clone();
    });

    it('raises success action', () => {
      const result = clone.next(user).value;
      expect(result).toEqual(put(loadUserSuccess(user)));
    });

    it('performs no further work', () => {
      const result = clone.next().done;
      expect(result).toBe(true);
    });
  });

  describe('and the request fails', () => {
    let clone;

    beforeAll(() => {
      clone = generator.clone();
    });

    it('raises failed action', () => {
      const error = new Error("404 Not Found");
      const result = clone.throw(error).value;
      expect(result).toEqual(put(loadUserFailure(error)));
    });

    it('performs no further work', () => {
      const result = clone.next().done;
      expect(result).toBe(true);
    });
  });
});
```



### redux-saga-test

redux-saga-test提供了一个便携的方法去断言effects。相较于`expect(generator.next().value).toEqual(select(getContext));`,其实你可以这样简写
`expect.next().select(getContext);`

我将这个库称为`对原生测试的质量改进`。测试仍然遵循原生的准确顺序风格，但少了些操作进行断言。但仍然需要手动去推进saga的执行。

如果你使用Jest作为测试框架，并且选择了redux-saga-test去辅助测试。那么你将需要提供一个deepEqual函数来帮助fromGenerator，这个函数相当于jest中的equals。你可以在fromGenerator上提供一个全局包装器，这样你的测试可以导入，减轻了在每个测试文件中重复执行该操作的事。

```
describe('with redux-saga-test', () => {
  const generator = loadUserSaga(loadUser('sam'));
  const expect = fromGenerator(assertions, generator);

  it('gets the execution context', () => {
    expect.next().select(getContext);
  });

  it('gets the user', () => {
    expect.next('test_app').call(getUser, 'sam', 'test_app');
  });

  ...
});
```

### redux-saga-testing
redux-saga-testing的方法是重写了test函数，比如(it)，所以每个测试case可以推进generator执行。然后值会传递到测试函数中。

```javascript
import sagaHelper from 'redux-saga-testing';
import { requestUser } from './saga';

describe('with redux-saga-testing', () => {
  const it = sagaHelper(requestUser, loadUser('sam') });
  const user = { };

  it('gets the username', result => {
    expect(result).toEqual(call(getUsername, 'sam'));
    return user;
  });

  it('raises the success action', result => {
    expect(result).toEqual(put(loadUserSuccess(user)));
  });

  it('performs no further work', result => {
    expect(result).not.toBeDefined();
  });
});
```

通过采用这个库，你可以将测试的执行紧密结合到saga的执行中去。你可以准确的进行测试，如果想跳过某个步骤，使用空测试进行跳过。

```
it('', () => {});
```
但是，这个也会放大准确测试中遇到的问题，因为它缺少对cloneableGenerator的支持。对于saga的小结构更改将导致许多测试用例挂掉，尤其是如果有多个describe来覆盖saga的分支逻辑的话。


### redux-saga-test-plan

redux-saga-test-plan提供testSaga函数来做准确的顺序测试。一个简单测试中，它提供了链式断言。

```javascript
describe('with redux-saga-test plan', () => {
  it('works as a unit test', () => {
    testSaga(loadUserSaga, loadUser('sam'))
      .next()
      .select(getContext)
      .next('tests')
      .call(getUser, 'sam', 'tests')
      .next(user)
      .put(loadUserSuccess(user))
      .next()
      .isDone();
  });
});
```

当使用testSaga函数时，可以避免必须对每个effect都进行断言，尽管你必须call next，你仍然可以将你的测试与effects的测试顺序相结合。

改为使用expectSaga函数，你可以将saga完整运行，而无需手动推进执行。你可以在设置期间为effect提供任何模拟值，expectSaga也支持testSaga中的链式断言。

```javascript
it('works as an integration test', () => {
  return expectSaga(loadUserSaga, loadUser('sam'))
    .provide([
      [select(getContext), 'test_app'],
      [call(getUser, 'sam', 'test_app'), user]
    ])
    .put(loadUserSuccess(user))
    .run();
});


```

expectSaga函数可以被reducer或者一些其它静态状态增强，所以它可以运行在一个集成测试，用这个办法，你可以在saga执行完后，对最终状态进行断言。

```
it('works as an integration test with reducer', () => {
  return expectSaga(loadUserSaga, loadUser('sam'))
    .withReducer(reducer)
    .provide([
      [call(getUser, 'sam', 'test_app'), user]
     ])
    .hasFinalState({
      loading: false,
      result: user,
      error: null,
      context: 'test_app'
    })
    .run();
});
```

### redux-saga-test-engine

redux-saga-test-engine跟redux-saga-test-plan一样，采用了类似的做法。它提供了createSagaTestEngine函数，这个函数接收在运行中产生effetcs的列表。然后启动saga并提供任何模拟返回值，用于选择和调用等效果。

测试函数的结果是你要记录的effects列表。这样可以断言准确的执行顺序，尽管稍微减少了一些。

```javascript
describe('with redux-saga-test-engine', () => {
  const user = { username: 'sam', isAdmin: true };
  const collectEffects = createSagaTestEngine(['PUT', 'CALL']);
  const actualEffects = collectEffects(
    loadUserSaga,
    [
      [select(getContext), 'test_app'],
      [call(getUser, 'sam', 'test_app'), user]
    ],
    loadUser('sam')
  );

  it('gets the user', () => {
    expect(actualEffects[0]).toEqual(call(getUser, 'sam', 'test_app'));
  });

  it('raises the success action', () => {
    expect(actualEffects[1]).toEqual(put(loadUserSuccess(user)));
  });

  it('performs no further work', () => {
    expect(actualEffects.length).toEqual(2);
  });
});



```


###redux-saga-tester

作为一个集成测试框架，redux-saga-teser提供了一个类,可以与reducer,初始状态以及可能的一些中间件一起去执行saga。创建一个SagaTest实例，然后去执行saga.从那里，可以断言最终状态是否是预期值。它还保留了effects的历史，使得可以确定顺序，或者更小的集合。

```javascript
describe('with redux-saga-tester', () => {
  it('works as an integration test with reducer', () => {
    const user = { username: 'sam', isAdmin: true, context: 'test_app' };

    const sagaTester = new SagaTester({
      initialState: defaultState,
      reducers: reducer
    });

    sagaTester.start(loadUserSaga, loadUser('sam'));

    expect(sagaTester.wasCalled(LOAD_USER_SUCCESS)).toEqual(true);
    expect(sagaTester.getState()).toEqual({
      loading: false,
      result: user,
      error: null,
      context: 'test_app'
    });
  });
});



```



## 总结
下面的表格可以一览每个测试库的特点


库 | 准确性 | 可记录 | 集成性 |可克隆的Generator 
---|---|---|---|---
Native testing|Y	|N	|N	|Y
redux-saga-test|Y|N|N|Y
redux-saga-testing|Y|N|N|N
redux-saga-test-plan|Y|Y|Y|N
redux-saga-test-engine|N|Y|N|N
redux-saga-tester|N|N|Y|N

考虑到saga下的测试生态，建议你使用最流行的方法.`redux-saga-test-plan`为所有类型的测试提供了全面的支持，但混合和匹配同样是一个正确的选择。在我看来，更重要的是开发人员要了解他们测试采用的方法的优缺点

完整的解决方案提供，请看这里[Github](https://blog.scottlogic.com/2018/01/16/evaluating-redux-saga-test-libraries.html)

## 查看更多
- https://blog.scottlogic.com/shogarth/
- https://blog.scottlogic.com/category/tech.html


## 写到最后
- 方案很多，但正如作者所推荐的，目前建议使用redux-saga-test-plan,这样降低开发及维护成本。其它的方案，了解下更有益于理解saga.
- saga的官网并不友好，有些问题，没有明确去说明。比如expectSaga需要return,否则测试提示过，但其实是根本没生效。so，多练多看吧，下来，我会再专门写篇文章来说明下saga测试如何去写。
