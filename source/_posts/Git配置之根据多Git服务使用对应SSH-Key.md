---
title: Git配置之根据多Git服务使用对应SSH-Key
abbrlink: 9811465d
date: 2017-06-05 22:52:54
tags:
- Git
- GitHub
- GitLab
---

> 在实际开发中，遇到这样一个问题，公司服务是GitLa，自己的业余项目开发用到了GitHub，两者的账户不同，以我为例，公司邮箱he@company.com，GitHub是个人邮箱he@1991421.cn，我并不想使用同一个Key，希望对于不同的Git服务使用对应的认证信息Key，网上检索后，方法如下。

## 配置步骤

+ 生成SSH-key

```
  cd ~/.ssh/
  # 生成GitHub所需要用的，使用默认名称回车跳过
  $ ssh-keygen -t rsa -C "he@1991421.cn"

  # 生成GitLab公司所需要用的，进行重命名id_rsa_company
  $ ssh-keygen -t rsa -C "he@1991421.cn"
```

这样两者的密钥就是分开生成了,互不冲突

+ 粘贴公钥到对应的平台 
`cat id_rsa.pub`
`cat id_rsa_company.pub`

+ 配置config
执行`touch config`，创建配置文件
将下面的配置粘贴进去

```
# company-GitLab
Host compay.com
IdentityFile ~/.ssh/id_rsa_company
# GitHub
Host *
IdentityFile ~/.ssh/id_rsa
```

​    \*即匹配其它所有

+ 检测是否成功
```
# GitHub
ssh -T git@GitHub.com

# 内网GitLab
ssh -T git@192.168.1.150
```
不报错，说明OK。这样就可以正常的拉取仓库和提交代码了。

## 用户名/邮箱

令牌区分只是解决了认证权限，但本身提交用户名及邮箱却会是默认全局的配置，如果想个性化，需要在仓库下执行以下命令。

```
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"
```

如果想根据不同的类型仓库，比如公司的自动使用一套配置，自己的项目使用另一套呢，这样就不用每次拉取一个仓库都要手动设定一次了。具体如何操作可以[戳这里](https://1991421.cn/2019/07/06/115de663/)



## 常见问题

+ ssh登录，提示权限拒绝
确保密码、配置正确，如果还是提示的话，其实可能性是出在权限上，注意确保`.ssh`文件夹权限，建议直接777