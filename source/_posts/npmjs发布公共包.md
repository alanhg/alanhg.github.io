---
title: NPMJS发布公共包
tags:
  - tslint
  - npm
abbrlink: 2d7382fa
date: 2020-01-21 23:34:41
---
>  之前利用公司的nexus发布了一些公司级的UI组件库，最近希望能够将自己在项目中总结的TSRules发布到源上，因为不止希望公司项目能够使用，所以决定进行npmjs托管。
>
>  这里记录下发布过程

## 发布步骤

### npmjs账户注册
简单略过

### GitHub托管
因为需要更新维护，对应做个仓库比较妥当

[戳这里](https://github.com/alanhg/tslint-recommend-rule)

![](https://i.imgur.com/dK7Pk6W.png)

### 文件添加

因为我这个项目只是托管tslint.json，所以整体较简单。

![](https://i.imgur.com/NK8WsWX.png)


### 注意
1. 初始化package.json可以使用`npm init`
2. 包版本管理，建议使用commitizen,standard-version来进行语义化版本控制

### 包发布

```
npm adduser

# 为什么加access参数，向下看
npm publish --access参数，向下看=public
```
执行以上命令即可，当提交发布成功，即可。通过npmjs网站，我们即可看到[已发布的包](https://www.npmjs.com/package/tslint-recommend-rule)

![](https://i.imgur.com/1ezHDc8.png)



## 注意事项

### 402 Payment Required

这里之所以需要增加`--access=public`，因为默认是发布私有包，而NPM私有库是付费的。如果不加该参数，遇到`402 Payment Required`



### 发布文件黑白名单

发布包时，经常有这样需求，只想发布制定文件，比如测试文件/编译源文件等，这时就需要有黑白名单指定

1. Package.json中files字段进行白名单
2. .npmignore进行黑名单
3. .gitignore进行黑名单

#### 注意

- 如果files明确指定，则优先级最高

- 如果files没有指定，而.npmignore存在，则依据它进行文件排除即可

- 如果.npmignore也不存在则依据.gitignore进行排除

- npm默认发布即会排除node_modules，因此不需要手动排除
- 这里之所以提到存在，是因为空文件也视为生效

## 写在最后

之前每次更新了规则，需要手动的修改多个库，做到同步化，纯粹是繁琐的体力劳动。这样一来，只需要更新rule的包版本即可，每个项目下并不需要直接去维护rule规则，同时因为有了版本，也可以保证了差异性的存在。酷！
