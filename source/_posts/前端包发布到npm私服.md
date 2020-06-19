---
title: 前端包发布到npm私服
tags:
  - Nexus
  - Npm
abbrlink: '68614738'
date: 2019-11-17 18:34:18
---
> 之前Team一直以`Git Submodule`的形式共享前端基础模块资源，但存在弊端，于是趁着周末研究下Nexus npm，将前端资源切换到npm形式进行维护管理

![](https://static.1991421.cn/2019-11-17-102918.png)

## Git Submodule的弊端

> 首先说下使用GitSubmosule形式共享前端包的弊端。

1. 版本管理依赖于commitId，submodule虽然也有分支的概念，但本质依赖于commitID，假如本身的文件存储的就是某个仓库及某次commit。假如在MR代码时，版本不一致，单从这个hash值上，并不知道版本之间，谁是新的。相较npm package的大小版本号就更为浅显易懂些。

2. 子模块的管理方式是将模块的代码全盘拉下，比如UT也会拉下，其实是多余的。
3. 子模块代码在项目中非只读，容易被修改，我希望的是代码保护，只有只读权限


so，决定改为npm包管理方式。目前公司搭建有nexus私服，so这里介绍下如何发布包。

## Nexus私服部署
因为之前没有了解过Nexus，这里本地部署下

```
docker run -d --restart=unless-stopped  --name nexus -p 8081:8081 -p 5000:5000 -p 5001:5001 -p 5002:5002 -p 5003:5003 -p 5004:5004 --ulimit nofile=90000:90000 -e INSTALL4J_ADD_VM_PARAMS="-Xms2g -Xmx2g" -v /nexus-data:/nexus-data sonatype/nexus3
```

![](https://static.1991421.cn/2019-11-17-101732.png)

### 配置
1. 添加三个仓库hosted,proxy, group，其中group仓库中中将hosted和proxy拖拽进去。

	- group 指的是仓库组，可以包括hosted 和proxy的仓库。
	- hosted 指的是自己的私有仓库，可以上传私有代码到上面。
	- proxy 指的是代理镜像仓库，比如我们常用的antd，angular等第三方类库。

	![](https://static.1991421.cn/2019-11-17-101653.png)

	![](https://static.1991421.cn/2019-11-17-101807.png)

2. Realms中添加npm Bearer Token Realm

## 前端包配置

### package.json


```
 "publishConfig": {
    "registry": "http://localhost:8081/repository/npm-company/"
  },
```

注意是仓库为npm-company即hosted仓库

### .npmrc

```
# auth config
_auth=YWRtaW46YWRtaW4xMjM
always-auth=true
email=hi@1991421.cn

```
注意: _auth为`user:password的base64编码结果`，该配置解决的是免密发布，但并不是最佳方案，因为每个人都可以发版是危险的，相对好的方式是CI服务器在合并代码之后自动发版或者手动触发发版。

[Base64在线编辑](https://tool.chinaz.com/tools/base64.aspx)

### 发布

```
$ npm publish

```
![](https://static.1991421.cn/2019-11-17-102742.png)

### 包的使用

在具体开发项目中，的.npmrc文件，增加如下配置

```
registry=http://localhost:8081/repository/npm/

```
注意，仓库为npm即group仓库

## 常见错误

### Unable to authenticate, need: BASIC realm="Sonatype Nexus Repository Manager"

```
npm ERR! code E401
npm ERR! Unable to authenticate, need: BASIC realm="Sonatype Nexus Repository Manager"

```

出现这个错，一般是源不对，注意上面的registry


执行`npm i alanhg-demo@0.3.0 --save`

### 401 or 404

假如将npmrc切换为yarnrc,在执行yarn install安装包时，nexus上的私有包会安装失败，报401或者404错，原因应该是yarn与nexus私服之间的支持存在问题，当前的解决方案是使用npmrc管理私有注册源

![](https://i.imgur.com/5yCXF6P.png)


### Failed to stream response due to: Missing blob and no handler set to recover.".

最近执行安包命令,报以下错误

```
yarn install v1.22.4
[1/5] 🔍  Validating package.json...
[2/5] 🔍  Resolving packages...
error An unexpected error occurred: "https://nexus.xxxcn/repository/npm/@alanhg%2fui: Failed to stream response due to: Missing blob and no handler set to recover.".
info If you think this is a bug, please open a bug report with the information provided in "/Users/qhe/Documents/GitLab/xxx/yarn-error.log".
info Visit https://yarnpkg.com/en/docs/cli/install for documentation about this ⌘.

```

解决办法是，登陆nexus私服，点击invalidate cache

![](https://static.1991421.cn/2020/2020-04-08-235616.png)



## 写在最后

这里只是搭建了机制,解决了使用和维护上的问题，但另一个重要的问题是包的版本变迁，包的历史，假如还是万年不变的版本号，又或者很随意的版本号变迁，  
每次变动的点也没有系统的说明和记录，那么仍旧是一盘散沙，我们仍然无法安全放心的使用包。于是，我们还需要借助其它的工具去做好提交信息及项目版本的管理。哭，解决一个问题，进而会发现新的问题，别怕，继续闹！

## 参考文档

- [npm 发布包填坑指南](https://my.oschina.net/dkvirus/blog/1526525)
