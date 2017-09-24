---
title: linux下sz、rz实现上传下载
date: 2017-09-24 11:43:49
tags:
- linux
---
> 在日常开发中，我们经常需要上传文件到服务器或者从服务器下载文件。ftp还需要搭建ftp服务器配置服务，使用sz/rz可以进行简单的上传下载操作

## 安装

```bash
brew install lrzsz
```

## 用法

### sz用法：发送出去

+ 下载一个文件： 
`# sz filename` 
+ 下载多个文件： 
`# sz filename1 filename2`
+ 下载dir目录下的所有文件，不包含dir下的文件夹： 
`# sz dir/*`

### rz用法：接收回来

+ 直接键入rz命令即可
`# rz`

+ 强制覆盖源文件
`# rz -y`