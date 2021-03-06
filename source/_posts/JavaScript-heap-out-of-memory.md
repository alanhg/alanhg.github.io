---
title: JavaScript heap out of memory
tags:
  - nodejs
  - webpack
  - Angular
abbrlink: 7fa2b445
date: 2017-07-22 17:07:56
---
## 问题
最近在ng开发，牵扯到构建打包，在进行JIT打包，一切正常，但是当AOT打包时，会报`JavaScript heap out of memory`及内存溢出,如下图

![out of memroy](https://static.1991421.cn/JavaScript%20heap%20out%20of%20memory.jpg)

经查询，可以通过设定较高的空间内存来解决这个问题。

## 解决
提升`max_old_space_size`

比如我这里是package中定义webpack打包脚本命令，所以，如下

```
    "webpack": "node --max_old_space_size=4096 node_modules/webpack/bin/webpack.js"
```
再进行打包，就OK啦。

## 说明
+ 内存单位为`MB`
+ AOT对比JIT，多了ngc编译环节，所以的确内存会吃的多些。
