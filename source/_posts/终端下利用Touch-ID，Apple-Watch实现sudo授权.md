---
title: 终端下利用Touch ID，Apple Watch实现sudo授权
date: 2020-12-10 10:48:57
tags:
- PAM
- Mac
---

> 一直很喜欢Mac的Touch ID及Apple watch的解锁体验，但身为开发，日常还经常会使用到shell sudo，这时也会提示输入Mac密码，于是我在想是不是也可以用Touch ID及Apple watch实现授权呢，惊喜发现还真可以。


## 配置方式

*注意：这里因为我要实现同时支持Touch ID及Apple watch，因此安装以下两个库，只需要一种的，安装目标库及配置即可。*

1. 下载这两个仓库，推荐Git Clone方式
	- https://github.com/Reflejo/pam-touchID
	- https://github.com/biscuitehh/pam-watchid

2. install package
	
	在每个仓库目录下执行
	
	```
	$ sudo make install
	```
	
3. 编辑sudo配置，开启授权

    ```
    $ sudo vi /etc/pam.d/sudo
   
    ```
    
    增加以下配置，在头部
    
    
    ```shell
	$ auth sufficient pam_watchid.so "reason=execute a 	command as root"
	$ auth sufficient pam_touchid.so "reason=execute a 	command as root"
    ```
     
    
    执行`wq!`保存
 
 
## 注意
 
 1. 上面命令中的sudo别少
 2. 配置修改后，即刻生效，不需要重启终端或执行其它命令
 2. 配置文件中认证授权顺序很重要，建议如上即可
 3. 如Mac在盒盖模式下，自然会切换到下一种认证方式，比如密码
 4. 该配置直接走的是sudo，与终端App类型无关，因此iTerm2，IDEA中的terminal均work
 
##  效果

 
 ![](https://static.1991421.cn/2020/2020-12-10-174011.gif)

## PAM-科普
好奇模块为什么都以PAM前缀，于是查了下,PAM全称[`Pluggable authentication module`](https://en.wikipedia.org/wiki/Pluggable_authentication_module)

> Sun提出的一种认证机制，
通过提供一些动态链接库和一套统一的API，将系统提供的服务 和该服务的认证方式分开，使得系统管理员可以灵活地根据需要给不同的服务配置不同的认证方式而无需更改服务程序，同时也便于向系统中添加新的认证手段。

点到为止。。

## 写在最后
如上设定，方便多了。但也请注意，安全记录Mac密码，总有需要输入的场景。