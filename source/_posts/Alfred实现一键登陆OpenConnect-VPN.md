---
title: Alfred实现一键登陆OpenConnect VPN
tags:
  - Alfred
  - Workflows
abbrlink: 903a293e
date: 2020-05-26 22:34:28
---
> 经常需要登陆公司VPN，一直使用脚本登陆，但还是不够高效，于是为了节约时间，利用Alfred来实现一键VPN

![](https://static.1991421.cn/2020/2020-05-27-140109.png)


## workflow
workflow中的关键点有以下几步

1. keyword获取用户输入的手机验证码
2. 临时存储keyword到变量中，原因是还需要用户进一步选择服务器节点
3. list filter的keyword随便输入一个且与第一步的keyword不同即可
4. 脚本使用了expect，所以最终执行需要terminal command,无法选择`Run Script`
5. 因为系统密码及VPN账户我走的workflow环境变量而command是不支持环境变量解析，所以增加Run Script解析变量


## shell脚本

### Run Script



```
echo "/Users/qhe/Documents/Shell/vpn.sh $code {query} $MAC_PASSWORD $USERNAME $PASSWORD"

```

- 注意workflow中的变量和环境变量在shell解析都是$name来解析
- 如上，这里打印出最终终端想执行的命令，包含了变量

### Terminal Command

只需要解析了query即可，{query}，即上一步打印的结果


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



## 写在最后

之前一直不懂如何在Alfred中让用户进行多次输入操作，现在明白了，如上keyword加listFilter即可实现。而为了保存用户每次操作后的值，使用var and arg进行保存。
