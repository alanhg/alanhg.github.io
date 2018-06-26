---
title: Angular5升级至6
abbrlink: 682d106
date: 2018-05-05 23:33:16
tags:
- Angular5
- Angular6
---
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-06-022853.jpg)

> Angular 6.0.0已正式发布，开心，当然这已逾期一个月，开源项目似乎好多都如此，比如ionicv4，so,理解下。
之前了解过v6,据说，体积，性能及功能都有提升，所以便快速跟进了下，这里粗略记录。

## 升级项目
具体升级在官网建议获取指南，[https://update.angular.io/](https://update.angular.io/)

以下为我的项目升级前后包版本变化对比

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-05-154225.png)

## 注意事项
实际升级并不只是package几个版本的改动，注意因为rxjs6变化较大，废除了一些操作符，所以关于rxjs要走官方升级工具来做省事些。

```
$ npm install -g rxjs-tslint
$ rxjs-5-to-6-migrate -p src/tsconfig.app.json
```
但是比如执行上述成功后，实际上还是有部分代码需要我们手动自己去修改，否则就会报错比如这里的一个操作符修改。
```
Property 'map' does not exist on type 'Observable<Response>'
```
![](http://or0g12e5e.bkt.clouddn.com/2018-06-26-052755.png)
![](http://or0g12e5e.bkt.clouddn.com/2018-06-26-061753.png)

升级成功后，对打包速度，打包体积及WEB运行性能进行了对比，情况如下

## 体积,打包速度

![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-05-153831.png)

## 性能
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-05-05-154001.png)

## 写在最后
对比发现体积上的确是比原来小了些，但并不多，大小减小在10%以内，当然不同项目依赖不同会有出入。打包速度上，我这里似乎还慢了。。。性能上可以看出加载速度及脚本执行速度有些许提升。
总之都不明显。。。

当然这些都建立在还没有开启`ivy`,这个缺省是不开启的，期待Angular及相关三方组件再发展一段时间，再搞，建议现在别玩ivy，还早。