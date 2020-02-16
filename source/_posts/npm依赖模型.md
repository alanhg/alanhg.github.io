---
title: npm依赖模型
date: 2020-02-16 01:28:18
tags:
- npm
- Node
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

## Webpack打包
如上的两种情况，node_modules中存在多版本的包，但是具体的代码中我们导入包都是直接用的包名路径来导入，不存在版本的概念，那问题来了打包后，vendor文件中的会是哪个版本呢？


这时要了解一点，就是`NPM体系下，唯一性是包名+版本号`。

**假设情况是第一种，也就是直接依赖和间接依赖都有。**

实际上两个版本对应使用的模块都会导入。项目中如果我们使用了hello,webpack会认为我们使用的是直接依赖的包，而bar中使用了hello,对应的依赖路径实际上是不同的，所以也会导入。

**假设情况是第二种，也就是间接依赖都有。bar和foo依赖的版本不同，对应的依赖路径**

实际上两个版本对应使用的模块都会导入。因为各自模块中使用的hello包名+版本号是不同的。假如这个时候我们项目中也导入了hello包，这时它导入的是哪个版呢？


## 总结
1. npm依赖模型下，物理空间上，允许同一个包不同版本的存在，一个包的唯一性是`包名+版本号`
2. 尽可能的确保依赖的包版本一致，对于整体打包出来的体积会有影响

## 写在最后

搞清楚这点，有益于我们更好的使用和管理依赖，对于最终依赖的版本有了清晰的认知。

## 参考文档
- [The 5 dimensions of an npm dependency](https://snyk.io/blog/whats-an-npm-dependency/)
- [Understanding the npm dependency model](https://lexi-lambda.github.io/blog/2016/08/24/understanding-the-npm-dependency-model/)


