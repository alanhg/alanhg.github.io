---
title: v8-debug安装
date: 2021-04-11 23:27:10
tags:
- chrome
---

> 想要深入理解JS，就需要了解v8，通过v8-debug方便去理解字节码，JS优化等等。这里记录下v8-debug的安装

## 安装

~~网上有提到`brew install v8`，但安装后发现没有--print-ast选项，原因不明，因此不建议~~

1. npm install jsvu -g

2. jsvu运行，选择V8 debug即可安装OK，安装后如果重新执行jsvu，则会更新已安装v8

3. bash或者zsh配置如下

   - export PATH="${HOME}/.jsvu:${PATH}"

   - alias d8='v8-debug'

     别名配置主要为了方便使用

