---
title: rsync total size is 0 speedup is 0.00
tags:
  - Linux
  - CD
  - GitHub
abbrlink: 2dbb2dc1
date: 2020-12-01 11:54:36
---

> 最近在使用GitHub Actions实现自动部署静态网页到VPS时，遇到问题，即同步文件只有文件，内容为空，万脸懵逼，于是开始排查问题原因。


## 具体问题

执行的命令如下

```shell

$ rsync -zvr -e ssh public root@1991421.cn:/var/www/blog

```

同步结束



![](https://static.1991421.cn/2020/2020-12-01-120002.jpeg)


rsync total size is 0 speedup is 0.00

登录VPS，查看文件，内容均是空

![](https://static.1991421.cn/2020/2020-12-01-120023.jpeg)

切换到使用SCP
　
```
$ scp -r public root@1991421.cn:/var/www/blog/public
```


结果依然悲惨，内容为空


## 排查
- [x]scp,rsync均不行,说明不是命令问题
- [x]SSH Key如果不正确，不应该是这种报错
- [x]部署系统直接指定MacOS也不行

以上三种尝试后还是没有解决，继续万脸懵逼。

当然既然本地可以，CD服务器不行，还是两者在构建发版上的差异造成的，这点依然很确定。

继续，Google了好多资料还是鲜有`total size is 0  speedup is 0.00`的资料，于是去GitHub上找作者询问了下。

作者一针见血的回复让我明白了问题的关键。

![](https://static.1991421.cn/2020/2020-12-01-120051.jpeg)


作者的意思即是速度为0，就可以说明本身文件就没内容。一句话点醒了我。重新分析，发现了一个之前忽视的差异，本地我的Node使用的v10,而CD上是14.x。因此，如果是Node的版本差异造成了Hexo在生成静态资源时出了问题呢。


切换了版本重新部署，OK了。


![](https://static.1991421.cn/2020/2020-12-01-120106.jpeg)


### 总结

Hexojs是基于NodeJS的静态博客框架，因此强依赖NodeJS，版本问题就需要格外注意。



## 写在最后

1. 整个排查过程中，还是低效了些，关键在于一开始没有将Node的版本统一，自己给自己埋了一个雷。
2. 经过这个问题，rsync又多了一点了解，比如再看到速度为0时，至少知道排查方向
3. 博客切换到使用GitHub Actions部署后，对比速度确实比Travis快，以后部署更高效了。

