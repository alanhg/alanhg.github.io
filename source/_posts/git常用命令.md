---
title: git常用命令
abbrlink: 423abe9e
date: 2017-05-05 23:22:37
tags:
- git
---

> 想玩好Github开源项目，不懂git不行，所以这里记录下，在使用中，用到的一些命令，方便自己以后去反复记忆，同时也希望能帮到一些朋友。
主要的命令记住，方便操作，其余的会查询即可。
以实际例子来说明，我在实际使用中用到的一些命令

## 配置
```bash
$ git config [--global] user.name "qianghe"
$ git config [--global] user.email "i@xx.x"

```
## 新建仓库

```
# clone仓库
$ git clone -b source git@github.com:heqiang421/heqiang421.github.io.git

```
## 分支
```

# 查看本地分支
$ git branch 

# 删除本地分支dev
$ git branch -d dev

# 切换本地分支
$ git checkout <branchName>

# 基于之前的某个 Commit 新开分支
$ git branch <branchName> <sha1-of-commit>

$ git status

# 添加当前目录的所有文件到暂存区
$ git add .

```

## 提交
```
$ git commit -m 'message'
$ git push
```
## 更新
```
$ git pull

# 停止追踪指定文件，但该文件会保留在工作区
$ git rm --cached [file]

# 删除工作区文件，并且将这次删除放入暂存区
$ git rm [file1] [file2] ...

# 列出远程仓库信息,包括网址
$ git remote -v

# 修改远程仓库对应的网址
$ git remote set-url origin git@github.com:username/repo.git

# 建立追踪关系，在现有分支与指定的远程分支之间
$ git branch --set-upstream [branch] [remote-branch]

# 删除远程分支
$ git push origin --delete <branchName>

# 推送到主干
$ git push origin <branchName>

# 修改对应的远程分支
$ git branch -u origin/dev

```

## 撤销

```
# 撤销暂存区提交，回退一个版本
$ git reset HEAD^

```

# 常见错误
## Git: fatal: Pathspec is in submodule
 解决办法：
  ```
   git rm --cached directory
   git add directory
  
  ```


# 辅助资料

+ [常用 Git 命令清单](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)
+ [Git手册](https://git-scm.com/docs)