---
title: Postman搭建mock server
tags:
  - postman
  - mock
  - 软件技巧
abbrlink: 74fadb6c
date: 2018-07-29 17:11:53
---
> mock这词其中一个意思是模仿。在进行前端开发的时候，为了不依赖后端的进度，我们可以根据既定的API规范，搭建mock server，这样可以独立进行开发。等后端开发完毕，只是需要将请求地址由mock请求地址修改为后端服务地址既可。
postman是个厉害的API工具，除了可以调试API之外，也支持创建mock服务。最近因为在做前端开发，利用postman搭建了mock服务，这里记录下。

postman下载地址-[戳这里](https://www.getpostman.com/)
## 创建mock server
![](http://or0g12e5e.bkt.clouddn.com/2018-07-29-D415CB6C-08B1-4AEE-8D98-4C34C541BC86.png)
![](http://or0g12e5e.bkt.clouddn.com/2018-07-29-204F66CA-5D9B-4447-B147-04A9F70A7751.png)
respone body中填写返回结果(创建成功后，也支持修改)
![](http://or0g12e5e.bkt.clouddn.com/2018-07-29-DD9DBC85-A328-406C-BEF3-9EA7A6FA027D.png)

点击关闭，点击单个请求发送，我们会看到返回结果集。
mock服务创建成功之后，也会给我们提供请求的完整地址，鼠标移动到地址栏${{url}}上即可查看。

### 增加请求
![](http://or0g12e5e.bkt.clouddn.com/2018-07-29-093439.png)
save保存到我们刚才创建的mock collection下。返回结果添加与下面的修改请求结果实例类似操作。
### 修改请求结果实例
点击例子，点击默认例子，即可修改，save即可。
![](http://or0g12e5e.bkt.clouddn.com/2018-07-29-092255.png)

## 在线mock服务推荐
除了postman客户端搭建mock之外，也有在线mock服务，最近使用[easy-mock](https://www.easy-mock.com/)，觉得还不错，这里贴下，有其它好的mock服务，也欢迎留言推荐给我。
本地与在线mock各有优缺点，大家自行选择合适的吧。
