---
title: 利用Hammerspoon做些自动化
tags:
  - Hammerspoon
  - workflow
  - 效率工具
abbrlink: d74c4ec4
date: 2019-09-28 16:08:52
---
> 之前知道Hammerspoon，但没玩过，最近看了下，试着写了些脚本，觉得有点意思，这里Mark下

![](http://static.1991421.cn/2019-09-28-080913.jpg)

以下我用hs来代指hammerspoon

## 小工具制作

### 实现功能
1. 系统自动静音
2. MVN切换设定

### 上代码

```lua
Wifi
-- audio mute 
-- change mvn setting 

local workWifi = 'company-wifi'
local outputDeviceName = 'Built-in Output'
hs.wifi.watcher.new(function()
    local currentWifi = hs.wifi.currentNetwork()
    local currentOutput = hs.audiodevice.current(false)
    if not currentWifi then return end
    if (currentWifi == workWifi and currentOutput.name == outputDeviceName) then
        hs.audiodevice.findDeviceByName(outputDeviceName):setOutputMuted(true)

        local changeMvnCommand="ln -sfn ~/.m2/settings_company.xml ~/.m2/settings.xml"
        hs.execute(shell_command)

        hs.notify.new({title="HS Robot", informativeText="Connect to Company"}):send()
            
    end
end):start()
```

## 与Alfred的不同
- Alfred是提供固定的交互方式，比如关键词，比如快捷键来实现一些功能，从而提高生产力。
- hs是以Lua语言为口子，基于Mac系统的底层API封装一套API来帮助我们实现一些功能，比如上述的监听WI-FI变化，执行shellm命令，或者实现分屏等，这些是alfred所做不到的。
- Alfred与hs实际上可以做到互补，作为自动化，效率化的两款神器。


## 参考文档
这种简单工具使用，没有什么比官网更合适的资料了。

- [https://www.hammerspoon.org/](https://www.hammerspoon.org/)
- [Lua 教程](https://www.runoob.com/lua/lua-tutorial.html)