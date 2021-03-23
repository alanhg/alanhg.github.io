---
title: Webpack4升级至5
date: 2021-03-23 23:18:48
tags:
- webpack
---

> webpack5发布已经有5个月了，配套的插件都已基本到位，空闲时间，就着手项目升级工作。



## webpack5的主要变化

1. 持久化缓存改进，提升构建性能
2. 摇树优化，一定程度降低构建资源体积大小
3. 引入一些breaking change，从而为未来的升级，做些准备工作

总之，毕竟只是构建层次的工具，对于最终打包的JS功能并不会造成影响，因此还是值得升级。



## 升级操作

升级的详细操作还是参考官网，这里列出重要步骤

1. webpack插件更新到最新

   推荐使用`yarn upgrade-interactive `命令方式批量选择进行更新，高效些。

2. 部分设置调整

   - HtmlWebpackPlugin插件的chunksSortMode值变化，需要改为auto等值
   - webpack-merge中的merge函数不再是缺省导出
   - 命令webpack-dev-server修改为webpack-cli serve

3. 前端代码中如果有node相关包，一个方式是去掉依赖，一个是安装对应包，进行配置。

   -  比如我的项目中之前使用到了`content-disposition`，因此决定重写为浏览器JS实现



## 写在最后

- 整个升级过程还是比较简单的，修改点并不多，但多少还是有坑。