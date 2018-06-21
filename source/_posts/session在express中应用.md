---
title: Session在express中应用
abbrlink: c9d6710f
date: 2016-10-16 14:49:01
tags:
- Express
- NodeJS
- Session
---
> HTTP是无状态协议，维持前后端的用户状态，session是一种传统方案，如何去做呢，看下文

1. 安装Session中间件
`npm i express-session --save`
session存储的默认存储方案为MemoryStore，当我们生产环境应用时，会得到如下提示
```
Warning: connect.session() MemoryStore is not
designed for a production environment, as it will leak
```
比如这里，我使用Redis作为生产级存储方案，所以服务器需要安装Redis,`yum install -y redis`
同时，后端需要安装对应中间件`npm install connect-redis --save`

2.Session配置开启
app.js下进行如下配置，这里直接贴出完整文件
```javascript
const express = require('express');
const app = express();
const conf = require('./config');
const routes = require('./routes/index');
const path = require('path');
const bodyParser = require('body-parser');
const isDeveloping = (process.env.NODE_ENV || 'development') == 'development';
const session = require("express-session");

app.enable('trust proxy'); // trust first proxy
app.use(bodyParser.json()); // for parsing application/json


const sessionConfig = {
    secret: "Shh, its a secret!",
    resave: false,
    saveUninitialized: true
};
if (!isDeveloping) {
    const RedisStore = require('connect-redis')(session);
    sessionConfig.store = new RedisStore(conf.redis);
}
app.use(session(sessionConfig));
// mount the router on the app
app.use('/', routes);
//配置静态资源
app.use('/', express.static(path.join(__dirname, '/static')));

if (!isDeveloping) {
    app.use('/', express.static(path.join(__dirname, 'dist')));
    app.get('*', function (req, res) {
        res.sendFile(__dirname + '/dist/index.html');
    });
}

app.listen(conf.server.port, "127.0.0.1", function () {
        console.log(`campus-server app listening on port ${conf.server.port}!`);
    }
);
``` 
