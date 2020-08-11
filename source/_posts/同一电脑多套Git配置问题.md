---
title: 同一电脑多套Git配置问题
tags:
  - Git
  - GitHub
  - GitLab
abbrlink: 4ead3715
date: 2020-08-08 12:01:18
---
> 有时存在这样的需求，GitHub个人项目的提交与GitLab公司项目的提交，我想走不同的Git配置，比如公司项目中，我想使用我的itcode `heqiangx`作为username,但是GitHub我想走个人的英文名字`Alan He`,如何解决呢，这就要做到根据仓库地址不同，自动切换Git配置信息了。

一个个仓库走手动设定？不好意思，我讨厌笨办法。

## ~~.ssh下的config~~

为什么先提到这个文件，因为一开始我认知存在误区，之前为了保证提交不通的仓库服务，我们走不通的令牌就是走的这里的配置，以至于我一开始以为这里配置可以解决。

当然这是错误的，根本问题在于 

> .ssh下的config解决的是认证，git使用的ssh认证，但是比如我的git配置个性化诉求并不是认证问题，而是git的设定问题，所以要走git的配置文件解决。`

## .gitconfig

### 主配置

注意，打开配置文件`路径在`~下`，将以下的部分贴进去即可。保存后，当触发git操作，则会根据仓库所在路径地址走不同的个性化配置。



```
// ...
[includeIf "gitdir:~/Documents/GitHub/"]
    path = ~/.gitconfig-personal
[includeIf "gitdir:~/Documents/GitLab/"]
    path = ~/.gitconfig-work
    
// ...    
```


### 个性化配置

如下即为.gitconfig-personal配置，.gitconfig-work与此类似，只是配置的name,email不同而已。

```
[user]
        name = Alan He
        email = alan@1991421.cn
```


## 注意
如上的解决方案可以一劳永逸，使得不同文件夹下的所有项目走不同的git配置，当然注意，这里的配置叫`全局配置`,如果仓库下有具体的配置，则会覆盖这里的配置。假如你想取消仓库下个性化配置项，走这里，如何做呢。

使用以下命令

```
// 取消当前配置项 user.name
git config --unset user.name

// 列出仓库下当前所有配置项
git config --list

```


## 写在最后
- 单个仓库下个性化git配置毕竟是少数或者没有，比如我，刚需即是公司项目与个人项目走不同配置。
- 如上的解决方案可以使得多套全局配置根据不同的项目类别自动调用不同的配置，因此还是有价值的。
- 当然如果不使用异常的方案，每个项目单独执行配置命令也行，但effort可就不同了，所以手段多样，采用最合适的方案为好。



