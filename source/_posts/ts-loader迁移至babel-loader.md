---
title: ts-loader迁移至babel-loader
date: 2020-05-02 15:45:42
tags:
- Babel
- TypeScript
---
## 背景
>
关注社区的应该知道`babel 7`支持了TypeScript的转译，也就是说我们并不一定非得用之前的方案ts-loader或awesome-typescript-loader。

> 最近想解决saga报错的易读性，发现官方给出了方案`babel-plugin-redux-saga`，是个babel插件。

> TSlint已经给出了roadmap，2020年只解决修复的MR，以后将只有ESLint, eslint，tslint两个社区的资源正在整合中。TSLoader这块，我理解也类似，Babel丰富的插件机制，加上目前支持了TS的转译，所以大势所趋，合并再花费精力搞这些呢。

基于以上三点考虑，决定做下迁移


![](http://static.1991421.cn/2020/2020-05-02-153934.jpeg)


## 配置

package.json

```json
    "@babel/core": "^7.9.6",
    "@babel/plugin-proposal-class-properties": "^7.8.3",
    "@babel/plugin-proposal-object-rest-spread": "^7.9.6",
    "@babel/plugin-syntax-dynamic-import": "^7.8.3",
    "@babel/plugin-transform-runtime": "^7.9.6",
    "@babel/preset-env": "^7.9.6",
    "@babel/preset-react": "^7.9.4",
    "@babel/preset-typescript": "^7.9.0",
    "@babel/runtime": "^7.9.6",
    "babel-loader": "^8.1.0",

```

babel.config.js

```js
module.exports = function(api) {
  api.cache(true);

  return {
    presets: [['@babel/preset-env', {
      'targets': {
        'chrome': '58',
        'ie': '11'
      }
    }], '@babel/preset-react', '@babel/preset-typescript'],
    plugins: [
      '@babel/plugin-transform-runtime',
      '@babel/plugin-syntax-dynamic-import',
      '@babel/proposal-class-properties',
      '@babel/proposal-object-rest-spread'
    ]
  };
};

```


webpack.common.js

```js
  {
      loader: 'babel-loader'
    }
```

## 效果

经过一番配置后，重新执行启动 or 构建命令，与之前一样正常即可


### 构建速度

关于速度的对比，可以[戳这里](https://www.reddit.com/r/typescript/comments/bmz5m7/webpack_speedtests_with_tsloader_babel_7/)

按照babel官方的介绍[原理描述]，可以确定速度应该有所提升的。

## 疑问

### TSC本身都可以编译，Babel是否多此一举

- TSC作为类型检查，@babel/plugin-transform-typescript是不做类型检查的
- Babel可以根据目标浏览器情况转换部分语法，更为具体丰富



## 参考文档

* [Compiling TypeScript via webpack and babel-loader](https://2ality.com/2019/10/babel-loader-typescript.html)
* [ts-loader](https://github.com/TypeStrong/ts-loader)
* [babel-loader](https://github.com/babel/babel-loader)
* [WebPack speedtests with ts-loader, babel 7, awesome-typescript-loader](https://www.reddit.com/r/typescript/comments/bmz5m7/webpack_speedtests_with_tsloader_babel_7/)
* [TypeScript and Babel 7](https://devblogs.microsoft.com/typescript/typescript-and-babel-7/)
