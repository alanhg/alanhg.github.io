---
title: Jenkins持续部署-邮件通知ChangeLog
tags:
  - Jenkins
  - CD
abbrlink: '77734821'
date: 2020-10-02 14:31:08
---
> 为了生产发版后，能够及时的通知BA，Dev同学，趁着周末，研究了会儿Jenkins，这里简单Mark下。

## 安装配置

### Plugin Manager
自带的mail过于简单，为了实现邮件模版自定义，需安装以下插件

- [Email Extension Plugin](https://plugins.jenkins.io/email-ext/)
- [Config File Provider](https://plugins.jenkins.io/config-file-provider/)

### Jenkins Configuration
Extension插件与自带的mail插件不同，需单独配置邮箱服务器

![](https://static.1991421.cn/2020/2020-10-02-143406.jpeg)

### 模版创建
除了直接登陆Jenkins部署服务器进行文件操作之外，可以直接GUI进行操作，这里我选择的GUI

Managed files => Add a new Config => Extended Email Publisher Groovy Template

![](https://static.1991421.cn/2020/2020-10-02-143643.jpeg)

注意

- 这个配置会在服务根目录下，使用时直接 'groovy-html.template'即可
- 这里我选择的模版基于是官方插件提供的改造的，插件模版默认不安装，所以需要手动配置，
	- 插件模版下载[戳这里](https://github.com/jenkinsci/email-ext-plugin/tree/master/docs/templates)
	- 我改进后的模版-发送Git ChangeLog[戳这里](https://gist.github.com/alanhg/b577d5a30ae5b16e9404cdf6624895b3)

### pipeline配置


```groovy
properties([buildDiscarder(logRotator(artifactNumToKeepStr: '10', numToKeepStr: '10'))])
node() {
 try {
       currentBuild.result = 'SUCCESS'
 }
    catch (err) {
     currentBuild.result = 'FAILURE'
    }
 finally {

     stage ('Notify') {
      emailext to: 'alan@1991421.cn',
      subject: "Production deployment: ${currentBuild.fullDisplayName} ${currentBuild.result}",
      body: '''${SCRIPT,template="managed:groovy-html.template"}'''
      mimeType: 'text/html'
      }
  }
 }
            
```

#### 注意
1. try catch在最外围
2. mimeType建议明确指定，在有些版本下会造成邮件发出后是HTML文本，没有正确渲染

## 效果

如下即最终发出的邮件

![](https://static.1991421.cn/2020/2020-10-02-145255.jpeg)

- 要知道即使最终提示发布成功，但是假如是Java服务，实际上容器的启动也需要时间，根据具体的容器服务配置不同，生效延迟会有所不同。所以严格来说邮件通知成功，并不一定意味着最终真的`同时刻生效上线`


## 写在最后

- 个人觉得Jenkins及周边插件的文档写的很一般，相比较而言，查看实战类的书，比看官方文档及Google更为高效些
- 推荐我正在看的这本书[《Jenkins 2: Up and Running》](https://learning.oreilly.com/library/view/jenkins-2-up/9781491979587/ch04.html#CH_Notifications_and_Reports)

## 参考文档
- [Jenkins 2: Up and Running](https://learning.oreilly.com/library/view/jenkins-2-up/9781491979587/ch04.html#CH_Notifications_and_Reports)
- [email-ext-plugin](https://github.com/jenkinsci/email-ext-plugin)
