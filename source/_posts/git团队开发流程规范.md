---
title: git团队开发流程规范
date: 2018-02-21 14:49:06
tags:
- git
---
> 无规矩不成方圆，良好工具，规范流程，这样才能一定程度的确保开发效率及成果质量,公司正面临svn到git的转换中，在参考一些大厂基于git开发流的规范，进行整合，制定了以下规范。


## 分支命名规则
1. 主分支：`master`【保护分支】
2. 开发分支：`dev`
3. 功能分支：`feature/分支名称`
4. bug分支修复：`hotfix/issueNumber`

## 操作步骤
1. 管理员`【项目负责人】`创建git仓库，创建dev分支
    ```
    git branch dev
    git push -u origin dev
    ```

2. 管理员根据功能拆分，创建对应的功能分支 
    ```
    $ git clone 项目git地址 
    $ git checkout -b dev origin/dev

    # 创建本地功能分支
    $ git checkout -b feature-[name-desc] dev
    
    ```
3. 各个developer，clone指派给自己的分支,在本地进行开发,`git add`,`git commit`等等，push到远程仓库对应分支下。
    **注意:利用fixed #issueNum`语法糖等在提交信息中关联issue,这样MR成功后，issue则会自动关闭，同时方便明确提交CODE关联票**
4. 在多次的提交后，确认完成，则提MR到dev分支
5. 管理员进行Review，合并到dev【可能会有冲突，不清晰点，沟通分支developer】，确认OK后。功能分支关闭且删除
6. CI服务拉取`dev`分支代码进行构建，运行在内网环境，确认OK，且支持上线则合并到`master`主干
7. CI服务拉取`master`主干代码进行构建，运行生产，同时打tag标记
8. 如果在生产中遇到了BUG和新的功能需求，则提对应的issue及创建对应的功能或bug分支，指派开发者。循环上述步骤