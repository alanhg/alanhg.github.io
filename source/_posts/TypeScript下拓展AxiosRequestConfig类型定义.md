---
title: TypeScript下拓展AxiosRequestConfig类型定义
date: 2021-01-11 18:13:14
tags:
- Axios
- TypeScript	
---



## 需求背景

WEB中有些请求很慢，有些请求因为功能上要求，需要增加遮罩从而避免用户在WEB还是执行请求的同时进行其它操作，因此需要加增加loading动画。为了方便控制，采用的办法是在axios的配置项中拓展一个个性化参数配置，比如叫loading，一旦某个请求配置为`loading:true`，则在请求发起及结束时，开关动画。

功能很好做，但如何保证类型安全呢，而axios的配置项AxiosRequestConfig接口定义并没有给出范型参数口子，从而无法增加自定义参数，那么如何优雅解决这个呢-`声明合并`

## 具体代码

在项目中创建定义文件，添加如下接口声明

```typescript
declare module 'axios' {
  export interface AxiosRequestConfig {
    /**
     * @description 设置为true，则会在请求过程中显示loading动画，直到请求结束才消失
     */
    loading?: boolean;
  }
}
```



如上声明后，当光标移动到配置代码位置时，即可正确的进行类型提示。

![](https://static.1991421.cn/2021/2021-01-11-182343.jpeg)





## 声明合并

声明合并完整介绍，请看[官网](https://www.typescriptlang.org/docs/handbook/declaration-merging.html#merging-namespaces)

这里之所以可以解决主要是用到了接口声明合并，接口属性声明本身会进行merge操作。

### 举个例子

```typescript
interface A {
  name: string;
}
interface A {
  address: string;
}

const user: A = {
  name: 'aaa',
  address: 'bbb'
};

```



## 写在最后

1. 采用声明合并的做法解决该问题，好处是保证了自定义配置的类型安全。如果不考虑这里的类型安全，当然也有别的做法，比如我们使用`as unknown as AxiosRequestConfig `，skip掉类型检测，或者自行二次包装下Axios请求方法，对比而言，声明合并才是最简单正确的做法。
2. TS只是类型加持，对JS功能本身并无effect







