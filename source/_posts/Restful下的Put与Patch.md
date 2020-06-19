---
title: Restful下的Put与Patch
tags:
  - RESTful
abbrlink: 82e1b49c
date: 2019-12-29 22:50:53
---
> Team在制定API时，有时很纠结要不要区分Put与Patch。既然纠结，那就搞明白。

![](https://static.1991421.cn/2019-12-29-142044.jpg)

图片源自[这里](https://blog.eq8.eu/article/put-vs-patch.html)

## Put VS Patch

### Put
全量更新某资源

>   The PUT method requests that the enclosed entity be stored under the
   supplied Request-URI. If the Request-URI refers to an already
   existing resource, the enclosed entity SHOULD be considered as a
   modified version of the one residing on the origin server. If the
   Request-URI does not point to an existing resource, and that URI is
   capable of being defined as a new resource by the requesting user
   agent, the origin server can create the resource with that URI. If a
   new resource is created, the origin server MUST inform the user agent
   via the 201 (Created) response.  If an existing resource is modified,
   either the 200 (OK) or 204 (No Content) response codes SHOULD be sent
   to indicate successful completion of the request. If the resource
   could not be created or modified with the Request-URI, an appropriate
   error response SHOULD be given that reflects the nature of the
   problem. The recipient of the entity MUST NOT ignore any Content-*
   (e.g. Content-Range) headers that it does not understand or implement
   and MUST return a 501 (Not Implemented) response in such cases.

### Patch
局部更新记录某资源字段

>
 The PATCH method is similar to PUT except that the entity contains a
   list of differences between the original version of the resource
   identified by the Request-URI and the desired content of the resource
   after the PATCH action has been applied. The list of differences is
   in a format defined by the media type of the entity (e.g.,
   "application/diff") and MUST include sufficient information to allow
   the server to recreate the changes necessary to convert the original
   version of the resource to the desired version.


要知道，Patch是`HTTP1.1版`新加入的。

HTTP1.1协议全文[戳这里](https://tools.ietf.org/html/rfc2068)

### 举个例子

```
PUT /users/:id
{
username:'',
nickname:'',
sex:'male',
age:11,
address:'xxxx'
}
```

```
PATCH /users/:id/address
{
address:'xxxx'
}

```

## 区分的必要性

假如不使用patch，都使用Put来实现记录更新，肯定可以做到。但有问题

### 更新address

两个办法

第一：使用/users/:id，也就是说我们全量信息提交，这么来做弊端明显，场景上如果就是只更新address,我们传输了很多根本用不上的信息即冗余信息，如果记录全量信息的构造十分复杂，这种弊端就更为明显。

第二：增加新的接口，比如/users/:id/address，我们只传address,后台服务处理上单独更新该字段。

对比似乎，第二个好些，同时我们将方法改为patch，更为规范化，从HTTP Method层面标明了这是局部更新。

似乎不错，但问题来了

### 更新两个字段【nickname，sex】？

首先路径上似乎无法定为/users/:id/address，干脆改为

```
PATCH /users/:id/address
{
nickname:'xxxx',
sex:female
}
```
似乎还是可以满足要求的，但问题来了

### 任意字段更新？

首先这点可以做到，大致的原理应该是后端解析到请求体后，使用BeanUtils的方法，循环更新到记录实体上。但这么做存在安全性隐患，毕竟不应该是任意字段可以更新。后端应该需要做个简单的字段合法性check，比如ID字段之类的，不应该被更新。


## 写在最后

PATCH与PUT更多是规范上的不同，无论是前端的axios,还是后端的spring，都已经支持了Patch，所以我们应该根据实际的场景，按需使用。

规范是前人从坑中走出来的经验，我们需要认真对待，这点没商量。

## 参考资料

- [RESTful API 最佳实践](http://www.ruanyifeng.com/blog/2018/10/restful-api-best-practices.html)
- [REST Resource Naming Guide](https://restfulapi.net/resource-naming/)
- [正确使用Patch——部分更新](https://www.jianshu.com/p/603158e777df)
- [HTTP1.1协议标准](https://tools.ietf.org/html/rfc2068)








