---
title: >-
  You don’t have permission to save the file “project.xcworkspace” in the folder
  “CodeTracker.xcodeproj”
tags:
  - cordova
  - ionic
abbrlink: d250945e
date: 2017-07-23 14:32:45
---
## 问题
在进行ionic开发，构建ios平台时，运行`CodeTracker.xcodeproj`,经常报权限错误`You don’t have permission to save the file “project.xcworkspace” in the folder
  “CodeTracker.xcodeproj” `
![don’t have permission](//static.1991421.cn/blog/2017-07-23-074016.jpg)
## 解决
选择ios文件夹，单击右键-`Get Info`-将staff用户设置为具有读写权限，同时点击设置按钮应用到所有子文件中.
![solution](//static.1991421.cn/blog/2017-07-23-074247.jpg) 
