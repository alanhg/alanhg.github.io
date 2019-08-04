---
title: Jest下Less导入报错
tags:
  - Jest
  - JavaScript
  - LESS
abbrlink: d6bb1337
date: 2019-08-04 21:22:24
---
> 最近前端项目UT报错，一开始一脸懵逼，一点点的剥丝抽茧，搞明白了。这里MARK下。

## 错误现象

![](http://static.1991421.cn/2019-08-04-121718.jpg)

### 报错CODE
```bash
Test suite failed to run

    Jest encountered an unexpected token

    This usually means that you are trying to import a file which Jest cannot parse, e.g. it's not plain JavaScript.

    By default, if Jest sees a Babel config, it will use that to transform your files, ignoring "node_modules".

    Here's what you can do:
     • To have some of your "node_modules" files transformed, you can specify a custom "transformIgnorePatterns" in your config.
     • If you need a custom transformation specify a "transform" option in your config.
     • If you simply want to mock your non-JS modules (e.g. binary assets) you can stub them out with the "moduleNameMapper" config option.

    You'll find more details and examples of these config options in the docs:
    https://jestjs.io/docs/en/configuration.html

    Details:

    /xxx/xx/B.less:1
    ({"Object.<anonymous>":function(module,exports,require,__dirname,__filename,global,jest){.searchRow {
                                                                                             ^

    SyntaxError: Unexpected token .

      31 | 
      32 | 
    > 33 | import styles from 'app/xxx/xx/B.less';
         | ^
```


## 初步分析

1. 为什么是某个组件对应的LESS出现问题

	出现这个错误，觉得奇怪，因为导入less的组件很多，为什么就这个报错呢，一开始还以为是LESS中写了什么乱码空格之类的，不被肉眼看出。但重新格式化敲了下，实在没看出什么。

	所以就对比了下其它的组件，发现报错的less有一点不同，就是被两个组件导入。比如A组件下有样式A.less，A组件本身导入了样式A.less,B组件也导入了A.less，，我快速拷贝了B.less出来，重跑UT，OK。

2. 挂了的UT是Main组件，为何

因为确定了是组件导入less的问题，然后这点就好分析了。Main组件中会导入路由配置，而路由配置文件中是有导入主要的组件的，so，UT跑时，会执行这些导入，进而就报了错。

3. 运行OK，UT却不OK，jest配置？
既然运行不报错，so说明code是可以的。于是看了下当前的jest配置，恍然大悟

![](http://static.1991421.cn/2019-08-04-125119.jpg)

对于绝对路径app导入的模块，并不会走`identity-obj-proxy`,而出错的行就是app路径导入，so，less没有成功mock。

我尝试添加如下规则。

![](http://static.1991421.cn/2019-08-04-130129.jpg)

重跑UT，过了。

## 最佳解决办法
虽然以上面的加配置方案可以解决，但最佳方案呢？这点值得思考。

上述问题暴露出，目前的jest配置确有不足，假如就是导入了app路径下的less，UT就会挂，但是就事论事，目前会存在需要导入app绝对路径下的less吗，`不会`。

因为如上其实导入了重复的一份less，单说打包体积，其实就是灰打包重复的一份less，因为有css module其实两份还不互相影响。但既然是要复用这份样式，目前问题只是姿势不对。

### 正确姿势
假如需要复用这样的less，

1. 一个办法是放在根组件的index.less下，这里的css是global，也就是全局的。

2. 假如不放这里的呢，可以放在两个组件的共同父组件级。比如这两个组件是A组件和B组件，那么他们有个共同的父组件C，样式就放在C上。那么A，B自然就可以复用了。


## 牵扯到的知识点梳理
1. CSS模块化
CSS模块化是现在非常成熟的一种css样式管理方案，为什么说是管理，因为有了它，其实解决了一直比较烦的CSS冲突问题。同时CSS模块化又提供了全局样式的口子。那么管理起来就比较优雅。

2. import styles from 'index.less'，这种导入方式，让CSS的使用变成了JS的使用方式，那么假如我们移动位置，假如我们重命名CSS，那么就可以自动修改。这种一统了CSS和JS。棒不棒。

3. jest中的identity-obj-proxy,这个模块是为了解决我们UT测试的组件中对于非JS资源的使用，比如CSS，PNG，SVG等。在测试中，很多东西都需要mock，test永远是以最低的造假成本和最真实的测试点从而去check我们的核心logic。

## 总结
讲到这里，这个问题也解决了，也搞明白了。开心。前端坑还是不少的。不过万法不离其宗。与君共勉。



