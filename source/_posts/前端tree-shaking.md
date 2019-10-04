---
title: 前端tree shaking
tags:
  - Frontend
  - Webpack
  - 性能优化
abbrlink: a18dde92
date: 2019-10-04 22:01:03
---
> 单页应用带来更流畅的前端体验，同时也带来了一些麻烦，比如SEO，又比如日益严重的体积问题。当然办法总比困难多，tree shaking便是优化体积问题的办法之一

![](http://static.1991421.cn/2019-10-02-150553.jpg)
 
 
## 上概念
采用tree shaking之前，先搞明白它是什么。

> Tree shaking is a term commonly used in the JavaScript context for dead-code elimination. It relies on the static structure of ES2015 module syntax, i.e. import and export. The name and concept have been popularized by the ES2015 module bundler rollup.
> 
> The webpack 2 release came with built-in support for ES2015 modules (alias harmony modules) as well as unused module export detection. The new webpack 4 release expands on this capability with a way to provide hints to the compiler via the "sideEffects" package.json property to denote which files in your project are "pure" and therefore safe to prune if unused.

### 关键信息提取

1. tree shaking是个专业术语,最早由rollup提出。
2. tree shaking是DCE的一个实现
2. tree shaking依赖E6的静态结构特性`import,export`,so，commonJS无法做到tree shaking.
3. tree shaking的目的是为了消除无用代码（dead code）

## 辅助工具-webpack-bundle-analyzer
为了感官意识到体积的变化，推荐安装下插件`webpack-bundle-analyzer`，插件可以分析整个前端包体积的组成，宏观感受配置的treeShaking是否起作用。

安装走起。

### package.json中增加脚本配置

```json
    "build:analyzer": "node scripts/build.js analyzer",
```

analyzer为自定义属性。

### webpack构建脚本增加插件配置


webpack.config.prod.js

```javascript
const plugins = getPlugins();
if (process.argv[2] === 'analyzer') {
    plugins.push(new bundleAnalyzerPlugin());
}
```

### 注意
1. 这里通过识别构建脚本是否传analyzer参数，从而确定是否开启分析。之所以这样做，我只希望本地启动来分析包大小。
2. BundleAnalyzerPlugin插件默认是开启http服务来展示打包报告的，所以当执行`build:analyzer`脚本，本地会启动一个Web服务,端口默认为8888。

服务启动，访问 [http://127.0.0.1:8888/](http://127.0.0.1:8888/)，就会看到如下画面

![](http://static.1991421.cn/2019-10-03-024947.jpg)

## 举个例子

说明:下面会通过一个项目来说明tree shaking,项目本身是以`create-react-app`初始化的。


### Tech Stack

```json
    "antd": "^3.23.4",
    "webpack": "4.41.0",
    "lodash": "^4.17.15"
```
贴出关键的包，围绕`lodash`这个典型的第三方类库及本身项目代码，我们来开始瘦身之旅。

注意，当我们进行tree shaking，针对的目标其实也就是本身项目中的代码和引用的第三方代码。所以这里我们分两块来做。


接下来我们通过一个例子，来实践下

## tree shaking开启前

### 项目中代码

创建两个工具函数

```
export const appendSuffix = str => str + '_suffix';

export const appendPrefix = str => 'prefix_' + str;

```

假如整个Web中，我们只用到了`appendPrefix`，当我们正常打包，进入构建打包的JS文件中检索，会发现除了`appendPrefix `之外，`appendSuffix `也健在。。。so 这就是我们要干掉的dead code.

`因为工具函数其实去除了dead code，体积上变化也是细微的，所以这部分就不宏观来看体积问题`

![](http://static.1991421.cn/2019-10-03-144616.jpg)

### 第三方lodash
除了本身我们自己创建的函数，平时，我们还会到第三方工具包，比如`lodash`。

实际代码中，假如我们用到了其中的map函数，具体代码如下。

```javascript

import _ from 'lodash';

 render() {
        const columns = _.map(this.columns);
        return (
            <React.Fragment>
                {
                    JSON.stringify(columns)
                }
                <div>
                    {
                        appendPrefix('bob')
                    }
                </div>
            </React.Fragment>
        );
    }

```
构建打包后，体积如下

![](http://static.1991421.cn/2019-10-03-040225.jpg)

体积竟然高达`528KB`，也就是说上述的使用方式其实是将lodash完整的包打进去了。在打包输出JS中检索lodash的其它函数比如`mergeWith`,发现是可以找到的。

![](http://static.1991421.cn/2019-10-03-042834.jpg)

注意，整个WEB的体积这时是3.81MB[未压缩]

## tree shaking配置
上面的体积惨状足以让我们意识到，问题有多大。大量的死代码被放在了最终的JS文件中，最最终让用户为此买单。作为一个专业的前端，这点不能忍。于是开始 摇！树！

### 项目中的dead code

webpack配置中我将模式设置为production

```javascript
module.exports = {
    // Don't attempt to continue if there are any errors.
    bail: true,
    // We generate sourcemaps in production. This is slow but gives good results.
    // You can exclude the *.map files from the build during deployment.
    devtool: shouldUseSourceMap ? 'source-map' : false,
    // In production, we only want to load the polyfills and the app code.
    entry: [require.resolve('./polyfills'), paths.appIndexJs],
    mode: 'production', // 修改点-开启配置
    ...
    }
```
当mode是`production`，默认会启用TerserPlugin插件，而该插件会删除没有用到的代码，比如`appendSuffix`。
修改后，我们重新打包，在打包后的文件中检索，`_suffix` 已经搜不到了，但是prefix还可以搜到

![](http://static.1991421.cn/2019-10-04-095220.jpg)

`为什么这里没有按照工具函数名称去搜索，因为插件默认出了进行tree shaking，还对代码进行了混淆，函数名称改变了`

因此我们有理由相信，当设置为生产模式，这些基本的死代码都可以被去除掉。

### lodash中的dead code
刚才的设置，只是可以剔除掉简单的一些代码，回头看整体体积，基本没变，为什么？因为lodash大哥还在。so,我们要继续革lodash的命。

#### 设置

lodash包本身的导出是commonJS，这个是无法做tree shaking的，当然有其它的办法做类似tree shaking的处理。
这里，我们围绕tree shaking来解决，so要安装es版的lodash,so继续下面的。

1. 安装lodash-es
	
	```
	yarn remove lodash
	yarn add lodash-es
	```
	
2. 修改导入方式
   	
   	```javascript
   	import {map} from 'lodash-es';

   	```
	lodash-es导出为es modules，所以我们利用这个进行按需导入，打包时候就会将不需要的模块删除。

重新run app,发现lodash体积明显缩小

![](http://static.1991421.cn/2019-10-04-102758.jpg)	

如上我们解决了项目本身和第三方lodash的体积问题，顺便，再说说antd，毕竟这个也很常用。	
### antd体积问题
项目中经常使用antd UI组件库，但并不是每个UI组件都会用到，那么这个体积问题如何进行解决呢。官方给了方案

1. babel-plugin-import
	
	```json
	yarn add babel-plugin-import
	```

2. babel plugin配置
	
	```json
	 "plugins": [
      [
        "import",
        {
          "libraryName": "antd",
          "libraryDirectory": "es",
          "style": "css"
        }
      ]
    ]
	```
	
3. 导入方式改写

	```
	import {Button, Table} from 'antd';
	```

#### 注意
1. 因为babel插件的配置，组件按需加载的同时，对应模块样式也进行了按需加载，所以不需要全局加载完整的antd样式，或者手动加在模块组件样式。
2. 假如不安装该插件，也可以进行tree shaking,即

	```javascript
import Button from 'antd/es/button';
import Table from 'antd/es/table';
import 'antd/es/button/style/css';
import 'antd/es/table/style/css';
	```

对比如上，哪个更为简单呢，仁者见仁的事，个人喜欢上面的插件方案，也就是antd官方推荐的方案。其中一个原因是不能导入多个组件。


## 副作用(Side Effect)
副作用是个术语，如果玩过redux-saga应该对此很熟悉。

如果代码有副作用，tree shaking就无法对该代码生效。也就是说tree shaking后的代码，只保留了有副作用的代码，对于其它无副作用的，未被使用的代码，均被删除。

查看lodash的包文件，我们可以发现lodash是没有副作用的。所以上面的例子中我们才进行tree shaking

[lodash package.json](https://github.com/lodash/lodash/blob/master/package.json)

### 包含副作用的代码不能tree shaking? 

是的。


## 写在最后
以上是我在实际项目中的困惑，so，多翻查看，才有这么点产出。权当抛砖引玉了。

## 参考资料
- [webpack official doc](https://webpack.js.org/guides/tree-shaking/)
- [你的Tree-Shaking并没什么卵用](https://juejin.im/post/5a5652d8f265da3e497ff3de)
- [The Correct Way to Import Lodash Libraries](https://www.blazemeter.com/blog/the-correct-way-to-import-lodash-libraries-a-benchmark/)
- [Reduce JavaScript Payloads with Tree Shaking](https://developers.google.com/web/fundamentals/performance/optimizing-javascript/tree-shaking/)
- [配置Tree Shaking来减少JavaScript的打包体积](https://blog.fundebug.com/2018/08/15/reduce-js-payload-with-tree-shaking/)
- [es6-modules-in-depth](https://ponyfoo.com/articles/es6-modules-in-depth)
- [Tree-shaking in real world: what could go wrong?](https://medium.com/@lawliet29/tree-shaking-in-real-world-what-could-go-wrong-b398c2b2ebbb)
- [使用 Tree Shaking](http://www.xbhub.com/wiki/webpack/4%E4%BC%98%E5%8C%96/4-10%E4%BD%BF%E7%94%A8TreeShaking.html)
- [Webpack Deep Scope Analysis Plugin](https://github.com/vincentdchan/webpack-deep-scope-analysis-plugin)
- [GitHub Issue -- Tree Shaking?](https://github.com/facebook/create-react-app/issues/2748)
- [tree-shaking不完全指南](https://www.jianshu.com/p/199850576e8c)
- [tree-shaking](https://github.com/demos-platform/tree-shaking)