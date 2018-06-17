---
title: 关于构建打包出现"JavaScript heap out of memory"
tags:
  - webpack
  - node
  - angular
abbrlink: 68bd2a5b
date: 2017-10-11 20:56:20
---
> 在进行angular项目开发时，使用webpack进行打包，最近频繁出现了`JavaScript heap out of memory`即内存溢出，查找资料，找到了解决办法，这里记录下

![error](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-12-044030.jpg)

## 解决方法
本质问题是，项目打包所需要的性能开销，超过了v8缺省的内存限定，需要修改下配置

### 1. 构建脚本中配置
增加`node --max_old_space_size=4096`配置.我这里的具体配置如图
![package.json](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-11-151309.jpg)

![package.json](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-11-151334.jpg)

### 2. webpack命令中配置
看到网上这种做法是在项目`node_modules/.bin/webpack`进行配置，的确可以，但不建议这么做，node_modules是第三方模块，直接修改源码，不方便项目维护及协作开发，如果重新安装模块或者升级webpack插件，就直接导致失效。

如果是在.bin下的脚本文件直接配置，如下:

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-10-11-151428.jpg)

`方法2仅供了解，建议使用方法2`

## 补充

> Currently, by default v8 has a memory limit of 512mb on 32-bit systems, and 1gb on 64-bit systems. The limit can be raised by setting –max-old-space-size to a maximum of ~1gb (32-bit) and ~1.7gb (64-bit), but it is recommended that you split your single process into several workers if you are hitting memory limits. 

通过上述这段文字描述，可以了解，v8缺省的内存设定情况。
