---
title: PM2介绍
abbrlink: 8ab7c90a
date: 2016-09-19 21:37:13
tags:
    - nodejs
    - pm2
    - 英翻
---
原英文仓库网址，[点击这里](https://github.com/Unitech/pm2)

PM2 是一个node应用下，自带服务均衡的`产品级`进程管理器。使得能够保证应用一直处于运行状态，并且能够不间断的重启服务，方便管理这些系统任务。
生产模式下启动一个应用是很容易的，就像这样:
`$ pm2 start app.js`
PM2支持在Linux(稳定) & MacOSx (稳定) & Windows (稳定)工作.

## 安装PM2
`$ npm install pm2 -g`
npm命令是在你安装node时，自带的CLI - [通过NVM安装node](https://keymetrics.io/2015/02/03/installing-node-js-and-io-js-with-nvm/)

## 更新PM2
```bash
# 安装最新版PM2
$ npm install pm2 -g
# 保存进程列表，退出旧的PM2，重新存储所有的进行
$ pm2 update

```

PM2是无缝更新。

## 主要功能

### 命令表一览

```
# 常用
$ npm install pm2 -g            # 安装PM2
$ pm2 start app.js              # 启动应用，一旦应用出故障，自动重启(Node)
$ pm2 start app.py              # (Python)
$ pm2 start npm -- start        # 

# 集群模式 (Node.js only)
$ pm2 start app.js -i 4         # 集群模式，启动4个应用实例
                                # 根据网络请求进行负载平衡
$ pm2 reload all                # 无间断重启
$ pm2 scale [app-name] 10       # 将集群APP进程数调到10

# 进程检测
$ pm2 list                      # 列出所有以PM2形式启动的应用
$ pm2 monit                     # 列出每个应用内存及CPU使用情况
$ pm2 show [app-name]           # 列出关于应用的所有信息

# 日志管理
$ pm2 logs                      # 列出所有应用日志
$ pm2 logs [app-name]           # 列出指定应用的日志
$ pm2 logs --json               # 以JSON格式列出日志
$ pm2 flush
$ pm2 reloadLogs

# 进程状态管理
$ pm2 start app.js --name="api" # 启动应用，并命名为api
$ pm2 start app.js -- -a 34     # 启动应用，并传参 "-a 34"
$ pm2 start app.js --watch      # 一单文件修改，重启应用
$ pm2 start script.sh           # 启动bash脚本
$ pm2 start app.json            # 启动app.json文件中声明的所有应用
$ pm2 reset [app-name]          # 重置应用计数器即重启次数
$ pm2 stop all                  # 停止所有的应用
$ pm2 stop 0                    # 停止id为0的应用
$ pm2 restart all               # 重启所有应用
$ pm2 gracefulReload all        # 集群模式下重启所有应用
$ pm2 delete all                # 停止且删除所有应用
$ pm2 delete 0                  # 停止且删除id为0的应用

# 启动管理
$ pm2 startup [platform]        # 监听初始化系统，生成且配置PM2启动脚本
$ pm2 save                      # 存储当前进程列表
$ pm2 resurrect                 # 重新存储之前存储的进程
$ pm2 unstartup                 # 停用并删除启动程序

$ pm2 update                    # 存储进程，中止并重新存储进程
$ pm2 generate                  # 生成一个JSON格式样例配置文件

# 部署
$ pm2 deploy app.json prod setup    # 
$ pm2 deploy app.json prod          # 
$ pm2 deploy app.json prod revert 2 # 

# 模块系统
$ pm2 module:generate [name]    # 生成name名称的样例模块
$ pm2 install pm2-logrotate     # 安装模块(会有一个日志系统)
$ pm2 uninstall pm2-logrotate   # 模块卸载
$ pm2 publish     

```

### 进程管理

一旦应用启动，你可以很方便的列出和管理

列出所有运行中的进程
`$ pm2 list`
直接管理你的进程
```
$ pm2 stop     <app_name|id|'all'|json_conf>
$ pm2 restart  <app_name|id|'all'|json_conf>
$ pm2 delete   <app_name|id|'all'|json_conf>
```

### 负载均衡和不间断重启
当应用启动时加上了`-i <instance_option>选项时`，集群模式便开启了。
集群模式下，应用汇自动的平衡请求，这个模式下也允许你能够依据CPU的数目灵活的提升表现。
被所有NODE主流框架和任何NODE应用支持而不需要任何code改变。

主要命令
```
$ pm2 start app.js -i max  # Enable load-balancer and start 'max' instances (cpu nb)

$ pm2 reload all           # Zero second dowtime reload

$ pm2 scale <app_name> <instance_number> # Increase / Decrease process number

```

[更多信息关于如何在PM2下使用集群化](https://keymetrics.io/2015/03/26/pm2-clustering-made-easy/)

### 日志能力

显示特定进程或者所有进程，实时，标准，真实，JSON和格式化输出

`$ pm2 logs ['all'|app_name|app_id] [--json] [--format] [--raw]`

例子：
```
$ pm2 logs APP-NAME       # Display APP-NAME logs
$ pm2 logs --json         # JSON output
$ pm2 logs --format       # Formated output

$ pm2 flush               # Flush all logs
$ pm2 reloadLogs          # Reload all logs

```

### 启动脚本生成

PM2能够生成并配置启动脚本，从而使PM2和你的进程能够在每次服务器重启时保持运行状态。
支持初始化系统包括：systemd (Ubuntu 16, CentOS, Arch), upstart (Ubuntu 14/12), launchd (MacOSx, Darwin), rc.d (FreeBSD).
```
# Auto detect init system + generate and setup PM2 boot at server startup
$ pm2 startup

# Manually specify the startup system
# Can be: systemd, upstart, launchd, rcd
$ pm2 startup [platform]

# Disable and remove PM2 boot at server startup
$ pm2 unstartup
```
在重启时保存进程列表
`$ pm2 save`
[更多关于启动脚本](http://pm2.keymetrics.io/docs/usage/startup/)

## 模块系统
PM2内嵌了简单而强大的模块系统，安装一个模块是很简单直接的事。
`$ pm2 install <module_name>`
下面是一些兼容模块 (standalone Node.js applications managed by PM2):

pm2-logrotate auto rotate logs of PM2 and applications managed
pm2-webshell expose a fully capable terminal in browsers
pm2-server-monit monitor your server health

[写你自己的模块](http://pm2.keymetrics.io/docs/advanced/pm2-module-system/)

### Keymetrics监测
如果你使用PM2来管理你的NodeJS app，Keymetrics使得通过服务器去监测应用变得很容易。
谢谢，希望你喜欢PM2！

## 更多关于PM2的资料

- [Application Declaration via JS files](http://pm2.keymetrics.io/docs/usage/application-declaration/)
- [Watch & Restart](http://pm2.keymetrics.io/docs/usage/watch-and-restart/)
- [PM2 API](http://pm2.keymetrics.io/docs/usage/pm2-api/)
- [Deployment workflow](http://pm2.keymetrics.io/docs/usage/deployment/)
- [PM2 on Heroku/Azure/App Engine](http://pm2.keymetrics.io/docs/usage/use-pm2-with-cloud-providers/)
- [PM2 auto completion](http://pm2.keymetrics.io/docs/usage/auto-completion/)
- [Using PM2 in ElasticBeanStalk](http://pm2.keymetrics.io/docs/tutorials/use-pm2-with-aws-elastic-beanstalk/)
- [PM2 Tutorial Series](https://futurestud.io/tutorials/pm2-utility-overview-installation)

## 更新日志
[CHANGELOG](https://github.com/Unitech/PM2/blob/master/CHANGELOG.md)

## 贡献者

[贡献者](http://pm2.keymetrics.io/hall-of-fame/)

## 常见问题
以下问题为官方文档没有明确指出，但是在实际使用中却会遇到的问题，这里说明下。

###  为什么有时候执行`pm2 list`不显示appid等信息

其实这个主要看终端窗体大小，如下图

![pm2 list](http://static.1991421.cn/blog/2017-08-23-145913.jpg)

你会看到两次执行，出来的窗体显示信息不同，实际原因是第一次执行时候，我的终端窗体很窄，拉大后再执行命令就显示下部的样子，所以想显示完整的应用信息，需要确保终端窗体大一些。

###  如何重启、关闭等多个应用

比如我们有appid为0、1两个应用，除了单个或全部方式操作外，其实pm2支持多个，操作方式如下
`pm2 start 0 1`,这样就会启动id为0和1两个应用,stop、restart等操作等同。

###  pm2应用日志有必要吗
一般而言，pm2管理的应用本身都有自己日志系统，比如我开发node应用一般会使用`log4js`,所以pm2没必要输出需要禁用

### pm2启动后，环境变量未定义
最近web有需要调用环境变量的地方，发现当node启动时，环境变量获取OK，但pm2启动报未定义。

解决办法加参数`--env production`
