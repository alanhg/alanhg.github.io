---
title: expressjs获去请求IP问题
tags:
  - expressjs
  - proxy
abbrlink: ce2e8f4
date: 2017-05-31 23:06:05
---

在实际开发中遇到这样的情况，比如一些外企企业，使用了网络代理，我在后端获取IP，发现存在空的情况。
分析下，原因如下:
当我们应用设定了信任代理的时候，直接使用`req.ip`获取的会是客户端的真实IP，但是信任代理的话，代理是会修改[XXF](https://zh.wikipedia.org/zh-hans/X-Forwarded-For)头部信息的，比如
我遇到的情况就是代理修改请求头，导致我获取的`req.ip`为空，其实代理改了头，隐藏了真实客户端IP的话，的确我们是不可能得到真实的客户端IP了，但是代理本身的IP还是可以得到的，所以，我就封装了我自己的获取IP方法，

```javascript
/**
 * 获取客户端IP地址
 * req.ips would be ["client", "proxy1", "proxy2"]
 * 优先取客户端真实IP或最接近客户端一级的代理IP
 */
util.getClientIP = function (req) {
    let ip = req.ip;
    if (!ip) {
        for (let item in req.ips) {
            if (item) {
                ip = item;
                break;
            }
        }
        logger.info('req.ips');
        logger.info(JSON.stringify(req.ips));
    }
    return ip;
};
```
这个方案主要是弥补了我单纯使用req.ip获取客户端IP，会存在空的问题。
当然我们也可以设定不信任代理，但是这样子就意味着只获取客户端IP，永远不会知道代理环节的IP，所以代理信任设定，要看实际场景了。


## app.enabled('trust proxy')
当设定了信任代理时，express会获得客户端连接请求中的IP地址。

## req.ip

使用`req.ip`获取请求IP地址，当设定了信任代理时，这个值会是X-Forwarded-For header中的最左边值。
```
req.ip
// => "127.0.0.1"
```
## req.ips
当设定了信任代理时，这个值会是个IP地址数组，req.ips会是这样` ["client", "proxy1", "proxy2"]`

