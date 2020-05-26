---
title: Alfred实现一键登陆OpenConnect VPN
date: 2020-05-26 22:34:28
tags:
- Alfred
- Workflows
---
> 经常需要登陆公司VPN，一直使用脚本登陆，但还是不够高效，于是为了节约时间，利用Alfred来实现一键VPN


![](http://static.1991421.cn/2020/2020-05-26-234047.jpeg)


## workflow
workflow中的关键点有以下几步

1. keyword获取用户输入的手机验证码
2. 临时存储keyword到变量中，原因是还需要用户进一步选择服务器节点
3. list filter的keyword随便输入一个且与第一步的keyword不同即可
4. 因为脚本使用了expect，所以无法选择`Run Script`

### 注意
- Terminal Command中是无法使用Workflow的环境变量

## shell脚本

```sh
#!/usr/bin/expect
set code [lindex $argv 0]
set url [lindex $argv 1]
set macPassword [lindex $argv 2]
set username [lindex $argv 3]
set password [lindex $argv 4]

spawn sudo openconnect "$url"
expect "Password" {send "$macPassword\r"}
expect "Enter 'yes' to accept" {send "yes\r"}
expect "Username:" {send "$username\r"}
expect "Password" {send "$password\r"}
expect "Password" {send "$code\r"}
interact
~
```


https://www.alfredforum.com/topic/10653-environment-variables-in-terminal-command-object/?tab=comments#comment-54559

## 写在最后

之前一直不懂如何在Alfred中让用户进行多次输入操作，现在明白了，如上keyword加listFilter即可实现。而为了保存用户每次操作后的值，使用var and arg进行保存。
