---
title: 利用Alfred Workflow，实现一键发布Hexo MD文章到Medium
date: 2020-11-25 23:31:16
tags:
- Alfred
- Workflow
- hexojs
---
> 一直在自己搭建的平台书写博客，但是同时也希望能够同步发布到medium。因为medium的社区用户质量较高，积极参与其中既可以大幅度加强我的博文的热度，同时增加与社区大佬们的交流频次，当然也可以提升我贫乏的外语，好处多多。
> 
> Medium上，一直以来我是人工进行的文章发布，并且WEB编辑页面不直接支持markdown，所以对我来说effort很高，因此也就没怎么发布几篇。随着medium的不算熟悉，了解到medium提供了[API](https://github.com/Medium/medium-api-docs)，同时我又是Alfred深度爱好者，因此绝对造个轮子来做到一键发布。


## 实现说明

- Medium提供了部分API，当前支持直接创建Story，因此可以做到
	
	- API需要的认证信息有两个token及authorid，而authorid是根据token请求获取的，并且唯一不变。因此这里我已经在首次自动请求获取
- Alfred支持file action，可以实现对指定MD文档，实现特定操作
	- Alfred下可以做到利用[脚本化设置全局变量](https://www.deanishe.net/post/2018/10/workflow/environment-variables-in-alfred)，这样即可解决authorid的存储问题，避免二次获取

## 设计

![](https://static.1991421.cn/2020/2020-11-25-235130.jpeg)

如上即为整体design，感兴趣的下载安装后可以查看具体code


## 效果


![](https://static.1991421.cn/2020/2020-11-26-001257.gif)

搜索任何一篇Hexo格式的MD文档，执行该action即可。


## 不足

- 由于Medium的API还是支持的太少，如博客后期文章需要修改，那么就需要人工编辑了，这点只能等待官方API的进一步丰富，比如可以更新指定文章
- Medium官方支持响应很慢，客服邮箱是yourfriends@medium.com，我曾邮件过询问关于API的使用问题，但石沉大海
- Medium国内是被墙的，如果需要正常使用workflow，需要确保终端代理OK
- 因为使用的Node进行的开发，Yarn进行的包管理，因此如果需要使用该workflow，就需要安装Node，Yarn及该workflow目录下，执行yarn install。考虑到使用用户不一定是Node爱好者，这个安装体验需要改进

## 写在最后
- 写这个workflow还是花费了几个小时的，一方面是熟悉MediumAPI，一方面是Alfred Workflow的部分技巧还有盲点，解决完之后也是一种提高，类似问题就没什么effort了。
- workflow的开发解决了个人在同步发表文章到Medium的痛点，正如上文提到，更新文章还需要人工，但至少整个方案是当前条件下的最佳结果了，也算是节约了一部分的体力工作量。

so，继续努力！

## 相关文档
-  https://www.deanishe.net/post/2018/10/workflow/environment-variables-in-alfred
-  https://github.com/Medium/medium-api-docs
