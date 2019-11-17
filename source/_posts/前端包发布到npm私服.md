---
title: 前端包发布到npm私服
tags:
  - Nexus
  - Npm
abbrlink: '68614738'
date: 2019-11-17 18:34:18
---
> 之前Team一直以Git Submodule的形式共享前端基础模块资源，但存在弊端，于是趁着周末研究下Nexus npm，将前端资源切换到npm形式进行维护管理

![](http://static.1991421.cn/2019-11-17-102918.png)

## Git Submodule的弊端

> 首先说下使用GitSubmosule形式共享前端包的弊端。

1. 版本管理依赖于commitId，submodule虽然也有分支的概念，但本质依赖于commitID，假如本身的文件存储的就是某个仓库及某次commit。假如在MR代码时，版本不一致，单从这个hash值上，并不知道版本之间，谁是新的。相较npm package的大小版本号就更为浅显易懂些。

2. 子模块的管理方式是将模块的代码全盘拉下，比如UT也会拉下，其实是多余的。
3. 子模块代码在项目中非只读，容易被修改，本身不利于开发维护


so，决定改为npm包管理方式。目前公司搭建有nexus私服，so这里介绍下如何发布包。

## Nexus私服部署
之前没有了解过Nexus，这里docker本地部署下

```
docker run -d --restart=unless-stopped  --name nexus -p 8081:8081 -p 5000:5000 -p 5001:5001 -p 5002:5002 -p 5003:5003 -p 5004:5004 --ulimit nofile=90000:90000 -e INSTALL4J_ADD_VM_PARAMS="-Xms2g -Xmx2g" -v /nexus-data:/nexus-data sonatype/nexus3
```

![](http://static.1991421.cn/2019-11-17-101732.png)

### 配置
1. 添加三个仓库hosted,proxy, group，其中group仓库中中将hosted和proxy拖拽进去。

	- group 指的是仓库组，可以包括hosted 和proxy的仓库。
	- hosted 指的是自己的私有仓库，可以上传私有代码到上面。
	- proxy 指的是代理镜像仓库，比如我们常用的antd，angular等第三方类库。

	![](http://static.1991421.cn/2019-11-17-101653.png)

	![](http://static.1991421.cn/2019-11-17-101807.png)

2. Realms中添加npm Bearer Token Realm

## 前端包配置

### packgae.json


```
 "publishConfig": {
    "registry": "http://localhost:8081/repository/npm-company/"
  },
```

注意是仓库为npm-company即hosted

### .npmrc

```
registry=http://localhost:8081/repository/npm/

```
注意是仓库为npm即group

### 发布

```
$ npm login --registry=http://localhost:8081/repository/npm-company/
$ npm publish

```
![](http://static.1991421.cn/2019-11-17-102742.png)

###报错

```
npm ERR! code E401
npm ERR! Unable to authenticate, need: BASIC realm="Sonatype Nexus Repository Manager"

```

出现这个错，一般是源不对，注意上面的registry

## 包的使用
在项目根路径下创建.npmrc

```
registry=http://localhost:8081/repository/npm
```

执行`npm i alanhg-demo@0.3.0 --save`

## 写在最后
搭建私服一方面是为了安全，一方面是共享了资源。so值得去做。
