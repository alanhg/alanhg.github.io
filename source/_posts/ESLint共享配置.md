---
title: ESLint共享配置
date: 2020-06-27 22:05:14
tags:
- ESLint
- NPM
---

> 之前的一段时间，将参与的多个WEB项目已经已经从TSLint迁移到ESLint，紧接着的问题就是共享ESLint配置，方案自然还是`npm包管理`


## 包项目结构

```
├── CHANGELOG.md
├── README.md
├── commitlint.config.js
├── index.js // 规则配置
├── package.json
└── yarn.lock

```

具体内容，[戳这里](https://github.com/alanhg/react-eslint-recommend-rule)

### 注意点
1. 包版本管理仍然使用`standard-version`
2. package.json中`files`字段限制发布文件只有index.js。当然默认即package.json，README.md,CHANGELOG.md，所以这三个可以不写。
3. 共享配置，并不只共享规则Rules，plugins也会，这样实际的Web项目只需要继承该包的插件配置，即可完全获取所有的配置项，这样多个项目本身的ESLint配置几乎没有什么了。
4. 这里，我是将包发布到了NPM公共仓库，因为包名很容易重复，所以我增加了`scope配置`，这里是stacker。


## 发布
 
 
 ```bash
 # 登陆
 $ npm adduser
 
 ## 发布
 $ npm publish --access=public
 
 ```
 
### 注意点
1. publish命令增加access是因为我增加了scope，而这默认是私有包发布，所以需要明确下，否则提示没有权限，当然假如就是需要发布私有包，则不需要。
2. 如果报403错误，一个原因是没有登陆，另一个原因是该scope已经注册，so你是没有权限的。

![](https://static.1991421.cn/2020/2020-06-28-141032.jpeg)

## 写在最后
1. TSLint在今年会是最后一年，它将退出历史舞台，原因可在我的博客中搜索
2. ESLint共享配置的目的即使多个项目的code风格可以一统，如果不实现共享，我们不得不CV的控制各个项目，人肉这么去做经常出现遗漏，久而久之多个WEB出现很多风格分歧点，严重更是有BUG，所以并不是好办法。而如今利用公共包去做，可以快速统一，假如需要自定义Rule，也可在包中实现，各项目只需要升级该包即可快速应用，还是很方便的。





