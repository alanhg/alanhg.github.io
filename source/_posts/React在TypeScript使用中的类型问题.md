---
title: React在TypeScript使用中的类型问题
tags:
  - TypeScript
  - React
abbrlink: 1359566b
date: 2019-10-23 23:18:22
---
> 前端项目在TypeScript加持下可以提升代码健壮性，当然使用中难免会遇到很多类型定义上的问题，这里总结一番。

## children在function组件下的使用

> 无状态组件，我们经常会使用函数组件进行声明，同时经常会用到children来做
```typescript
import React from 'react';

interface IProps {
  permission: boolean;
}

const AuthShow = ({ permission, children }: React.PropsWithChildren<IProps>) => {
  return <>{isPermit() ? children : null}</>;
};

export default AuthShow;
```

## redux store配置报错

> Error:(26, 21) TS2741: Property '[Symbol.observable]' is missing in type 'Store<IRootState, AnyAction> & { dispatch: {}; }' but required in type 'Store<any, AnyAction>'.


```jsx

 <Provider store={store}>
            <Component />
          </Provider>
```

解决办法`update redux from 4.0.0 to 4.0.3`

[相关GitHub issue讨论](https://github.com/reduxjs/redux/issues/3466)

## withRouter使用类型报错

> Error:(18, 27) TS2345: Argument of type 'typeof Hello' is not assignable to parameter of type 'ComponentClass<RouteComponentProps<any, StaticContext, any>, any> | FunctionComponent<RouteComponentProps<any, StaticContext, any>> | (FunctionComponent<RouteComponentProps<any, StaticContext, any>> & ComponentClass<...>) | (ComponentClass<...> & FunctionComponent<...>)'.
  Type 'typeof Hello' is not assignable to type 'ComponentClass<RouteComponentProps<any, StaticContext, any>, any>'.
    Types of parameters 'props' and 'props' are incompatible.
      Property 'name' is missing in type 'RouteComponentProps<any, StaticContext, any>' but required in type 'Readonly<IProps>'.

路由接口类型有两个容易混淆`RouteComponentProps`和`RouteProps`,但注意使用.我们使用withRouter高阶组件时，对应组件的props应该继承下`RouteComponentProps`，而不是`RouteProps`！

```typescript
interface IProps extends RouteComponentProps {
  name: string;
}

export default withRouter(component);

```

### RouteProps什么时候用

路由定义,比如

```typescript
const routesConfig: RouteProps[] = [
    {
      path: '/hello',
      component: HelloPage 
    }]
```


## Antd Form与Redux集成

> 单个组件下可能会出现antd form与redux集成的情况，如下为正确的使用顺序，注意connect在最外边。

```typescript

export interface IProps extends DispatchProps, StateProps, FormComponentProps {
  name: string;
}

const component = Form.create<IProps>()(Hello);
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(component);

```

## 写在最后

1. `// @ts-ignore`与`any`都属于开挂，尽可能少用。TypeScript的作用在于Type，在于断言。假如直接开了挂，本身的静态分析就无法发挥作用。那么紧接着就可能是严重的BUG。所以请尊重类型。明确类型的重要性。
2. TS语法分析错误与Tslint报错略有不同，lint报错直接了当的告诉你违反的rule，你只需要对应解决即可。但TS语法报错有时候很长，容易唬住人，但认真读完，断句正确，还是很好解决的，so不要轻易放弃。


