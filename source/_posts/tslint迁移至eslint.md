---
title: tslint迁移至eslint
date: 2020-05-02 23:31:42
tags:
- tslint
- eslint
---

> tslint已标注deprecated，根据公布的roadmap,2020年将逐步退出历史舞台。为什么要这么折腾，其实核心原因就是整合JS社区资源，tslint没有必要另起炉灶。从个人而言也是好事，至少你不需要记忆两套规则

借着周末时间，我将当前的项目做了下lint迁移。


![](http://static.1991421.cn/2020/2020-05-03-112511.jpeg)



## tslint roadmap

个人看法，如果项目还要继续维护开发，迁移就`必须做`。这里贴下官方roadmap

- August 1st, 2019: Stop accepting new core rules. Still accept bug fixes, minor features, and rule enhancements. Custom rules are always an option and can be maintained outside this repo.
- November 1st, 2019: Stop accepting features or rule enhancements (with the exception of ones that make migrating to typescript-eslint easier). Still accept bug fixes.
- January 1st, 2020: Stop accepting anything except security fixes and fixes for crashes introduced by breaking TypeScript changes.
- December 1st, 2020: Stop accepting any PRs 🎉

详细[戳这里](https://github.com/palantir/tslint/issues/4534)

## 自动方案-tslint-to-eslint-config
迁移搞起来谈不上复杂，但是rule毕竟很多，还是有些麻烦的。

社区为了方便迁移，提供了迁移工具，推荐考虑迁移的朋友优先使用该工具。我在玩的时候1.0还没正式，存在问题。于是我决定从头搞起，权当熟悉rule了。

### 注意
迁移工具的原理就是tslint到eslint的配置映射，规则映射，所以会存在tslint支持的某个rule，eslint不支持，因此，注意看控制台提示

## 手动方案

### 初始化 
package.json

```
{
"@typescript-eslint/eslint-plugin": "^2.30.0",
"@typescript-eslint/eslint-plugin-tslint": "^2.30.0",
"@typescript-eslint/parser": "^2.30.0",
"eslint": "^6.8.0",
"eslint-config-prettier": "^6.11.0",
"eslint-loader": "^4.0.2",
"eslint-plugin-import": "^2.20.2",
"eslint-plugin-jsdoc": "^24.0.0",
"eslint-plugin-prefer-arrow": "^1.2.0"}

{

    "lint": "eslint src/main/webapp/**/*.{ts,tsx}",
}
```

.eslintrc.js


```js
module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: [
    '@typescript-eslint'
  ],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/eslint-recommended',
    'plugin:@typescript-eslint/recommended'
  ],
  rules: {
    
  }
};

```

webpack.js

```
 {
        test: /\.tsx?$/,
        enforce: 'pre',
        loader: 'eslint-loader',
        exclude: [utils.root('node_modules')]
      },
```

### eslint:disable
因为做了迁移，所以以前的一些特定情况的禁用注释也需要相应替换下，或者直接去掉。


### disable的几种方式
    
    
   1. /* eslint-disable no-var */ 单个文件，特定规则禁用
   2. // eslint-disable-next-line complexity 下一行规则禁用
   3. // eslint-disable no-var 当前行规则禁用

## 写在最后
1. rule不求多，但求科学，推荐的配置，或者本身的缺省值则是业界的一些推荐规范`比如圈复杂度`，尽可能的遵从，因为要承认他们比我牛
2. rule的出现，是为了统一多人协作开发的规范风格问题，提升可维护性，同时也可以避免一些低级BUG的发生，所以如果team人员参差不齐，rule一定要有。
3. tslint向eslint的迁移，babel开始支持ts的编译，这些社区动作的背后都可以看到社区资源在整合，同类服务在合作。
