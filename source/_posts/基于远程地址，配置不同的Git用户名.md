---
title: 基于远程地址，配置不同的Git用户名
tags:
  - Git
abbrlink: 115de663
date: 2019-07-06 22:22:04
---
> 日常混迹GitHub，使用的提交名称是alanhg,工作中是qhe,每次clone下来公司的项目，总是要执行下`git config user.name=qhe`，关键是很多时候还忘了，一看提交记录，名称是alanhg。繁琐至极，有人说，干嘛不`git config --global`?，答案，我不想,我就想分开。

![](http://static.1991421.cn/2019-07-06-030257.png)

这个问题，稍微抽象下，就是基于不同的远程地址，能够自动进行不同的配置

## 可行性分析
行不行，要看Git了，查了下，果然可以。
> With git 2.13 you get a feature called conditional includes

## 实现

- 进入用户文件夹，编辑`.gitconfig`文件

```
[includeIf "gitdir:~/Documents/GitHub/"]
    path = ~/.gitconfig-personal
[includeIf "gitdir:~/Documents/GitLab/"]
    path = ~/.gitconfig-work

[core]
        excludesfile = /Users/qhe/.gitignore_global
[difftool "sourcetree"]
        cmd = opendiff \"$LOCAL\" \"$REMOTE\"
        path =
[mergetool "sourcetree"]
        cmd = /Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"
        trustExitCode = true
```

- 创建 .gitconfig-personal文件

```
[user]
        name = alanhg
        email = qianghe421@aaa.com
```

- 创建 .gitconfig-work文件

```
[user]
        name = qhe
        email = qhe@bbb.com
```

## 效果
当提交GitHub下的项目时，就会走alanhg设定，当提交GitLab下的项目时，就会走qhe设定。假如不这样配，对于同一类项目，就要每次手动执行下git配置用户名，so麻烦。对比，现在这样就一劳永逸了。


## 延伸下
因为有了这个机制，比如公司的项目需要走一些其它Git的特殊设定，均可如此配置。so，如此一来其实解决了一类问题。


