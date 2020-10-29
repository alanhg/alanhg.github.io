---
title: Git log中的父子commit
tags:
  - Git
abbrlink: 398694bb
date: 2020-10-29 15:37:15
---
> 学会看Git log也是一个必备的技能，之前对于Commit中父子关系有所疑惑，这里梳理总结下


![](https://static.1991421.cn/2020/2020-10-29-154033.jpeg)

__如果不存在MR，实际上单个branch下commit是一条线，而因为有了MR，整个commit图谱就会是个树结构。__

## 总结
- 针对一次commit，它创建时基于的commit也就是上次的commit就会是它的parent commit
- 针对一次commit，如果是基于它创建的commit，就会是它的child commit
- 每个commit的`parent commit，child commit都不一定唯一`
	
	如下，该merge提交会有两个parent
	
	![](https://static.1991421.cn/2020/2020-10-29-171017.jpeg)
	
	![](https://static.1991421.cn/2020/2020-10-29-171200.jpeg)


## 写在最后
Git看着简单，但是玩起来还是很讲求技巧的，个人认为最佳的学习姿势是实践中去思考原理性，多总结了。