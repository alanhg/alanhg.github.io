---
title: Jenkins持续集成-搭建配置
tags:
  - Jenkins
  - DevOps
abbrlink: '43304124'
date: 2017-12-30 13:44:20
---
> 在实际项目开发及运维，使我深刻的意识到持续集成化的引入是多么的重要，于是，在了解持续集成思想及Jenkins工具后，决定开始搭建系统，从而填补这块的缺失，进而提升开发效率。
废话不了，直接上干货。

## JAVA安装

`Jenkins`是由JAVA编写的自动化服务器软件，所以我们需要先安装`JAVA`.

### 下载JDK
http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

下载`jdk-8u152-linux-x64.tar.gz`包

![](//static.1991421.cn/blog/2017-12-30-063142.png)

### 安装

进入服务器`/usr/local`，创建java文件夹，将包丢进入，解压

`tar -zxvf jdk-8u152-linux-x64.tar.gz`

### 环境变量配置

`vi /etc/profile`
```
JAVA_HOME=/usr/local/java/jdk1.8.0_152
CLASSPATH=.:$JAVA_HOME/lib.tools.jar
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME CLASSPATH PATH

```

## Tomcat安装

下载gz包，进入`/usr/local`,创建Tomcat文件夹，将包丢进去，解压

`tar -xzvf apache-tomcat-9.0.2.tar.gz`

![](//static.1991421.cn/blog/2017-12-30-063233.png)

### Tomcat服务化

由于不是通过`yum`包管理器安装，所以还不是服务化，实际生产需要服务化，并实现自启动，所以这里需要手动配置下

修改/usr/local/tomcat/apache-tomcat-9.0.2/bin目录下的catalina.sh文件，添加`JAVAHOME`和`CATALINA_HOME`


拷贝文件至/etc/init.d目录下，并且重命名为Tomcat

`sudo cp /usr/local/tomcat/apache-tomcat-9.0.2/bin/catalina.sh /etc/init.d/tomcat`

#### 自启动

`sudo chkconfig –add tomcat`


## 部署Jenkins

### 下载WAR包

下载地址:[点击这里](https://jenkins.io/download/)

### 解压
将Jenkins.war包丢入`/usr/local/tomcat/apache-tomcat-9.0.2/webapps`

### 重启Tomcat

`service tomcat restart`

### WEB访问

http://192.168.1.81/jenkins/


### 安装必要插件

由于我这里是想与GitLab结合，所以安装的插件如下

1. Email Extension Plugin `邮件功能`
2. GitLab Plugin `GitLab相关配置`
3. Publish Over SSH `SSH连接Linux服务器`
4. NodeJS Plugin `NodeJs版本管理`

## 创建任务
具体任务配置，其实根据实际需求，会有很多的细节点，这里只粗略介绍下，我的配置。

### 源码管理

源码管理选择Git,下面的认证信息是我专门再GitLab上创建的CI账户，由于我是内网测试部署，所以构建分支是dev分支。
![](//static.1991421.cn/blog/2018-01-20-061636.png)

### 构建触发器
注意这里，我选的是GitLab-push触发构建，也就是GitLab的Webhook,这里的地址，要在对应的GitLab仓库下进行配置

![](//static.1991421.cn/blog/2018-01-20-061800.png)

![](//static.1991421.cn/blog/2018-01-20-062038.png)

配置钩子后，点击测试，确认OK

![](//static.1991421.cn/blog/2018-01-20-062114.png)


### 构建环境
我这里是前端Node构建，所以选择对应需要的Node版本

![](//static.1991421.cn/blog/2018-01-20-062158.png)

### 构建
我这里是先执行安装类包和构建打包，然后通过SSH传输到测试服务器的目标路径下

![](//static.1991421.cn/blog/2018-01-20-062249.png)

### 构建后
实现邮件发送
![](//static.1991421.cn/blog/2018-01-20-062524.png)


## 写在最后

![](//static.1991421.cn/blog/2018-01-20-064519.png)

上述讲述的只是一部分，持续集成是个持续推进的事，是个理念，更多的需要根据实际情况去调整，配置。之前看过一篇文章讲述的非常好，固化的步骤，尽可能的交与程序去做，这样更为高效，也更为安全，人工必有失误。

之前参加过DevOps会议，总算迈出了第一步。





