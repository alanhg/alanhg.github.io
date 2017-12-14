---
title: Angular+Express平台部署
abbrlink: 66cded2a
date: 2017-12-13 17:53:05
tags:
- Angular
- Express
- Linux
---
> 最近需要在云服务器部署下Web应用，这里简单Mark下，同需求的人姑且一看

## 部署背景
生产服务器:`CentOS release 6.8 (Final)`
网络环境:`已联网`
工作机器:`Windows`

***

废话不说，开始部署

## 终端连接
使用`putty`开启会话连接目标服务器

## 安装NVM
直接安装node，其实可以，但使用NVM安装node更为方便，版本变更也方便。

```bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

```

NVM官方仓库地址:[点击这里](https://github.com/creationix/nvm)

**注意NVM安装后，会话需关闭重开启，才生效。**

## 安装Node
```bash
nvm install 6
```
我这里安装的是6.x最新版。
### 安装NRM
NRM是何物，管理npm源的，由于我们身处上不去谷歌的自由国度，NPM下载包还是慢的很，所以安装NRM，切换到国内源，还是会快很多。

```bash
$ npm i nrm -g
$ npm ls
$ nrm use taobao
```

NRM官方网址:[点击这里](https://github.com/Pana/nrm)


## 部署项目

### 创建项目文件夹
```
mkdir /var/www
mkdir /var/www/projectName

```

**根据Linux目录标准，var下存放经常变动的文件**

### 拷贝web应用[前端dist文件夹+后端程序文件+第三方node_modules包]
Angular前端就是个dist文件夹，直接丢到该文件夹即可。后端应用也一样直接丢进去即可。
上传这些文件，可以用`WinSCP`直接上传。

由于后端是expressJS，牵扯到`node_modules`，可以直接将生产依赖的包，上传，或者直接在项目根路径下，执行`npm i`，即可将依赖的包安装上去。

### 安装PM2
PM2是何物,产品级进程管理器，官方网站:[点击这里](https://github.com/Unitech/pm2)

PM2讲解，除官网外，可以看这里，[我翻译的](http://1991421.cn/2016/09/19/8ab7c90a/)
```
$ npm i pm2 -g

```
### 环境变量
我的后端本身在开发和生产环境下，会走不同的一些配置，所以这里需要设定下`NODE_ENV`

```bash

$ export NODE_ENV="production"
$ echo $NODE_ENV
```

### 启动应用

```bash
$ cd /var/www/projectName

# pm2启动应用，自定义名称
$ pm2 start app.js --name='projectName'

# 系统级服务设定，机器重启，自启动
$ pm2 save
$ pm2 startup

```

## 安装Nginx

```
yum -y install nginx

```
### 代理配置
nginx的配置文件在`/etc/nginx/conf.d/default.conf`,因为我的应用对外是80访问，所以这里直接在这里修改，

```
server {
    listen       80 default_server;
    listen       [::]:80 default_server;
    server_name  _;
    root         /usr/share/nginx/html;

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;

    location / {
         proxy_pass http://localhost:3001;
    }

    error_page 404 /404.html;
        location = /40x.html {
    }

    error_page 500 502 503 504 /50x.html;
        location = /50x.html {
    }

}

```
注意:我是利用nginx直接代理了`3001`的web服务，web服务本身的静态、动态内容都是在3001下。当然也可以利用nginx管理静态资源，动态内容反向代理，均可。

### 启动nginx
由于是YUM安装nginx,所以可以直接使用nginx命令

```
# 启动nginx服务
$ nginx

# 重启nginx服务
$ nginx -s reload

# 停止nginx服务
$ nginx -s stop

```
### nginx设定为自启动

实际生产环境，其实服务器会存在重启，所以这里也需要设定为自启动

```
$ chkconfig nginx on
```

## 开放对外服务端口

```
# 80端口开放
$ /sbin/iptables -I INPUT -p tcp –dport 80 -j ACCEPT

# 保存
$ /etc/rc.d/init.d/iptables save
```
如果临时测试的话，也可以考虑直接关闭防火墙，但安全性就不存在了。

```
$ service iptables stop # 停止服务

```

## 结语
![fighting](http://or0g12e5e.bkt.clouddn.com/blog/2017-12-13-104640.png)

大功告成，这个时候，直接访问服务器IP地址，就可以了，需要域名访问，就在DNS加条域名解析即可。

说明:因为实际部署我正好用的win机器，其实mac也差不多，部分工具有差异而已，比如win下用的putty,mac下推荐使用iterm2。
部署操作差别不大。

`上述有对基本工具、基本命令不熟悉的，建议自行谷歌吧。`
