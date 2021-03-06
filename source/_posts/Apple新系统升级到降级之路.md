---
title: Apple新系统升级到降级之路
tags:
  - Mac
  - 搞机
abbrlink: 34eb9d13
date: 2020-07-10 23:12:08
---
> WWDC结束，我便快速的升级了iPhone,iWatch,Mac，以为会是一直升一直爽，然而心情就像过山车，先让我哭一会儿。

虽然多少对内测试版的不稳定有些心理准备，但真升级后，不得不说心情就像过山车。

![](https://static.1991421.cn/2020/2020-07-12-174327.jpeg)


## 如何升级

访问该网页，按照提示下载安装Profile，之后就会有新版提醒，直接安装即可升级。

https://betaprofiles.com

### 注意

- beta版，Apple基本上两周一更新，直到秋季发布会
- 升级前一定要备份，比如Mac进行Time Machine备份，推荐NAS方案，性价比很高，iPhone的话有iCloud备份


## 升级后各个设备出现的问题

升级带来的新鲜感还是有的，比如iPhone的Widget，Mac的新UI。但伴随新鲜感的同时带来的问题也是蛋疼的。

### Mac
- bartender彻底废掉
- terminal经常不work，只能重启解决，`beta2好转`
- 关机经常失效，搞的我经常强制关机
- 欧陆词典崩溃
- 内存经常爆满。。。

### iPhone
- 微信闪退
- AirPods hey siri失败

### iWatch
毕竟功能较少，也就看个时间，卡路里，还好

升级一时爽，建议高频日常通勤设备不要升级测试版了，问题太多，影响日常工作生活。

## macOS Big Sur降级

因为我的主生产力工具是Mac，但新系统的不稳定已经严重影响我的效率，所以决定降级，同时因为有TM的不间断备份，所以理论上是可以完美还原的。

当然实际的降级恢复不是很顺利，因为姿势不对。

### 注意
- 直接本机器重装系统是没用的，因为会以电脑中的最新版系统比如Big Sur进行安装
- 当前Big Sur连接Time Machine是会报错的

### 降级的正确步骤
- 开机按住`⌘ ⇧ ⌥ R`，进入网络装机
- 格式化硬盘
- 选择重新安装系统
- 启动机器，选择Time Machine-具体的日期备份-恢复

## 写在最后

这次升级带来了诸多的麻烦，但同时也有2个收获认识。

1. 高频使用的生产力工具在盲目升级后带来的严重后果，给自己一个严重的警告和批评，以后再也不犯这种错误了。
2. 备份及云端存储的重要性，NAS开启Time Machine，可以作为系统层面的备份，iCloud同步苹果设备的一些数据备份，One Drive进行Alfred配置备份，Google Photos照片备份，印象笔记本身的云笔记存储，Jetbrains IDE 进行的GitHub设置同步备份等等，这些服务一开始的规划也是花时间的，但是当这些都形成体系规则后，妈妈再也不用担心我的数据丢失，即使是一台新的Mac，新的iPhone 11拿到手，也可以利用这些云端数据快速的打磨出一台跟以前一样好使的设备。

