---
title: browserslist做兼容性管理
date: 2021-02-02 17:39:29
tags:
- 兼容性
- front-end
---
> 我们开发的网页需要运行在各种各样的浏览器下，而不同浏览器，不同版本对于网页解析都会有些许差异，如果是IE，就更麻烦。曾几何时，前端er聊起IE兼容就蛋疼，内心骂了IE多少次。
>
> 如何优雅的处理兼容性问题，是个固定的课题。现在对于这个问题已经有了相对系统化的方案来解决，这里就Mark下。

说明：场景不同，习惯不同，因此配置方式不唯一，这里以我个人的实践来说明，仅供参考。

## browserslist

### 配置

项目根目录下创建`.browserslistrc`文件，根据需求写下目标浏览器范围，比如我这里配置如下

```
# Browsers that we support
last 1 years
```

含义：即需要支持最近1年的浏览器及版本

browserslist具体配置语法，[戳这里](https://github.com/browserslist/browserslist#query-composition)

### 测试

配置后，终端执行以下命令，即可获取目标浏览器版本列表

```
$ npx browserslist
```

![](https://static.1991421.cn/2021/2021-02-03-094437.jpeg)

###  注意

- browserslist仅是提供了一套机制方便设置、获取目标浏览器及其版本

- 真正兼容性处理还需要其它工具，从而根据浏览器清单进行检测及修复

如下，继续安装配置。

## eslintsplugin-compat

### 安装

```bash
$ yarn add eslint-plugin-compat -D
```

### 配置

`.eslintrc.js`中增加以下配置

```javascript
module.exports = {
  root: true,
  extends: [
    'plugin:compat/recommended'
  ],
  rules: {
    'compat/compat': ['error'],
  }
};
```

执行`eslint src/main/webapp/**/*.{ts,tsx} --quiet`即可根据目标浏览器进行兼容性检测，如果有错，则会提示。



因为上述我的浏览器支持还是挺新的，不容易出现支持性问题，比如我把浏览器清单改为`last 10 years`，那么报错即出现

![](https://static.1991421.cn/2021/2021-02-03-095540.jpeg)



### 注意

`eslint-plugin-compat`主要聚焦WEB API，对于ES API并不会进行检查，因此对于ES API本身还需要其它Lint插件进行检测。

## eslint-plugin-es

> 该插件即是为了进行ES检测，比如ES9的向后断言，Safari下并不支持，于是我们需要增加对应规则来屏蔽该写法。

### 安装

比如屏蔽向后断言，需要进行以下配置

```bash
$ yarn add es/no-regexp-lookbehind-assertions -D
```

### 配置

`.eslintrc.js`中增加以下rule

```javascript
'es/no-regexp-lookbehind-assertions': ['error']
```

## CSS

CSS问题与JS类似，但CSS本身并不会造成页面白屏等，只会是一些样式不work。同时postcss可以生成目标浏览器指定CSS写法。



### 安装

```bash
$ yarn add postcss-loader -D

$ yarn add stylelint-no-unsupported-browser-features -D

$ yarn add obsolete-webpack-plugin -D

```

###  配置

`.stylelintrc.json`增加以下配置

```javascript
{
  "plugins": [
    "stylelint-no-unsupported-browser-features"
  ],
  "rules": {
    "plugin/no-unsupported-browser-features": [
      true,
      {
        "severity": "warning"
      }
    ]
  }
}

```

Webpack中增加配置

```javascript
{
          test: /\.css$/,
          use: [
            'postcss-loader'
          ]
        }
```

1. 当执行stylelint命令` stylelint src/main/webapp/**/*.less --syntax=less`即可检测样式在目标浏览器下的支持情况
2. postcss会自动追加部分兼容样式写法，确保了样式写在在目标浏览器下支持

## obsolete-webpack-plugin

当页面出现不支持时，有时会直接白屏，对于用户而言，体验太差，因此可以追加检测脚本来提醒用户，这个插件便是解决该问题的。

###   安装

```bash
$ yarn add obsolete-webpack-plugin -D
```

### 配置

```javascript
plugins: [new ObsoleteWebpackPlugin()]
```



## 测试

打包后，会生成obsolete.js脚本文件，同时index中引入了该JS。



## 写在最后

- 如上我们即可有效管理前端浏览器兼容性。
- 假如目标浏览器及版本范围出现变化，需要做的是`修改browserslist=>检测JS，CSS=>按照错误提示进行修复`即可。

## 参考链接

- https://watofundefined.dev/posts/regexp-lookbehinds-bit-me-in-the-behind/