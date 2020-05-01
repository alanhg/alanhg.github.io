---
title: 提升Redux Saga报错可读性
date: 2020-05-01 16:14:12
tags:
- Redux-Saga
---

> Redux-Saga假如执行中报错，实际上是很难看懂的，这点官方也有提及，解决办法就是引入babel-plugin-redux-saga，来提升可读性。

![](http://static.1991421.cn/2020/2020-05-01-172231.png)

直接开搞

## 插件安装

```bash
$ yarn add babel-plugin-redux-saga -D
```

### 注意
- 虽然版本号已经是1.1.2`吐槽下官方的semvor管理不好`,但官方表示这个还是beta,所以不健壮，有风险
- 但因为这个只是服务于开发调试，个人觉得风险也不大

## Webpack配置

```javascript
loader: 'babel-loader',
    options: {
        plugins: [
            'babel-plugin-redux-saga'
        ]
    }
```

### 注意
babel-plugin-redux-saga必须以babel-loader插件的形式引入，假如项目是tsloader，不可以的，解决办法，要么是tsloader切换为babel-loader,要么直接再加入babel-loader。


## 效果

![](http://static.1991421.cn/2020/2020-05-01-161716.jpeg)

注意到，effects的文件名称与行号就会被打印出来


## 参考文档
- https://redux-saga.js.org/docs/Troubleshooting.html
