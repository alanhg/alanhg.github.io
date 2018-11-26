---
title: Session在express中应用
abbrlink: c9d6710f
date: 2016-10-16 14:49:01
tags:
- Express
- NodeJS
- Session
---
> HTTP是无状态协议，维持前后端的用户状态，Session是一种方案，Express下如何去做呢，看下文

![](http://static.1991421.cn/2018-06-21-035100.jpg)

1. 安装Session中间件
`npm i express-session --save`

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

3. 用户登录更新Session

```javascript
router.post('/login', (req, res) => {
        const user = appUsers[req.body.email];
        if (user && user.password === req.body.password) {
            const userWithoutPassword = {...user};
            delete userWithoutPassword.password;
            req.session.user = userWithoutPassword;
            res.status(200).send({
                user: userWithoutPassword
            });
        } else {
            res.status(403).send({
                errorMessage: 'Permission denied!'
            });
        }
    }
);

```

4. 用户退出 销毁Session

```javascript
router.get('/logout', function (req, res) {
    req.session.destroy((err) => {
        if (err) {
            res.status(500).send('Could not log out.');
        } else {
            res.status(200).send({});
        }
    });
});
```

5. 改变Session存储方案
Session存储的默认存储方案为MemoryStore，当我们生产环境应用时，会得到如下提示
```
Warning: connect.session() MemoryStore is not
designed for a production environment, as it will leak
```
比如这里，我使用Redis作为生产级存储方案，所以服务器需要安装Redis,`yum install -y redis`
同时，后端需要安装对应中间件`npm install connect-redis --save`，所以再看上面的配置，就明白为什么生产环境下，要加Redis配置喽。
