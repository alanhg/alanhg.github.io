---
title: git常用命令
abbrlink: 423abe9e
date: 2017-05-05 23:22:37
tags:
- git
- command
---
![What is git and why should I use it? - Quora](http://or0g12e5e.bkt.clouddn.com/blog/2017-09-10-161721.jpg)

> 想玩好Github开源项目，不懂git不行，所以这里记录下，在使用中，用到的一些命令，方便自己以后去反复记忆，同时也希望能帮到一些朋友。
主要的命令记住，方便操作，其余的会查询即可。
以实际例子来说明，我在实际使用中用到的一些命令


## Config
```bash
$ git config [--global] user.name "qianghe"
$ git config [--global] user.email "i@xx.x"

```
## Clone

```
# clone仓库
$ git clone -b source git@github.com:heqiang421/heqiang421.github.io.git

```
## Basic Snapshotting

### Add
```
$ git add .

```

## Commit
```
$ git commit -m 'message'
$ git push
```
## Reset

```
# 撤销暂存区提交，回退一个版本
$ git reset HEAD^

```

### rm
```
# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

```
## Branching and Merging

### Branch
```

# 查看本地分支
$ git branch 

# 删除本地分支dev
$ git branch -d dev

# 基于之前的某个 Commit 新开分支
$ git branch <branchName> <sha1-of-commit>

# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]

# 修改对应的远程分支
$ git branch -u origin/dev


```

### Checkout
```
# 切换本地分支
$ git checkout <branchName>

# 切换分支并将远程分支修改为dev
$ git checkout dev --track origin/dev
```

## Sharing and Updating Projects


### pull

```
# 拉取最新代码
$ git pull

```

### push

```
# 删除远程分支
$ git push origin --delete <branchName>

# 推送到主干
$ git push origin <branchName>

```

### remote

```
# 列出远程仓库信息,包括网址
$ git remote -v

# 添加远程仓库
$ git remote add git@github.com:username/repo.git

# 修改远程仓库对应的网址
$ git remote set-url origin git@github.com:username/repo.git

```

## 常见错误

### Git: fatal: Pathspec is in submodule

 解决办法：
 
  ```
   git rm --cached directory
   git add directory
  
  ```

## 辅助资料

+ [常用 Git 命令清单](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)
+ [Git手册](https://git-scm.com/docs)