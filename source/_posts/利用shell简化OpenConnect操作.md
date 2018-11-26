---
title: 利用Shell简化OpenConnect操作
tags:
  - OpenConnect
  - Shell
abbrlink: a5a17446
date: 2018-09-15 13:02:33
---
> 在家经常需要VPN到公司，每次操作还是挺繁琐的,所以就想着搞个shell简化操作，这里mark下。

## 之前的操作
 ![](http://static.1991421.cn/2018-09-15-044531.png)
 
如图，每次输入`还算短的openconect命令、参数是不怎么好记的IP地址、5次交互输入`，就这样来了几次，我表示已经受不了，得解决，怎么搞？写Shell!!!

## Shell自动化
这里输入的值除了最后一次密码无法脚本化【需要手动手机动态Code】，其余都可以。这里我使用[expect](https://linux.die.net/man/1/expect)去解决这些交互输入。

具体脚本如下，vpn.sh

```shell
#!/usr/bin/expect
# vpn to xxx
spawn sudo openconnect 1.1.1.1
expect "Password" {send "xxxxxxxx\r"}
expect "Enter 'yes' to accept" {send "yes\r"}
expect "Username:" {send "xxx\r"}
expect "Password" {send "xxx\r"}
interact
```
大功告成，现在VPN只需要

1. `./vpn.sh`
2. 手动输入手机动态密码

效率显著提升。

## 相关文档
+ [关于shell和expect和ssh](https://segmentfault.com/a/1190000002564816)
