---
title: package.json中的sideEffects
date: 2021-07-18 15:50:05
tags:
- Tree Shaking
- 性能优化
- Webpack
- NodeJS
---

> 查看JS项目时，会看到package.json中会有sideEffects配置，这个是什么含义，如何使用呢，这里总结下。



## sideEffects

顾名思义，副作用，如下函数，进行条件过滤，返回全新数组，但是也修改了原数组本身

```javascript
function filterArr(arr) {
  return arr.filter((item, index) => {
    arr[index] = Math.random();
    return item > 3;
  });
}

const arr = [4, 5, 1, 2];
console.log('before:' + arr);
console.log(filterArr(arr));
console.log('after:' + arr);
```

与副作用相反的即纯函数，固定输入即可固定输出。

```javascript
function filterArr(arr) {
  return arr.filter((item) => {
    return item > 3;
  });
}

const arr = [4, 5, 1, 2];
console.log('before:' + arr);
console.log(filterArr(arr));
console.log('after:' + arr);
```



生活中也有副作用一说，比如我们吃药来治病，但是药三分毒，有些药会带来头痛等等。所以可以这么说有副作用的程序函数，即所做的事不那么纯粹。

## sideEffects非NPM官方标准字段

查看[npmjs官方文档](https://docs.npmjs.com/cli/v7/configuring-npm/package-json)，并没有搜到sideEffects这个设置项介绍，因为这并不是官方标准字段。而是webpack为了更好实现tree shaking所提出的配置项(Webpack4+)。

因此webpack中的treeshaking既需要webpack中进行配置，也需要在Package.json中进行配置。

sideEffects 是通知webpack该模块是可以安全的 tree-shaking, 无需关心其副作用。



## Package.json中sideEffects值

sideEffects可以是false表示无副作用，也可以是数组，明确有副作用的文件。

```json
{
  "name": "your-project",
  "sideEffects": ["./src/some-side-effectful-file.js"]
}
```

注意：

1. 支持通配符

2. 默认值为`true`

3. 副作用粒度在文件级别

   

## webpack处理sideEffects逻辑

​	

- 如果sideEffects配置为false，该模块内代码都没有副作用，只要没有被导入使用，均会被删除，webpack也无需分析
- 如果sideEffects明确了某些文件，Webpack打包时，即使这些文件中的有副作用的那部分代码没被使用，也会保留



注意，生产模式会删除无副作用且没有导入的代码，开发模式都会保留，只是会标注



## 相关文档

- [Webpack 中的 sideEffects 到底该怎么用？](https://zhuanlan.zhihu.com/p/40052192)
- https://webpack.js.org/guides/tree-shaking/

