---
title: Surge实现根据WI-FI情况自动调整代理策略
tags:
  - Surge
abbrlink: 44d2c58d
date: 2021-02-06 11:59:35
---
> 假如家里路由级已经解决了科学上网，那么Mac等终端设备是没必要再重复开启代理的，不然速度会更慢，性能开销也属浪费，但是当出了家门，连到公司Wi-Fi，又或者在咖啡厅，那么又需要开启代理。OK，这个过程完全是固定模式，有办法自动吗？YES。

Surge提供了Event脚本支持，即可做到以上需求。

官方文档，参考[这里](https://manual.nssurge.com/scripting/common.html)

## 配置

主配置文件，增加以下配置

```
[Script]
script1 = type=event,event-name=network-changed,script-path=wifi-changed.js
```

wifi-changed.js脚本内容如下

```javascript
/**
 * @description
 * 如果是家里WI-FI则开启直连模式
 * 如果不是家里WI-FI则开启代理模式
 */
const WIFI_DONT_NEED_PROXYS = ['xiaomi_Alan_5G'];

if (WIFI_DONT_NEED_PROXYS.includes($network.wifi.ssid)) {
  $surge.setOutboundMode('direct');
  $notification.post('Surge', 'Wi-Fi changed', 'use direct mode');
} else {
  $surge.setSelectGroupPolicy('Final-select', 'Group');
  $surge.setOutboundMode('rule');
  $notification.post('Surge', 'Wi-Fi changed', 'use rule-based proxy mode');
}

$done();
```



这样，WI-FI变动下即可自动切换代理策略了。



![](https://static.1991421.cn/2021/2021-02-06-121252.jpeg)



## 写在最后

不得不说Surge做的真的很棒，有效的解决了网络方面的相关需求。
