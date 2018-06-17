---
title: expressjs中的next理解
abbrlink: e2648a51
date: 2018-03-04 15:41:05
tags:
- node
- expressjs
---
> 一些轻量级项目开发，TEAM常使用expressJS作为backend，原因是足够的简单，上手很容易，而且天然的适合做RESTful。在使用中，也逐步对express加深些了解，发现在官网对于next讲解的很少，这里就梳理下，权当加深理解。

## Next的作用
next负责将控制权交给下一个中间件函数。

## Next使用场景即我们为何需要next
当我们处理路由请求时，可能需要下一个中间件处理，那么就应该使用next函数。比如异常处理，或者请求处理分支化。

## 上代码

### 例子1

```
router.get("/hello", function (req, res, next) {
    res.write("hello");
    next();
});

router.get("/hello", function (req, res) {
    res.write(" world");
    res.end();
});

```

执行后，结果截图

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-03-04-083842.png)
当我们没有结束请求回复时，利用next可以继续进行处理。

### 例子2

```
router.get("/hello", function (req, res, next) {
    if (req.query.name) {
        return res.json("hello");
    }
    else {
        next(new Error("没有name"));
    }
});

router.use(function (err, req, res, next) {
    res.json({
        message: err.message,
        error: {}
    });
});

```

执行请求`http://localhost:3001/api/hello`
结果截图
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-03-04-092302.png)

异常处理其实是next使用的一种场景。

*注意:*因为这里是先路由请求之后进行的异常处理，所以这里异常中间件处理在路由请求处理之后。

## 相关文档
+ [expressjs源码](https://github.com/expressjs/express)
+ [对express中next函数的一些理解](https://cnodejs.org/topic/5757e80a8316c7cb1ad35bab)
+ [Express.js Middleware Tutorial](http://qnimate.com/express-js-middleware-tutorial/)

