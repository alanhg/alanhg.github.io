---
title: React在TypeScript使用中的类型问题
tags:
  - TypeScript
  - React
abbrlink: 1359566b
date: 2019-10-23 23:18:22
---
> 前端项目在TypeScript加持下可以提升代码健壮性，当然使用中难免会遇到很多类型定义上的问题，这里总结一番。

__为了追求快速解决，我们会偷懒使用`// @ts-ignore`,但这个手段的弊端就是放弃了类型安全，so,能不用就不用，一定要根治了问题才好。__


## children在function组件下的使用

> 无状态组件，我们经常会使用函数组件进行声明，同时经常会用到children来做对象透。

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

> 单个组件下可能会出现antd form与redux集成的情况，如下为_正确的使用顺序，注意connect在最外边_。

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

## ref
> ref在做组件通讯时会使用，看网上的文章会发现，有时用ref,有时却用wrappedComponentRef，并且会遇到些坑。

### 几个细节
- ref是react官方给出的属性，wrappedComponentRef是antd的
- redux的connect高阶组件默认并不暴露ref对象，假如需要使用，需要配置`forwardRef`
- 因为我们要配置connect的第四个参，所以第三个必须配置，正如定义是个函数，所以需要如下的写法,否则依然会报类型错误

### 例子
如下有个组件被connect包裹，假如我们需要用该组件的ref
```typescript
export default connect(
  null,
  mapDispatchToProps,
  () => mapDispatchToProps,
  {
    forwardRef: true
  }
)(SList);
```

```
 <SList ref={this.solutionQuoteDiscountRef}
          />
```
以上为正确配置方法，`假如不配置forwardRef，实际上this.solutionQuoteDiscountRef.current拿到的是connect组件`，所以也就谈不上可以直接调用组件的某个方法了。

### 什么时候用wrappedComponentRef？
如上，当然是antd form包裹了组件的时候就可以使用,这也是官方推荐的方式。

## Antd Button等UI组件使用ref访问表单值
有时需要用ref直接获取当前文本框，输入框的值。使用方式如下

```typescript
...
  textAreaRef = React.createRef<TextArea>();

...
        <TextArea rows={5} ref={this.textAreaRef} cols={8} />
...

// 获取值
this.textAreaRef.current.textAreaRef.value

```
如上获取值是可以的，但是TS下会语法错,目前的解决方案是ignore掉，但这个并不优雅。
> Error:(125, 91) TS2341: Property 'textAreaRef' is private and only accessible within class 'TextArea'.


## lodash中debounce使用中报错

 ```typescript
 ...
    this.doSearch = _.debounce(this.doSearch, 700);
...
    this.doSearch.cancel();
 ```
 如上使用，会报以下类型错误
 > Error:(216, 21) TS2339: Property 'cancel' does not exist on type '() => Promise<void>'.

 解决办法

 ```typescript
   debouncedDoSearch: Function & _.Cancelable;
   ...
   this.debouncedDoSearch = _.debounce(this.doSearch, 700);

  this.debouncedDoSearch.cancel();

  this.debouncedDoSearch();
	
 ```

## 写在最后

1. `// @ts-ignore`与`any`都属于开挂，尽可能少用。TypeScript的作用在于Type，在于断言。假如直接开了挂，本身的静态分析就无法发挥作用。那么紧接着就可能是严重的BUG。所以请尊重类型。明确类型的重要性。
2. TS语法分析错误与Tslint报错略有不同，lint报错直接了当的告诉你违反的rule，你只需要对应解决即可。但TS语法报错有时候很长，容易唬住人，但认真读完，断句正确，还是很好解决的，so不要轻易放弃。


