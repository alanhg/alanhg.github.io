---
title: 前端API层治理
date: 2019-10-16 23:03:25
tags:
- React
- Axios
- Frontend
---
> 当前在做的React项目，渐渐显现了API使用乱象，于是开启了治理之路。这里记录下其中的前因后果。

## 治理前

_背景：项目中API请求数达到100+之多。_

举个例子，比如有这样两个API文件，user-api.ts,setting-api.ts

```typescript
...

export const getUserList = (params: IUserQuery) => axios.get('/user/api/v1/users', { params });

...

```

```typescript

...

export const getCountrySetting = (params:ICountrySettingParam) => axios.get('/setting/api/v1/country', { params });

...

```

当前API都是直接导出的具体函数。这样的设计有以下问题。

1. 命名上的限制，因为没有namespace的概念，函数的命名需要准确无误地表达清楚这个请求干嘛的。当然同时也要体现出来这是个API请求，如上，其实在使用的地方，你很难看出其实是个API请求。另外队伍成员水平参差不齐，没有约束，造成API命名混乱。
2. 单个API文件，其实很多请求都是有相同的请求前缀的，现在造成了重复
3. 使用API的地方都是直接导入的具体API文件，假如有任何变动，外围都需要做对应的修改。

## 治理后

为了提升API层的维护性。最终采用了以下的方案。

先show代码

```typescript

export class BaseApi {
  basePath: string;

  constructor(basePath: string) {
    this.basePath = basePath;
  }
}

...

```

```typescript
class UserApi extends BaseApi {
 export const getAll = (params: IUserQuery) => axios.get(`${this.basePath}/v1/users`, { params });

 }

const userApi = new UserApi('/user/api');
export { userApi };

```

```typescript
export * from './user-api';
```

### 改进后的好处
- 采用面向对象的方式，使得每块的API形成了内聚，便于管理，比如API相同的basePath就方便提取。
- 因为有了类对象，即有了namespace,使用的时候比如`userApi. getUserList`,在阅读时就可以看出是个API请求
- index根直接导出各个API类实例，使得使用更为方便，避免多个API文件导入，另外本身内部任何API的移动，其实外围某种程度上是个黑盒。
- 因为是个类，其实理论上我们还可以根据属性值的不同实例化不同的对象，这其实也提高了灵活性。

### API method命名指南
上述只是针对API的管理形成了，为了提高本身单个API的易读性。组织Team经过讨论，形成了一套命名指南

`需要不断完善`。

_Recommend_

- getOne*
- getAll*
- update*
- create*
- delete*
- export*
- download*

*为可选值，取决于是否需要名词来更清楚的体现方法的作用。

## Angular框架下API层设计

因为之前做过1-2年的Angular开发，这里延伸谈下NG下是如何做的。

在Angular下，我们会创建ApiService类，每个请求是一个类函数。在具体的组件使用时，我们拿到这个ApiSerive的实例化对象，进而去操作某个请求。这个方案似乎很熟悉？

是的，上面的治理方案其实与Angular官方方案是基本一致的。所以说，技术背后是原理，是设计。这点是框架无关的。


## 写在最后

经过快速的调整API层，目前整体看着舒服些许了，开心。但治理之路，重构之路从不止步，继续闹。

## 参考文档

- [How to make API calls in a smart way](https://codeburst.io/how-to-call-api-in-a-smart-way-2ca572c6fe86)
- [Axios-Core-Api + Object-Oriented JavaScript = Love](https://medium.com/@brybrophy/axios-core-api-object-oriented-javascript-love-effb37f14cd0)