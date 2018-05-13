---
title: Git团队开发流程规范
tags:
  - Git
abbrlink: af0e83fe
date: 2018-02-21 14:49:06
---
> 无规矩不成方圆，良好工具，规范流程，这样才能一定程度的确保开发效率及成果质量,公司正面临SVN到Git的转换中，在参考一些大厂基于Git开发流的规范，进行整合，制定了以下规范。


## 分支命名规则
1. 主分支：`master`【保护分支】
2. 开发分支：`dev`【保护分支】
3. 功能分支：`feature/分支名称`
4. bug分支修复：`hotfix/issueNumber`

## 操作步骤

1.  管理员`【项目负责人】`创建Git仓库，创建dev分支
    ```
    $ git clone https://github.com/alanhg/alanhg.github.io.git
    $ git checkout -b dev
    $ git push
    ```

2.  管理员根据功能拆分，基于dev分支，创建对应的issue，指派developer
3.  各个developer，clone仓库，基于dev创建功能分支,本地进行开发,`git add`,`git commit`等，push到远程仓库，创建对应上游分支。
    
    **_注意:_利用fixed #issueNum`语法糖等在提交信息中关联issue,这样MR成功后，issue则会自动关闭，同时方便明确提交CODE关联票**

    ```
    $ git checkout dev
    $ git pull 
    $ git checkout -b feature/login
    
    ```
4.  在多次的提交后，确认完成，则提MR到dev分支，
5.  管理员进行Review，可能会有冲突，不清晰点，沟通分支developer，，确认OK后合并到dev。原功能分支关闭且删除
6.  CI服务拉取`dev`分支代码进行构建，运行在内网环境，确认OK，且支持上线则合并到`master`主干
7.  CI服务拉取`master`主干代码进行构建，部署到生产，同时打tag标记
8.  如果在生产中遇到了BUG和新的功能需求，则创建对应的issue及创建对应的功能或bug分支，指派开发者。循环上述步骤
    
    ```
    $ git checkout -b hotfix/1 dev

    ```
    
## 说明
+ 因为分支为各个developer在本地创建，最终push到上游，命名按照上述规则，则不会存在分支命名重复冲突
+ 构建发版，会自动统计整体提交的修改点，所以准确填写commit-message描述信息显得尤为重要