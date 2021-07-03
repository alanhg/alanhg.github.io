---
title: GitHub Action实践-更新workflow badge
date: 2021-07-03 12:56:20
tags:
- Alfred Workflow
- GitHub Action
---
>  编写Alfred Workflows已经快30个，在使用中，我也会根据遇到的问题及不足进行版本迭代，然后更新到GitHub上，方便他人下载使用。但GitHub中存储的是workflow文件格式，没办法直接看到版本信息，除非下载安装。这样就无法直观确定，版本问题。
>
>  手动维护更新？no，太浪费实践。

>  因此我需要CI帮我读取workflow的版本，更新到对应的readme文件中，这样我就可以很快确定本地安装的与仓库托管的版本是否一致，是否需要更新。



## 可行性基础

Alfred的workflow文件本质是一个zip压缩文件，解压后，会看到一个plist文件，其中就记录了版本信息。

确定了可行性就好说了

## 方案设计

因为个人更擅长JS，所以关键的执行过程采用JS编写。整体的方案如下。

1. 监听所有workflow文件变动，一旦有变化，执行JS
2. 遍历所有文件夹，获取文件夹中的workflow文件
3. 拷贝文件重命名为zip后缀，执行解压缩，
4. 读取plist文件中的版本信息，替换readme文件中原版本信息即可
5. 提交更新到仓库

## 遇到的几个问题

实现中还是踩了点坑的

1. workflow有些文件名包含空格。markdown链接中如果包含空格，解析会有问题，因此需要提前做转译处理。关于转译，因为是NodeJS，所以无法使用`encodeURIComponent`，可以使用`queryString.escape`解决。

2. 本地调试时，明明安装了plist到全局模块中，但是IDE还是报`Module is not installed` ，原来nodejs require第三方模块并不会去全局模块文件夹下寻找，因此需要安装到项目下或者使用`npm link plist` 

   ![](https://static.1991421.cn/2021/2021-07-03-131359.jpeg)



## 写在最后

搭建这样的机制后，以后只需要更新仓库里的workflow，CI机会自动更新新的版本号到readme中，nice！



