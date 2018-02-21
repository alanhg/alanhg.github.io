---
title: git团队开发流程规范
date: 2018-02-21 14:49:06
tags:
- git
---
> 无规矩不成方圆，良好工具，规范流程，这样才能一定程度的确保开发效率及成果质量,公司正面临svn到git的转换中，在参考一些大厂基于git开发流的规范，进行整合，制定了以下规范。


## 分支命名规则
1. 主分支：`master`
2. 开发分支：`dev`
3. 功能分支：`feature - 分支名称`
4. bug分支修复：`bugfix - issueNumber`

## 操作步骤
1. 管理员`【项目负责人】`创建git仓库，创建dev分支
    ```
    git branch dev
    git push -u origin dev
    
    ```

2. 项目成员clone项目，在本地创建自己的功能分支
    ```
    $ git clone 项目git地址 
    $ git checkout -b dev origin/dev

    # 创建本地功能分支
    $ git checkout -b feature-[name-desc] dev
    
    ```

3. 在自己的分支上进行开发，`git add`,`git commit`等等，注意不要push到远程仓库`origin`

4. 功能完成后，合并到本地的dev分支后，push到远程仓库，合并时很大几率会产生冲突，此时需要merge，merge的时候确保不影响项目其它成员，如果多人操作了同一个类，最好当面确认后进行修改，等合并完成无误后，删除本地开发分支

5. bug修复分支,如果正在开发功能的同事，开发者发现了线上bug,或者未上线的bug，开一个bugfix分支来修复bug

    ```
    $ git checkout -b bugfix-1(bug对应issue号) dev

    $ git checkout dev
    $ git merge bugfix-1

    $ git push
    $ git branch -d bugfix-1
    
    ```