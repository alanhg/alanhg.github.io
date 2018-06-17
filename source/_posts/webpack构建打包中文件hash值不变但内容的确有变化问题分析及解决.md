---
title: webpack构建打包中文件hash值不变但内容的确有变化问题分析及解决
tags:
  - webpack
  - javascript
  - compiler
abbrlink: b39a7fcd
date: 2017-05-10 23:08:11
---
### 在利用webpack2作为构建工具打包Angular4时，出现一个问题就是有两个文件打包出来的哈希值不变。
文件如下: 
```
'common': './node_modules/moment/moment.js',
'polyfills': `./client/${platform}/polyfills.browser.ts`,
```
### 这两个文件，一个是服务于moment这个时间类库，一个是服务于处理SPA应用的浏览器兼容性问题，这两个文件，在webpack配置文件中我的配置方式如下

```
 /**
         * Options affecting the output of the compilation.
         *
         * See: http://webpack.github.io/docs/configuration.html#output
         */
        output: {

            /**
             * The output directory as absolute path (required).
             *
             * See: http://webpack.github.io/docs/configuration.html#output-path
             */
            path: helpers.root('dist'),

            /**
             * Specifies the name of each output file on disk.
             * IMPORTANT: You must not specify an absolute path here!
             *
             * See: http://webpack.github.io/docs/configuration.html#output-filename
             */
            filename: '[name].[chunkhash].bundle.js',

            /**
             * The filename of the SourceMaps for the JavaScript files.
             * They are inside the output.path directory.
             *
             * See: http://webpack.github.io/docs/configuration.html#output-sourcemapfilename
             */
            sourceMapFilename: '[name].[chunkhash].bundle.map',

            /**
             * The filename of non-entry chunks as relative path
             * inside the output.path directory.
             *
             * See: http://webpack.github.io/docs/configuration.html#output-chunkfilename
             */
            chunkFilename: '[id].[chunkhash].chunk.js'

        },

```
### 经过分析发现，打包后，入口文件即bundle文件的哈希值是不变的，但是内容是变了的，因为内容中牵扯到使用了`webpackJsonp`这个函数，而这样就会导致一种场景的存在，比如你的宿主文件index是不缓存的，但是index中指定了其中一个入口文件如上common，但是common的哈希值不变的，这样用户端就会使用缓存文件，
但是chunk文件缺是新的，这样子，用户端是会有报错的问题。

但是为什么内容命名变了，但是hash值是不变的呢，这样子就得查资料，OK，解释如下:

1. hash与chunkhash定义
   + [hash] is replaced by the hash of the compilation.
   + [chunkhash] is replaced by the hash of the chunk.
2. hash、chunkhash使用场景
    chunkhash是根据具体模块文件的内容计算所得的hash值，所以某个文件的改动只会影响它本身的hash指纹，不会影响其他文件。
    
那这样子就明白刚才的问题了，的确ploy和common对应的文件没有改变，所以哈希值是不变的，但是因为我们整体项目比如模块产生了变动，实质上编译后
是会导致内容产生变化的，所以，入口文件并不适合使用`chunkhash`，而应该使用`hash`。


### 参考相关文章
+ http://www.cnblogs.com/ihardcoder/p/5623411.html
+ https://github.com/erm0l0v/webpack-md5-hash/issues/7