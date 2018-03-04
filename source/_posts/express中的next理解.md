---
title: express中的next理解
abbrlink: e2648a51
date: 2018-03-04 15:41:05
tags:
- express
- node
- expressjs
---
> 一些APP项目开发，使用expressJS作为backend，原因是足够的简单，上手很容易，而且天然的适合做前后端分离项目。在使用中，也逐步对express加深些了解，发现在官网对于next讲解的很少，这里就梳理下，权当加深理解。

## Next的作用
next负责将控制权交给下一个中间件函数。

## Next使用场景即我们为何需要next
当我们处理路由请求时，可能需要下一个中间件处理，那么就应该使用next函数。

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

由此可见，异常处理其实是next使用的一种场景。



