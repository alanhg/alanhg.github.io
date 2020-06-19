---
title: 将VSC打造成配合IDEA的工具
tags:
  - 利器
  - VSC
  - Visual Studio Code
abbrlink: b3693c98
date: 2019-10-27 20:17:46
---
> 目前使用最多的IDE是Intellij IDEA，和WebStorm，数据库软件近期也从Navicat切换到了DataGrip，目的就是维持一套操作习惯，一招吃天下。但IDEA，和WS都太重了，有时候简单的编辑一个网页，打开IDEA或者WS启动也很慢。
> 
> VSC这几年很火，毕竟很轻，同时又有海量的插件支持。于是打算将VSC按照IDEA的一些操作习惯进行改造打磨,提升下效率。

## 插件安装

- IntelliJ IDEA Keybindings `保持快捷键大部分与IDEA一致`
- open in browser `浏览器打开文件`	
- Darcula IntelliJ Theme `保持与IDEA一致主题风格`
- Prettier - Code formatter
- EditorConfig for VS Code
- TSLint

## 自定义设定
- Open in Default Brower快捷键改为`⌥ F2`,原因是同步IDEA中preview in brower快捷键

## 写在最后
1. 目前插件安装的并不多，原因是VSC在我的生产工具集中定位如此，同时插件过多也会导致VSC不再`轻`,这要控制
2. 经过打磨和熟悉，现在MD编辑我会用专门的Macdown，简单的HTML、JSON文件、PlantUML、轻量级项目，我会用VSC就进行快速修改编辑，而大点的项目则会直接启动IDEA或者WS，so，完美的工具集。

![](https://static.1991421.cn/2019-10-27-121315.png)

## 参考文档

- [9 + 1 Visual Studio Code Extensions for Easier and Faster Development](https://dev.to/drsavvina/9--1-visual-studio-code-extensions-for-easier-and-faster-development-164n)
- [于是我从 WebStorm 转向了 VS Code ](https://github.com/lmk123/blog/issues/59)
