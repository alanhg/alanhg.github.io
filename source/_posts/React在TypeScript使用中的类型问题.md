---
title: React在TypeScript使用中的类型问题
tags:
  - TypeScript
  - React
abbrlink: 1359566b
date: 2019-10-23 23:18:22
---
> 前端项目在TypeScript加持下可以提升代码健壮性。当然使用中难免还是会遇到很多类型定义上的问题，这里总结一番。

`备注:持续更`

## children在function组件下的使用

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

## Antd Form与react-intl,react-redux结合下的类型

```typescript

export default Form.create()(
  connect(
    mapStateToProps,
    mapDispatchToProps
  )(injectIntl(Main)));


```

## react-redux,react-intl，react-router结合下的类型

>  Argument of type 'ComponentClass<Pick<any, string | number | symbol>, any> & { WrappedComponent: ComponentType<any>; }' is not assignable to parameter of type 'ComponentClass<RouteComponentProps<any, StaticContext, any>, any> | FunctionComponent<RouteComponentProps<any, StaticContext, any>> | (FunctionComponent<RouteComponentProps<any, StaticContext, any>> & ComponentClass<...>) | (ComponentClass<...> & FunctionComponent<...>)'.
  Type 'ComponentClass<Pick<any, string | number | symbol>, any> & { WrappedComponent: ComponentType<any>; }' is not assignable to type 'ComponentClass<RouteComponentProps<any, StaticContext, any>, any>'.
    Type 'Component<Pick<any, string | number | symbol>, any, any>' is not assignable to type 'Component<RouteComponentProps<any, StaticContext, any>, any, any>'.
      Type 'Pick<any, string | number | symbol>' is missing the following properties from type 'RouteComponentProps<any, StaticContext, any>': history, location, match

> 187 )(withRouter(injectIntl(Main)));


### 错误写法

```typescript
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(withRouter(injectIntl(Main)));
```

### 正确写法

```typescript
export default withRouter(injectIntl(
  connect(
    mapStateToProps,
    mapDispatchToProps
  )(Main)
));

```