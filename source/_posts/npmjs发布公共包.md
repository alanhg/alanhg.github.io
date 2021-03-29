---
title: npmjs发布公共包
tags:
  - tslint
  - npm
abbrlink: 2d7382fa
date: 2020-01-21 23:34:41
---
>  之前利用公司的nexus发布了一些公司级的UI组件库，最近希望能够将自己在项目中总结的TSRules发布到源上，因为不止希望公司项目能够使用，所以决定进行npmjs托管。
> 这里简单记录下发布过程

## 发布步骤

### npmjs账户注册
简单略过

### GitHub仓库托管
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
npm publish
```
当提交发布成功，即可。通过npmjs网站，我们即可看到[已发布的包](https://www.npmjs.com/package/tslint-recommend-rule)

![](https://i.imgur.com/1ezHDc8.png)



如果遇到报`402 Payment Required`时，增加`--access=public`重新提交即可，因为NPM私有库是付费的。



## 写在最后

之前每次更新了规则，需要手动的修改多个库，做到同步化，纯粹是繁琐的体力劳动。这样一来，只需要更新rule的包版本即可，每个项目下并不需要直接去维护rule规则，同时因为有了版本，也可以保证了差异性的存在。酷！
