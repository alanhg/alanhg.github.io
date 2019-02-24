---
title: dependencies vs devDependencies
tags:
  - npm
  - node
abbrlink: 7b904316
date: 2019-02-17 17:22:49
---
> npm是 Node.js 平台的包管理工具,实际开发中我们并不是从零做起，往往需要安装大量的包用于开发及生产使用，这时，我们就需要安装包，并且将其配置在package.json文件中，明确其依赖。在package.json文件中，有两个依赖声明位置dependencies和devDependencies。那么针对一个包，我们到底是安装到dependencies还是devDependencies呢，本文旨在把这点差异明确下。

![](http://static.1991421.cn/2019-02-17-092336.png)

## 官方定义

先来权威官方概述

### dependencies
> Dependencies are specified in a simple object that maps a package name to a version range. The version range is a string which has one or more space-separated descriptors. Dependencies can also be identified with a tarball or git URL.

> Please do not put test harnesses or transpilers in your dependencies object. See devDependencies, below.

官方明确了一点就是`不要将测试及转译相关包放在dependencies,而应该放在devDependencies`

### devDependencies

> If someone is planning on downloading and using your module in their program, then they probably don’t want or need to download and build the external test or documentation framework that you use.

> In this case, it’s best to map these additional items in a devDependencies object.

> These things will be installed when doing npm link or npm install from the root of a package, and can be managed like any other npm configuration param. See npm-config for more on the topic.

> For build steps that are not platform-specific, such as compiling CoffeeScript or other languages to JavaScript, use the prepare script to do this, and make the required package a devDependency.
我来简要翻下:
`构建需要而非平台专用，比如编译CoffeeScript或者其它语言到JavaScript，这样的应该设定为devDependency。`

## 上例子
如下是我实际上手的一个项目,项目是一个React前端项目，因为处于从JS到TS迁移期，所以存在Babel.

贴出大致的包依赖表，我们拿其中一些包来说明下。

```json
  "dependencies": {
    "@fortawesome/fontawesome-svg-core": "1.2.4",
    "@fortawesome/free-solid-svg-icons": "5.3.1",
    "@fortawesome/react-fontawesome": "0.1.3",
    "availity-reactstrap-validation": "2.0.6",
    "axios": "0.18.0",
    "babel-polyfill": "^6.26.0",
    "bootstrap": "4.1.3",
    "classnames": "^2.2.5",
    "deep-equal": "latest",
    "file-saver": "^2.0.0",
    "history": "^4.7.2",
    "html2canvas": "1.0.0-alpha.12",
    "immutable": "^3.8.2",
    "jest-enzyme": "^7.0.1",
    "loaders.css": "0.1.2",
    "lodash": "4.17.10",
    "moment": "2.22.2",
    "normalize.css": "^7.0.0",
    "promise": "8.0.1",
    "prop-types": "^15.6.1",
    "query-string": "5.1.1",
    "rc-dropdown": "^2.2.0",
    "rc-input-number": "^4.0.6",
    "rc-menu": "^7.4.20",
    "rc-pagination": "^1.14.0",
    "rc-select": "^7.5.1",
    "rc-slider": "^8.6.1",
    "rc-tooltip": "^3.7.3",
    "react": "16.4.2",
    "react-dom": "16.4.2",
    "react-hot-loader": "3.1.1",
    "react-intl": "^2.7.2",
    "react-modal": "^3.3.2",
    "react-redux": "5.0.7",
    "react-redux-loading-bar": "4.0.5",
    "react-router-dom": "4.3.1",
    "react-select": "^2.0.0",
    "react-sizeme": "^2.5.2",
    "react-toastify": "4.2.0",
    "react-transition-group": "^2.5.2",
    "redux": "4.0.0",
    "redux-actions": "^2.3.0",
    "redux-actions-helper": "^1.0.0",
    "redux-devtools": "3.4.1",
    "redux-devtools-dock-monitor": "1.1.3",
    "redux-devtools-log-monitor": "1.4.0",
    "redux-promise-middleware": "5.1.1",
    "redux-saga": "^0.16.2",
    "redux-thunk": "2.3.0",
    "reselect": "^3.0.1",
    "source-map-loader": "^0.2.2",
    "superagent": "^3.6.3",
    "jspdf": "1.5.3",
    "xml2js": "0.4.19"
  },
  "devDependencies": {
    "@types/enzyme": "3.1.13",
    "@types/jest": "23.3.1",
    "@types/lodash": "^4.14.119",
    "@types/node": "10.9.2",
    "@types/react": "16.4.12",
    "@types/react-dom": "16.0.7",
    "@types/react-intl": "^2.3.15",
    "@types/react-redux": "6.0.6",
    "@types/react-router-dom": "4.3.0",
    "@types/redux": "3.6.31",
    "@types/webpack-env": "1.13.6",
    "autoprefixer": "9.2.0",
    "babel-core": "6.25.0",
    "babel-eslint": "7.2.3",
    "babel-jest": "20.0.3",
    "babel-loader": "7.1.1",
    "babel-plugin-transform-decorators-legacy": "^1.3.4",
    "babel-polyfill": "^6.26.0",
    "babel-preset-es2015": "^6.24.1",
    "babel-preset-es2016": "^6.24.1",
    "babel-preset-react": "^6.24.1",
    "babel-preset-react-app": "^3.0.3",
    "babel-preset-stage-0": "^6.24.1",
    "babel-runtime": "6.26.0",
    "browser-sync": "2.26.3",
    "browser-sync-webpack-plugin": "2.2.2",
    "cache-loader": "1.2.2",
    "codelyzer": "3.1.2",
    "copy-webpack-plugin": "4.5.2",
    "cross-env": "5.2.0",
    "css-loader": "1.0.0",
    "enzyme": "3.5.0",
    "enzyme-adapter-react-16": "1.3.0",
    "enzyme-to-json": "3.3.4",
    "eslint": "4.9.0",
    "eslint-config-react-app": "^2.0.1",
    "eslint-loader": "1.9.0",
    "eslint-plugin-flowtype": "2.35.0",
    "eslint-plugin-import": "2.7.0",
    "eslint-plugin-jsx-a11y": "5.1.1",
    "eslint-plugin-react": "7.1.0",
    "exports-loader": "0.6.4",
    "express": "^4.12.3",
    "extract-text-webpack-plugin": "3.0.0",
    "file-loader": "2.0.0",
    "fork-ts-checker-webpack-plugin": "0.4.9",
    "friendly-errors-webpack-plugin": "1.7.0",
    "html-loader": "0.5.0",
    "html-webpack-plugin": "3.2.0",
    "husky": "1.1.0",
    "identity-obj-proxy": "3.0.0",
    "jasmine-core": "2.7.0",
    "jest": "23.5.0",
    "jest-junit": "5.1.0",
    "jest-sonar-reporter": "2.0.0",
    "json-loader": "0.5.7",
    "karma": "1.7.1",
    "karma-chrome-launcher": "2.2.0",
    "karma-coverage": "1.1.1",
    "karma-intl-shim": "1.0.3",
    "karma-jasmine": "1.1.0",
    "karma-junit-reporter": "1.2.0",
    "karma-notify-reporter": "1.0.1",
    "karma-remap-istanbul": "0.6.0",
    "karma-sourcemap-loader": "0.3.7",
    "karma-webpack": "2.0.4",
    "less": "^3.0.0-alpha.3",
    "less-loader": "^4.0.5",
    "lint-staged": "7.3.0",
    "react-dev-utils": "^4.1.0",
    "react-infinite-scroller": "1.2.0",
    "redux-mock-store": "1.5.3",
    "redux-saga-test-plan": "^3.7.0",
    "rimraf": "2.6.2",
    "simple-progress-webpack-plugin": "1.1.2",
    "source-map-loader": "0.2.4",
    "string-replace-webpack-plugin": "0.1.3",
    "style-loader": "0.22.1",
    "swagger": "^0.7.5",
    "swagger-express-mw": "^0.1.0",
    "swagger-ui": "2.2.10",
    "terser-webpack-plugin": "1.0.2",
    "thread-loader": "1.2.0",
    "to-string-loader": "1.1.5",
    "ts-jest": "23.1.4",
    "ts-loader": "4.5.0",
    "tslint": "5.11.0",
    "tslint-config-prettier": "1.15.0",
    "tslint-eslint-rules": "5.4.0",
    "tslint-loader": "3.6.0",
    "tslint-react": "3.6.0",
    "typescript": "3.0.1",
    "uglifyjs-webpack-plugin": "^1.1.1",
    "url-loader": "^0.6.2",
    "web-app-manifest-loader": "0.1.1",
    "webpack": "4.17.1",
    "webpack-cli": "3.1.0",
    "webpack-dev-server": "3.1.6",
    "webpack-merge": "4.1.4",
    "webpack-notifier": "1.7.0",
    "workbox-webpack-plugin": "3.4.1"
  },
```

- React及相关的组件库或者redux库，rc-dropdown, redux，这些是实际平台需要的，所以在dependencies下
- 比如@types这些，只是在开发阶段需要，实际编译打扰后是JS，根本不是必须，所以在devDependencies
- 比如babel，webpack相关包，karma等这些转译器，构建工具，测试框架等，按照官方说明，都应该在devDependencies

### 写在最后

有些开发似乎不care这两者区别，dependencies与devDependencies，随便放，开发上线都无伤大雅.但是这样做并不好。

当我们正确维护了package.json文件中的依赖关系之后，我们有两点收益
1. 在生产部署时，我们执行`npm install --production`或者环境变量`NODE_ENV`设定为`production`，不会安装devDependencies下的任何包，`这样整个包体积就会很小，包少，部署速度自然也会快`。
2. 通过文件，我们很清楚开发与生产依赖，降低了维护成本