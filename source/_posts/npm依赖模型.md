---
title: npm依赖模型
tags:
  - npm
  - node
abbrlink: 75e93cb6
date: 2020-02-16 01:28:18
---
> 一直以来对于依赖停留在简单的使用中，对于依赖模型却不了解，于是决定将这个盲点消除

以下Scenario来了解。


![](https://i.imgur.com/M7HuNia.jpg)

## 直接依赖与间接依赖同一个包

_注意：版本有所不同_


```
foo
├── hello 0.1.2
└── bar 
	     ├── hello 0.2.8
	     └── goodbye 3.4.0
```

### 物理磁盘

```
node_modules/
├── hello 0.1.2
└── bar
    └── node_modules/
        ├── hello  0.2.8
        └── goodbye 3.4.0
```

这种情况下，物理磁盘上，两个版本会并存。

##  间接依赖同一个包

_注意：版本有所不同_

```
foo
├── hello 0.1.2
└── world 1.0.7

bar
├── hello 0.2.8
└── goodbye 3.4.0
```
这种情况下，物理磁盘上，两个版本会并存。

### 物理磁盘

```
node_modules/
├── foo/
│   └── node_modules/
│       ├── hello/  0.1.2
│       └── world/ 1.0.7
└── bar/
    └── node_modules/
        ├── hello/  0.2.8
        └── goodbye/ 3.4.0
```

## install阶段的依赖模型

install 阶段,npm安装包时根据的是Semver,即包名+版本号。只要不一致，两个版本都会安装。

## build阶段

如上，node_modules中存在多版本的包，那问题来了打包后，vendor文件中的会是哪个版本呢？`两者都有`,因为两个实例毕竟是有所不同的。


## 总结
1. npm依赖模型下，物理空间上，允许同一包不同版本的存在，一个包的唯一性是`包名+版本号`
2. 尽可能的确保依赖的包版本一致，这点对于整体打包出来的体积会有影响

## 写在最后

搞清楚这点，有益于我们更好的使用和管理依赖，对于最终依赖的版本有了清晰的认知。

## 参考文档
- [The 5 dimensions of an npm dependency](https://snyk.io/blog/whats-an-npm-dependency/)
- [Understanding the npm dependency model](https://lexi-lambda.github.io/blog/2016/08/24/understanding-the-npm-dependency-model/)


