---
title: mac卸载node
date: 2017-11-29 23:17:53
tags:
- node
---
> 一开始通过mac安装了个node版本，后来发现了nvm这个好东西，但nvm管理的多版本node是与自己系统安装的并存，这个时候管理上会有些混乱。
比如我在nvm中的某个node版本安装了很多全局的CLI，并且将这个版本设定为缺省，但是有时候开启终端会话，默认会是系统版本的node，这样每次切换很浪费时间，最好的版本是删除系统版本的node，统一使用nvm进行管理。


## 如何卸载node???

如果nvm下管理的node版本，那么卸载node很简单，执行`nvm uninstall version`即可，如果是利用brew包管理器进行的安装，直接执行`brew uninstall node`即可。
如果是直接官网卸载pkg包进行的安装，那么删除就复杂了，请往下看。

![nvm ls](http://or0g12e5e.bkt.clouddn.com/blog/2017-11-29-152926.jpg)

注意执行`nvm ls`，system就是自己系统安装的node

## 手动卸载pkg安装的node

### 删除`/usr/local/lib`下的node相关文件
```bash

$ sudo rm -rf /usr/local/lib/node /usr/local/lib/node_modules /var/db/receipts/org.nodejs.*

$ cd /usr/local/lib
$ sudo rm -rf node*

```
### 进入 /usr/local/include 删除含有 node 和 node_modules 的目录
   
```
cd /usr/local/include
sudo rm -rf node*

```

### 进入个人主文件夹，检查各种 local、lib、include 文件夹，删除名字含有node和node_modules的文件
###  进入 /usr/local/bin 删除 node 执行文件

```
cd /usr/local/bin
sudo rm -rf /usr/local/bin/npm
sudo rm -rf /usr/local/bin/node
ls -las 仔细查看，全局安装的npm包一般会在这个目录下创建软连接，发现就删除
```
#### 其它清理工作
```
sudo rm -rf /usr/local/share/man/man1/node.1
sudo rm -rf /usr/local/lib/dtrace/node.d
sudo rm -rf ~/.npm
```
_注意_:/usr/local/lib 和 /usr/local/bin 这两个文件夹，全局安装的npm包会有很多软连接，需要仔细删除.

当一切都执行OK后，再看`nvm ls`,发现system版本不存在啦。

![nvm ls](http://or0g12e5e.bkt.clouddn.com/blog/2017-11-29-153057.png)