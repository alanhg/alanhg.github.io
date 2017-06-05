---
title: 同一电脑github与gitlab共存问题
abbrlink: 9811465d
date: 2017-06-05 22:52:54
tags:
- git
- github
- gitlab
---
## 问题描述
在实际开发中，遇到这样一个问题，公司项目管理用到了`gitlab`，自己的业余项目开发用到了`github`，但两者的账户是不同的，以我为例，`gitlab`是公司邮箱`he@company.com`，`github`是个人邮箱`he@1991421.cn`这样就存在冲突问题，在网上检索后，总结下解决方法。

## 解决步骤

+ 生成SSH-key
  ```
  cd ~/.ssh/
  # 生成github所需要用的，使用默认名称回车跳过
  $ ssh-keygen -t rsa -C "he@1991421.cn"

  # 生成gitlab公司所需要用的，进行重命名id_rsa_company
  $ ssh-keygen -t rsa -C "he@1991421.cn"

 ```
 这样两者的密钥就是分开生成了 互不冲突

+ 粘贴公钥到对应的平台 
`cat id_rsa.pub`
`cat id_rsa_company.pub`

+ 配置config
执行`touch config`，创建配置文件
将下面的配置粘贴进去
```
# company-gitlab
Host 192.168.1.140
HostName 192.168.1.140
IdentityFile ~/.ssh/id_rsa_company
# github
Host github
HostName github.com
IdentityFile ~/.ssh/id_rsa
```

+ 检测是否成功
```
# github
ssh -T git@github.com

# 内网gitlab
ssh -T git@192.168.1.150
```
不报错，说明OK。这样就可以正常的取仓库代码和提交代码了。

## 注意细节

由于git全局我配置的是我github的用户名和邮箱，所以在我git clone了gitlab仓库时，还需要在仓库根目录下进行下用户名和邮箱配置。
不然提交上的记录显示的会是github的信息。
相关命令如下
```
$ git config [--global] user.name "[name]"
$ git config [--global] user.email "[email address]"

```