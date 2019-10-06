---
title: 一键连接Cisco AnyConnect Secure Mobility Client
date: 2019-10-06 22:57:53
tags:
- 
---

> 因为最近众所周知的原因，上不了外网了，so开始使用公司VPN，但是公司VPN连接起来总是很费时间。步骤繁琐，于是考虑如何解决。
> 
> 公司的一封邮件给了很大的帮助，测试成功，这里我也总结一番。

## 繁琐的启动步骤

1. 启动Cisco AnyConnect Secure Mobility Client
2. 输入账户密码
3. 选择手机短信验证码校验
4. 手机查收短信验证码
5. 客户端输入验证码
6. 点击确定

## 如何自动化呢

1. 安装oath-toolkit

	```bash
	$ brew install oath-toolkit
	```

2. 编写shell脚本
  
	比如叫vpn.sh
  
	```bash
	#!/bin/bash

	killall 'Cisco AnyConnect Secure Mobility Client' 2>/dev/	null
	/opt/cisco/anyconnect/bin/vpn disconnect >/dev/null

	code=`oathtool --totp -b **secret_key**`

	/opt/cisco/anyconnect/bin/vpn -s connect $1.company.vpn.com << EOF | sed 's/Password: .*/Password: ********/g'
**username**
**password**
**second_authentication_method_index**
$code
EOF

	open -g '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app'
```


3. 填写变量信息

	- secret_key为我们vpn登陆认证的secret key，比如我司用的Okta Verify，则登陆网站，在修改密码=>Extra Verification=>Okta Verify Mobile App=>Setup=>Next=>Problems scaning barcode=>找到Secret Key，记住这个key.点击返回可继续增加手机App校验。记住两者不影响
	- username即VPN用户名
	- password即VPN用户密码
	- second_authentication_method_index指的是当我们VPN登陆时，选择的校验类型，选择对应的即可，我们既然选择了Secret key，找到对应的序号填入即可

	到此，最麻烦的手机校验码通过这个secret key搞到了

4. shell增加执行权限

	```
chmod +x vpn.sh
	```

5. 执行脚本
	
	```bash
	./vpn.sh bj

	``` 
 这里为什么会有个bj变量，是因为我司的VPN有多个节点服务，如上脚本对应的是`$1.company.vpn.com`中的变量，假如不需要,去掉这个变量即可。

脚本会自动启动cisco客户端并且连接OK。这样每次就可以不用执行繁琐的步骤了，至少节约2分钟*N次。另外启动时，会杀掉客户端的其它进程，客户端运行中，我们重新执行这个脚本，也不会有问题。

## 锦上添花
做到了自动化，每次手动去打开终端，执行脚本还是不够优雅。怎么更好呢，利用Alfred配置个workflow，比如唤起Alfred，输入VPN，回车自动执行脚本，岂不美哉？

## 写在最后

重复操作即是体力，学会用工具去解决体力劳动，加油！

	
