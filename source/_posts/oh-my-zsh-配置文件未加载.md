---
title: oh my zsh 配置文件未加载
abbrlink: eb2e176f
date: 2018-04-07 22:19:44
tags:
  - zsh
---
> zsh是个很不错的shell,但在使用中发现有个问题，就是我必须首先执行下`source ~/.zshrc`，并且当我新开终端tab，或者重启机器后，我便不得不再次执行source命令，否则还是会报命令不识别错误。
推断就是oh my zsh 配置文件未加载
![](//static.1991421.cn/blog/2018-04-07-142912.jpg)
如果每次都需要这么做，天理不容，so，必然有解决办法，请向下看。

## 解决方法

+ Terminal --> Preferences --> General --> Shells open with
+ Shells open with 设定为Command (complete path) `/bin/zsh`
+ New windows open with 选择 `Same Profile`
+ New tabs open with 选择 `Same Profile`

![](//static.1991421.cn/blog/2018-04-07-142448.png)

## 参考链接
+ https://stackoverflow.com/questions/15682456/oh-my-zsh-config-file-not-loading
