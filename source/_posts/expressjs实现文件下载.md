---
title: express实现文件下载
abbrlink: 2c4ec074
date: 2017-03-29 20:36:47
tags:
   - expressjs
   - node
---

查看[expressAPI](http://expressjs.com/zh-cn/4x/api.html#res.download)，
对于文件下载，最简单的实现下载方法为如下

```javascript
res.download('/report-12345.pdf', 'report.pdf', function(err){
  if (err) {
    // Handle error, but keep in mind the response may be partially-sent
    // so check res.headersSent
  } else {
    // decrement a download credit, etc.
  }
});

```
但是这种方法在实际使用中，发现了问题，那就是苹果safari浏览器在下载时候，文件标题会自动截取一段，或者乱码，或者问号，
一开始表示不解，IE都没事，利用fiddler进行抓包分析，发现res头部信息不对劲儿，存在两个filename，也就是不同浏览器对于重复filename处理，不一样，或者说safari对于重复filename会有问题，也就是res.download的写法毕竟是高度封装的，
换句话说，不要用这种高度封装的写法就好了，那么如何解决呢。
如下一种写法，这种没有高度封装，自己去写返回头部信息，经测试Safari下载果然没问题了。

```javascript
    let filename = "你好，地球人你好，地球人你好，地球人你好，地球人.pdf";
    let filePath = path.resolve(__dirname, '..') + '/static/pdf/test.pdf';
    let mimetype = mime.lookup(filePath);
    res.setHeader('Content-Disposition', 'attachment; filename=' + new Buffer(filename).toString('binary'));
    res.setHeader('Content-type', mimetype);
    let filestream = fs.createReadStream(filePath);
    filestream.pipe(res);

```

对比发现，写法1比写法2简单的多，但是目前对于Safari、IE支持是不好的，如果直接用写法2，Edge又会有问题，这时又要牵扯对于不同浏览器，文件名中英文一堆的逻辑判断处理，
所以最好的解决办法是根据请求头部，对应处理下。
对于浏览器判别可以用下面的类库

```javascript
 const parser = require('ua-parser-js');
 let ua = parser(req.headers['user-agent']);
  if (['Edge', 'Chrome', 'Firefox'].indexOf(ua.browser.name) > -1) {
             res.download(filePath, filename, function (err) {
                     if (err) {
                         logger.error('有错误');
                         logger.error(err)
                     }
                     else {
 
                     }
                 }
             );
         }
         else {
             let mimetype = mime.lookup(filePath);
             res.setHeader('Content-type', mimetype);
             if (ua.browser.name == 'IE') {
                 res.setHeader('Content-Disposition', 'attachment; filename=' + encodeURIComponent(filename));
             } /*else if (ua.browser.name == 'Firefox') {
              res.setHeader('Content-Disposition', 'attachment; filename*="utf8\'\'' + encodeURIComponent(filename) + '"');
              } */ else {
                 /* safari等其他非主流浏览器只能自求多福了 */
                 res.setHeader('Content-Disposition', 'attachment; filename=' + new Buffer(filename).toString('binary'));
             }
             let filestream = fs.createReadStream(filePath);
             filestream.pipe(res);
         }

```
### 浏览器支持

上述代码经过测试，支持以下浏览器

- IE
- Chrome
- Firefox
- Edge
- 360(极速、兼容)
- QQ(极速、兼容)