---
title: TypeScript装饰器实践
date: 2020-05-16 16:34:30
tags:
- TypeScript
- 装饰器
---
> 当前装饰器还只是[ES提案[Stage 2]](https://github.com/tc39/proposal-decorators)，在过去，还没定下来的东西，我们无话可说。但今天，项目中使用的是TypeScript，Babel，本身存在转译，所以我们往往可以用些超越当前的特性。比如Angular2框架中就有装饰器的大量存在。
> 
> 这块之前我也只是在NG中较多的使用，并不算熟悉，于是冲下电。

![](http://static.1991421.cn/2020/2020-05-16-172733.jpeg)

## 装饰器
> 装饰器模式，顾名思义，就是将某个类重新装扮下，使它在功能上更强
  大，但是作为原来的这个类，使用者不应该感受到装饰前与装饰后有什么
  不同，否则就破坏了原有类的结构，所以装饰器模式要做到对装饰类的使
  用者透明
  
 
### 类别
- 类装饰器
- 方法装饰器
- 访问器装饰器
- 属性装饰器
- 参数装饰器
- 元数据装饰器


### 要知道

1. 装饰器本质是`函数`
2. TS中装饰器的使用`只能围绕着类，类属性方法等使用`，枚举类型，常量，方法不可


### 举例子

#### 属性装饰器
> 修改目标属性值

```typescript
function modifyProp(target: any, propertyKey: string) {
    target[propertyKey] = Math.random().toString();
}
```


#### 类装饰器

> 修改类中所有属性值

```typescript
function modifyProps(prefix: string) {
    return (constructor: any) => {
        Object.keys(constructor).forEach(
            item => constructor[item] = prefix + item)
        return constructor;
    }
}
```

其它类别例子，自行再查。

## 配置

为了使用装饰器，需要配置下构建工具。我的项目中用到了TypeScript及Babel，所以进行如下配置。

### install package

```bash
$ yarn add @babel/plugin-proposal-decorators -d
```


### tsconfig.json

```json
"experimentalDecorators": true,
/* Enables experimental support for ES7 decorators. */

"emitDecoratorMetadata": true,
/* Enables experimental support for emitting type metadata for decorators. */
```

#### 注意
- 装饰器有用到reflect-metadata，再开启emitDecoratorMetadata设定

### babel.config.js

注意顺序，该插件放在第一位。

```js
 plugins: [
      ['@babel/plugin-proposal-decorators', { 'legacy': true }]
    ]
```

### 浏览器兼容性
1. 如上所说，装饰器只是个函数，可以理解为是语法糖，Babel转译还是会将其变成一般的函数，所以并不会因此而带来兼容性上的改变


## 小试牛刀
当前从事的项目中actiontype的定义如下，你会发现变量名称与内容严格的存在重复，so,采用类装饰器来改造下。对比如下

```js
import { createActionPrefix } from 'redux-actions-helper';

const prefixCreator = createActionPrefix('USER');

export default class UserActionTypes {
  static INIT_USER = prefixCreator('INIT_USER');

  static SET_BUSINESS_UNIT = prefixCreator('SET_BUSINESS_UNIT');
}
```

```js
import { createActionPrefix } from 'redux-actions-helper';

@actionTypes('USER')
export default class UserActionTypes {
  static INIT_USER = null;

  static SET_BUSINESS_UNIT = null;
}

export function actionTypes(prefix: string) {
  return (constructor: any) => {
    Object.keys(constructor).forEach(item => (constructor[item] = createActionPrefix(prefix)(item)));
    return constructor;
  };
}

```

## 写在最后
装饰器谈不上多强大，本质是个函数，但换个角度理解它，会体会到是一种设计模式，使用方式，而这种形态是不侵入你本身设计的类，属性的。so，理解这点，才可以更好更合适的使用。


## 参考文档
- [TypeScript Decorators ](https://www.typescriptlang.org/docs/handbook/decorators.html)
- [注解与装饰器的点点滴滴](https://zhuanlan.zhihu.com/p/22277764)
