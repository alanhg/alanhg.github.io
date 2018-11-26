---
title: hexo-error
tags:
  - hexojs
  - nodejs
  - javascript
abbrlink: 15c803b4
date: 2018-06-20 08:17:24
---
> 个人博客是用的hexo，虽然简单，但使用中还是会遇到一些小问题，这里贴出常见错误

## YAMLException: can not read a block mapping entry; a multiline key may not be an implicit key at line 2, column 1
说到底是语法错误，比如这样
![](//static.1991421.cn/2018-06-20-121857.png)
执行hexo g 会报如上错误，因为[]的原因，所以这时需要加上''
![](//static.1991421.cn/2018-06-20-121958.png)
再次执行即可。

