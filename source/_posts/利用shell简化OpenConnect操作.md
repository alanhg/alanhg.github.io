---
title: 利用Shell简化OpenConnect操作
date: 2018-09-15 13:02:33
tags:
- OpenConnect
- Shell
---
> 在家经常需要VPN到公司，每次操作还是挺繁琐的,所以就想着搞个shell简化操作，这里mark下。

## 之前的操作
 ![](http://or0g12e5e.bkt.clouddn.com/2018-09-15-044531.png)
 
如图，每次输入还算短的openconect命令、参数是不怎么好记的IP地址、5次交互输入，就这样来了几次，我表示已经受不了，得解决，怎么搞？写Shell!!!

## Shell自动化
这里输入的值除了最后一次密码无法脚本化【因为这里的操作需要手动输入密码】，其余都可以。这里我使用expect去解决这些交互输入。

具体脚本如下，vpn.sh

```shell
#!/usr/bin/expect
# vpn to lenovo
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
