---
title: Jenkins持续集成-war包部署
abbrlink: d703fbc2
date: 2018-03-25 13:50:15
tags:
- DevOps
- Jenkins
---
> JAVA-web开发，如果选择Tomcat容器的话，一般是war包部署

![](http://static.1991421.cn/blog/2018-03-25-061434.jpg)

Jenkins进行war包部署，有两种方案，一是安装[`Deploy to container`](https://plugins.jenkins.io/deploy)插件，另一个是自行写shell脚本解决。我这里选择方案2
原因有两个
1. Jenkins插件本身活跃度低，也就是有任何问题，就束缚住了，目前支持到Tomcat7.x
2. 插件利用Tomcat-manager模块直接部署，性能上我认为不好

so,废话不说开搞！

## war包传输到目标服务器

文件传输，使用`Publish Over SSH`,这里我是传输到`/opt/deploy/war`下

## 编写部署脚本

1. `vi /opt/deploy/deploy.sh`

2. ```bash
    #!/bin/bash
    source /etc/profile
    cd /tmp/deploy/war
    jar -xvf *.war
    rm -f *.war
    \cp -rf * /usr/local/tomcat/webapps/ROOT/
    rm -rf *
    systemctl restart tomcat

    ```
    *注意:*我这里是Centos7.x,所以服务重启用`systemctl`

3. `chmod +x deploy.sh`


## Jenkins构建任务配置

![](http://static.1991421.cn/blog/2018-05-25-035825.png)

## 写在最后
shell编写脚本实现构建的具体执行细节，而Jenkins提供钩子，机制上的支持，这样配合，解决了部署，并且给了很大的自由度。如此一来，我们只需要专注于程序编写，
枯燥的构建，部署工作交给了机器人，我们节约了大量的时间，这就是DevOps的目的。

