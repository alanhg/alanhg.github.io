---
title: iTerm2配置网络代理
abbrlink: 6da128ad
date: 2020-11-17 19:27:14
tags:
- Shell
- Terminal
- 科学上网
---
> 在使用代理App时，虽然开了系统代理，但是比如iTerm2终端中还是不行。针对此问题，虽然Surge有增强模式可以解决这个，但是因为日常我需要VPN公司的原因，默认不开增强，因此需要寻求手段使得终端走代理服务。

如下即为解决方案

## 配置

1. 打开bash_profile，`vi ~/.bash_profile`
2. 增加如下配置
	```
	export http_proxy=http://127.0.0.1:6152
	export https_proxy=$http_proxy
	```
3. 变更生效
	`source  ~/.bash_profile`

4. 测试	
   
    `curl -i https://google.com`

	![](https://static.1991421.cn/2020/2020-11-17-190707.jpeg)


## 写在最后

这样iterm2发出的HTTP请求即可走代理服务了，一劳永逸，nice。
