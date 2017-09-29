---
title: Xcode simulator使用常见问题
date: 2017-09-29 11:11:51
tags:
- apple
---
> Xcode模拟器使得在没有真机设备的时候方便对APP进行模拟测试，在使用中也会碰到一些问题，这里总结下

+ [模拟器卸载](#模拟器卸载)
+ [模拟器输入法问题](#模拟器输入法问题)

## 模拟器卸载
在xcode-components下可以看到已下载的各个系统版本的模拟器
![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-29-030917.jpg)

比如想删除某个版本的模拟器,直接进入`/Library/Developer/CoreSimulator/Profiles/Runtimes`,删除目标模拟器

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-29-030854.jpg)

然后再进入xcode-components中，会发现目前模拟器已经属于未下载状态

![](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-29-031422.jpg)

## 模拟器输入法问题
利用模拟器进行APP测试时候，发现MAC输入中文，在模拟器中还是英文对待，其实这个时候，就是模拟器系统中的设定问题了。

*模拟器里手机的问题等同于真机A，所以解决方式一样。*

我这里之所以会出现模拟器没有中文，是因为模拟器缺省的模拟设备语言是跟着MAC走的，如果MAC是英文环境，则初始化会是英文的，所以不存在中文键盘，需要自己手动添加下。

`设置->一般->键盘`

