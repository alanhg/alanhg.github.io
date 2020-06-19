---
title: Git常用命令
abbrlink: 423abe9e
date: 2017-05-05 23:22:37
tags:
- Git
---
![What is git and why should I use it? - Quora](https://static.1991421.cn/blog/2017-09-10-161721.jpg)

> 想玩好Github开源项目，不懂Git不行，所以这里记录下，在使用中，用到的一些命令，方便自己以后去反复记忆，同时也希望能帮到一些朋友。
主要的命令记住，方便操作，其余的会查询即可。
以实际例子来说明，我在实际使用中用到的一些命令

## Getting and Creating Projects
```bash
# 创建一个空的Git仓库，或者对于已存在的仓库，进行重初始化
$ git init 

# 配置
$ git config [--global] user.name "alanhg"
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

### Commit
```
$ git commit -m 'message'
$ git push

# 修改最新提交

```
### Reset

```
# 撤销暂存区提交，回退一个版本
$ git reset HEAD^

# 恢复到一个已知状态
# git reset --hard
```

#### rm
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

# 本地分支重命名
$ git branch (-m | -M) [<oldbranch>] <newbranch>


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

# 添加远程仓库,支持多远程仓库地址
$ git remote add [shortname] [url]

# 修改远程仓库对应的网址
$ git remote set-url origin git@github.com:username/repo.git

```

## 常见问题

### Git: fatal: Pathspec is in submodule

 解决办法：
 
  ```
   git rm --cached directory
   git add directory
  ```

### You have not concluded your merge (MERGE_HEAD exists).

```
$ git reset --merge

```
### 每次push都提示输入用户名及密码
![](https://static.1991421.cn/2018-07-07-031614.png)
出现这个的原因是远程库我们是以HTTPS形式设定的，修改为SSH即可
```
# 查看远程库协议
$ git remote -v

$ git remote rm origin 
$ git remote add origin git@github.com:alanhg/alanhg.github.io.git

```

### Pull is not possible because you have unmerged files.
这是因为pull拉取上游新代码时，会进行merge，有未merge的文件就会提示以上信息，要么处理了冲突`git add -u, git commit`,要么放弃本地的文件修改，执行`git reset --hard FETCH_HEAD`

### 分支部分提交导入其他分支
有时我们需要将一个分支的部分提交导入到另一个分支【这些提交在该分支下，可能不见得是最新的紧挨着的几次提交】，这个时候就可以使用cherry pick解决
我们记录下来需要导入的commitID,checkout到目标分支，执行'git cherry-pick commitID'，注意可能会有冲突，跟MR一样处理即可。

注意比如我们想导入N次提交，那么最终cherry pick过来后也会是4次提交。

###   unable to write sha1 filename Permission denied

最近Team使用[Modelio](https://www.modelio.org)编辑的UML，在执行git add 操作即报错。

错误提示为权限问题，so首先想到的方案就是使用管理员运行终端，或者将.git目录下的文件修改权限chmod 777。但这两种办法均没有解决。试了下单个ADD 文件，发现部分行，进而推断应该是部分文件有点特殊，难道是文件在编辑状态的问题？so关闭了正在编辑运行的modelio，果然好使了。

推断是软件编辑文件的情况下，部分文件会被锁住，add操作会导致部分文件修改，而这些文件不可以被编辑，所以就报错了。

### You have unstaged changes
该错误的意思就是有没有commit或者stash的修改，需要做的是git add，commit或者stash这些修改

### Cannot pull with rebase: You have unstaged changes.↵Please commit or stash them.
在执行`git pull --rebase --autostash`时候，报如上错误，原因是有些修改commit或者stash，这样是没办法正常pull代码。

### Git:Merging状态
在IDEA中，比如要合并分支【merge sprint with featue/a】，有时会出现冲突，处理冲突完成后，commit失败，同时分支状态提示为Git:Merging sprit。这时终端执行 `git status`,提示当前状态是`sprint | merge`，这个状态是什么意思呢，其实含义是在MR冲突解决后，`自动commit失败`，这时需要手动进行修改解决，然后重新执行commit，这样状态，提交成功后才会恢复为`sprint`.当然也可以放弃MR`git merge --abort`

### the RSA host key for 'github.com' differs from the key for the IP address
> Warning: the RSA host key for 'github.com' differs from the key for the IP address '198.18.1.89'
Offending key for IP in /Users/xx/.ssh/known_hosts:27
Matching host key in /Users/xx/.ssh/known_hosts:1
Are you sure you want to continue connecting (yes/no)? ^C

提交时，总会提示这样的信息，解决办法是打开known_hosts，将目标行内容删除。重新提交即可。

#### 注意细节

1. MR本身就是一次commit，而commit的作用就是将本地的变动提交到暂存区。
2. MR时的commit失败，只是意味着commit失败，MR代码合并的修改已经完成，这个时候本地根据commit错误进行修改，然后再次进行commit。
3. 一次MR最终成功的标志是MR后的commit提交成功，不包含push，push只是将MR这次的提交推到了上游。
4. commit的message轻易不要修改，因为Git能认识到这是一次MR commit，靠的就是commit message的头部格式。


## 辅助资料

+ [常用 Git 命令清单](http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html)
+ [Git手册](https://git-scm.com/docs)
