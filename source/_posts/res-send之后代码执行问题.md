---
title: res.send之后代码执行问题
tags:
  - expressjs
  - nodejs
abbrlink: d0f93228
date: 2017-09-25 09:28:20
---
> express是node.js下最受欢迎的框架了，灵活的中间件思维及路由控制，使其实现了简单上手。
但是灵活往往会带来另一个问题就是可维护性，毕竟灵活对于团队开发的规范就有了更高的要求。

在实际的开发中，一些细节，需要注意，否则潜在的危险就会隐埋，并且随时可能会爆发。

如下图，构造一个API接口请求，返回结果
```javascript
router.get('/c', function (req, res) {
    let conf2 = require('../conf');
    res.send({value: conf2.a});
    console.log('hello');
});
```

运行发现，其实res.send之后的控制台输出还是执行了，如何避免呢，加上`return`
```javascript
router.get('/c', function (req, res) {
    let conf2 = require('../conf');
    return res.send({value: conf2.a});
    console.log('hello');
});
```
再次执行就没有问题了，自己看一遍官网，发现，官网给出的demo都没有写return,原因应该是官网给出的都是简单的逻辑，res.send往往是路由处理的最后一句话
那么的确写与不写是一样的，但是当我们的路由逻辑复杂一些，需要终端请求返回时,那么的确是需要return。

如下这个复杂逻辑，提前返回请求，必须写return,否则下面的逻辑仍然会继续执行，造成麻烦。
```javascript
router.get('/download', function (req, res) {
  let key = req.query.key;
  let ua = parser(req.headers['user-agent']);
  redisClient.get(key, function (err, reply) {
    if (!reply) {
      return res.status(404).send('The download link has expired');
    }
    // reply is null when the key is missing
    let obj = JSON.parse(reply);
    let filePath = config.download.directory + `${obj.path}`;
    let filename = obj.filename;
    //res.download返回头部是双filename，对于Safari支持有问题，所以换流形式

    if (['Edge', 'Chrome', 'Firefox'].indexOf(ua.browser.name) > -1) {
      res.download(filePath, filename, function (err) {
          if (err) {
            logger.error('有错误');
            logger.error(err)
          }
        }
      );
    }
    else {
      let mimetype = mime.lookup(filePath);
      res.setHeader('Content-type', mimetype);
      if (ua.browser.name == 'IE') {
        res.setHeader('Content-Disposition', 'attachment; filename=' + encodeURIComponent(filename));
      } else {
        /* safari等其他非主流浏览器*/
        res.setHeader('Content-Disposition', 'attachment; filename=' + new Buffer(filename).toString('binary'));
      }
      let filestream = fs.createReadStream(filePath);
      filestream.pipe(res);
    }

  });
});
```