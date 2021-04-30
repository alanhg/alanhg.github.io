---
title: Jenkins持续集成-发布NPM新包
tags:
  - Node
  - NPM
  - Jenkins
abbrlink: 527335fa
date: 2021-01-07 14:54:19
---

> 最近有需求需要Jenkins实现发布NPM新包，这里记录下配置方法。



## 具体需求

- 执行release命令，生成新版本号及changelog记录

- 提交修改后的package.json，changelog到GitLab仓库

- 打包新版本到私服Nexus

## Jenkins插件安装

为实现该功能，需要确保安装以下3个插件

- [NodeJS](https://plugins.jenkins.io/nodejs/)

- [SSH Agent](https://plugins.jenkins.io/ssh-agent/)

- [Config File Provider](https://plugins.jenkins.io/config-file-provider/)

  

## 环境配置

1. 安装NodeJS
   - Global Tool Configuration中安装指定NodeJS，全局包安装yarn
2. 配置文件增加NRM配置
   - Managed Files选择Npm config file，注意auth config，确保可以deploy包到服务器
3. GitLab credentialsId
   - Global credentials配置GitLab账户私钥

## Pipeline配置

```groovy

node() {

nodejs(nodeJSInstallationName: "nodejs_v10.16.0", configId: "96de5baa-02b1-4cb9-9f65-e8f96452b59c") {

stage("checkout") {
checkout([$class: 'GitSCM', branches: [
[name: 'master']
], userRemoteConfigs: [
[credentialsId: 'gitlab', url: 'git@gitlab.1991421.cn:personal/hello-web.git']
]])
}


stage("release lib") {
sshagent( ['gitlab']) {
sh '''
    git config --global user.email "alan@1991421.cn"
    git config --global user.name "Alan's 2st Bot"
		yarn install
		npm run release
		git push origin HEAD:refs/heads/master --tags
'''
}
}

}

}

```



[文件下载]([**jenkins-release-npm.groovy**](https://gist.github.com/alanhg/fcdf6daeb9ded0e5427578f5aafdf023#file-jenkins-release-npm-groovy))

### 字段值说明

- `nodeJSInstallationName`为Global Tool Configuration-NodeJS中指定版本name
- `nodejs configId`为Config File Management中npmrc文件ID
- `userRemoteConfigs credentialsId`为Credentials中Git仓库私有令牌ID



### 注意

- push到上游时增加`--tags`有两个原因
  - release命令的背后是用`standard-version`进行版本管理，生成ChangeLog时需要基于Tag，否则出现ChangeLog中重复显示commit问题
  - Tag充当版本快照，有益于版本管理，和问题修复
- 这里未考虑npm包缓存化，建议有时间了，优化该点，否则每次重新安装第三方稳定版本包，浪费资源

## 写在最后

- 一直觉得，Jenkins文档，插件都是参差不齐，但同时因为Jenkins确实设计的合理巧妙，依然也算是CI/CD的主流工具，真是哭笑不得。实际实现上述需求时，还是踩了些坑，因此这里Mark下，留作备忘
- 如上配置后，对于包的版本管理相当于交付给了Jenkins来自动化，对于开发来说只需要按照规范进行提交feat，fix等即可
