---
title: 前端React项目结构及一些约定
tags:
  - React
  - Redux
  - 前端
  - 架构
abbrlink: 2472c1c2
date: 2019-07-28 21:05:55
---
> 玩React也一年有余，对React的实践有了些许体会。最近在做新项目的前端架构，反思了下之前项目上的不足和问题，决定在这次的结构上改良和精简。
同时，也谷歌了下成熟的设计及一些开源项目，最终决定采取下面的结构。

欢迎讨论碰撞，共同提高。

![](http://static.1991421.cn/2019-07-28-134612.jpg)

## File Structure

先上结构

```
├── app
│   ├── action-types          
│   ├── actions
│   ├── api
│   ├── app.less
│   ├── app.tsx
│   ├── components
│   ├── config
│   ├── effects
│   ├── index.tsx
│   ├── reducers
│   ├── routes.tsx
│   ├── shared
│   ├── types
│   └── typings.d.ts
├── webpack
├── favicon.ico
├── i18n
├── index.html
├── manifest.webapp
├── mock-data
├── robots.txt
├── test
├── static
│   └── images
├── .editorconfig
├── .huskyrc
├── .prettierrc
├── tsconfig.json                 
├── tsconfig.test.json
├── tslint.json         
├── yarn.lock  

```
## 结构下的思考
上面的结构，可能是空洞无谓和简单的，但其背后是我目前的一些思考。这里highlight下。
1. React是个类库，本身并不是个框架，so，它很灵活。这就是它的魅力所在，因为你怎么玩都行。但项目毕竟不一定是个人项目，我们有时需要去划定框框，这样才能保证项目的组织结构不那么混乱。所以基本的架子即约定确实需要。
2. 因为React本身不是框架，所以官方并不会有什么建议及要求结构之说。我们具体做项目，需要根据采用的技术栈及实际的业务开发场景，来敲定一个合理的架构。
3. 我参与的项目使用到了Redux，众所周知，官方提倡我们拆分组件为Components,Containers，即展示型组件，容器型组件。针对这种理念，我觉得对。但在实际的实践中，我发现其实这种分法，会一定程度导致本来强相关的代码被硬生生的分开。so在这次的架构中，我并不打算将其文件夹拆开，无论如何，他们毕竟还是react组件，so直接都在components文件夹下即可。置于内部去分离是否连Redux，那随意了。
4. editorConfig+tslint+husky对代码的基本风格和质量保驾护航

*备注:*没有最好，只有更好。在接下来的实践中，我也会根据实际情况和发现的问题，对此继续进行改良。欢迎道友提意见

## 一些约定
除了上面的基本结构之外，我对Team定下了以下约定。
- 文件夹小写，中线命名法，比如 user-comment
- 组件文件类名小写中线命名
- 路由级组件命名增加`page`后缀

## 写在最后
18年及以前一直玩的是Angular，最近一年因为项目需要才开始玩React，虽然语法上会有不同，并且一个是类库，一个是框架。好吧，承认，确实有很多的不同，一开始我还会有些不适应。但是当一点点的深入后，其实总会有很多似曾相识的点，比如hook，比如组件通讯、比如路由，等等。直到有一天，恍然大悟，是啊，万法归一。

学技术学的是思想，学的是内容。不要被外表的那些花招所骗。与君共勉。

