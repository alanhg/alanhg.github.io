---
title: oh-my-zsh中文乱码
date: 2017-11-26 20:54:50
tags:
- zsh
---
> zsh是个强大的Shell,但是配置过于复杂，很多人望而却步，直到有一天，一个大神开发出了一个让你快速上手的项目，就是这里的`oh my zsh`,想了解这个的去[官方仓库](https://github.com/robbyrussell/oh-my-zsh)。

![oh-my-zsh](http://or0g12e5e.bkt.clouddn.com/blog/2017-11-26-132719.jpg)

安装oh-my-zsh后，发现中文文件名会是乱码，肯定是字符集的问题，检索了会儿，解决方案如下

1. `vi ~/.zshrc`
2. 末尾加入如下两行
```bash
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
```
3. `source ~/.zshrc` ,立即生效，再次输入中文，发现fixed.

