---
title: git submodule 使用说明
tags:
  - git
abbrlink: 827afe6e
date: 2017-07-09 22:48:39
---
> Git Submodule允许你将一个Git仓库作为另一个Git仓库的子目录。 它能让你将另一个仓库克隆到自己的项目中，同时还保持提交的独立。
最近在实际项目开发中，用到了，也遇到一些细节问题，所以将Git子模块常用操作总结如下，以备不时之需。

![](http://static.1991421.cn/2019-09-17-143442.jpg)

## 添加子模块

```bash
# 添加子模块
$ git submodule add https://github.com/alanhg/Angular-group.git

# 设定映射路径
$ git submodule add https://github.com/alanhg/Angular-group.git /lib

```

关于具体使用设定下，执行help命令
```bash
$ git submodule --help

```

![](http://static.1991421.cn/2019-09-17-142617.jpg)

## 克隆含有子模块的项目
### 取项目代码
+ 方法1
     1. 克隆项目，子模块目录默认被克隆，但是是空的
       `$ git clone https://github.com/chaconinc/MainProject`
     2. 初始化子模块：初始化本地配置文件
      ` $ git submodule init`
     3. 该项目中抓取所有数据并检出父项目中列出的合适的提交
       `$ git submodule update`
+ 方法2
 `$ git clone --recursive https://github.com/chaconinc/MainProject`

### 更新子模块代码
+ 方法1

	```bash
$ cd DbConnector
$ git fetch
$ git merge origin/master
	```

+ 方法2

	```bash
$ git submodule update --remote DbConnector
# 这里默认更新master分支，如果更新其他分支
$ git config -f .gitmodules submodule.DbConnector.branch stable
$ git submodule update --remote
$ git merge origin/master
	```
### 提交子模块更新

```bash
$ cd DbConnector
$ git checkout stable
$ git submodule update --remote --merge
$ git push
```

## 删除子模块

比如直接删除`.gitmodules`文件是不行的，因为.git中还是会有相关映射记录，so需要执行以下命令才可安全删除。

```bash
# 解除指定的子模块，将从配置文件.git/config中删除
$ git submodule deinit {MOD_NAME}
 
# 删除.gitmodules中记录的模块信息（--cached选项清除.git/modules中的缓存）
$ git rm --cached {MOD_NAME} 
```