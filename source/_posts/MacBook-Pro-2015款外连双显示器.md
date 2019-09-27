---
title: MacBook Pro 2015款外连双显示器
tags:
  - MST
  - 菊花链
  - MacBook
abbrlink: c8fc35be
date: 2019-09-26 23:15:53
---
> 主生产力机器还停留在Macbook pro2015款15寸【入职期，完美搭上公司清库存最后一批】，在公司办公受限于设备，也就是拓展到Dell24寸显示器上【生产力小有提高】，在家一直是`Dell U2515H`拓展屏模式。最近考虑提升下幸福感，打造外联双屏，so入手了`Dell U2719DS`。


在折腾外联两块屏幕时，也是花了点时间。同时，惊奇的发现，关于MacBook Pro拓展多屏竟然资料很少。我就雷锋一把，这里说说我的粗略认识喽。

## 终极目的
我想要的最终效果是，MacBook一根线缆输出，可以串联两个显示器[注意不是复制屏幕，而是拓展屏幕]。

`梦想`效果如下

![](http://static.1991421.cn/2019-09-26-142455.jpg)

## MST

支撑我有上述想法的，是这个技术。

> DisplayPort 多流传输允许您使用 DisplayPort v1.2 进行菊花链监控。"菊花链" 是指将一系列设备连接到一起使用两台设备之间的单个连接的功能。DisplayPort 菊花 chainable 显示器同时具有 DisplayPort 输入和 DisplayPort 输出。DisplayPort 输出连接到下一个下行显示器。在每组显示器之间使用一根 DisplayPort 电缆进行这种布线, 可提供不太杂乱的系统配置。


## MacBook Pro不支持MST？
MacBook是支持的，但一般显示器口是DP口不是闪电口，而MacOS不支持DP线缆MST【结论来自Dell官方论坛】，想一根线解决，就需要以高昂的价格购买Apple官方的显示器。

假如使用菊花链，我的两个显示器是镜像关系，而非拓展屏幕。

### 土豪玩家-Apple 官方LG显示器
假如使用官方LG显示器，因为支持闪电接口，so可以MST连接MacBook，我理解第二台显示器可以不是LG的，只要解决1，2显示器菊花链，并且开启DisplayPort 1.2即可。

## 最终方案
因为上述Apple不支持DP接口MST，最终的解决方案只能是笔记本mDP及HDMI两根线输出到两个显示器上，实现双拓展屏。效果图下。

![](http://static.1991421.cn/2019-09-26-145109.jpg)

### 使用线缆

1. mDP=>DP
2. HDMI=>DP

### 使用显示器
1. Dell U2719DS
2. Dell U2515H

## 写在最后
搭建这样的双屏后，一般我会合住笔记本开启主机模式，左竖屏用于看文档及网页，主屏用于开发。生产力又可以提升些许了。so，生命不息，折腾不止。

## 参考文档
- [Macbook Air 能否连双显示器（非苹果显示器）](https://www.zhihu.com/question/22600143)
- [MacBook Pro（Retina 显示屏，15 英寸，2015 年中）- 技术规格](https://support.apple.com/kb/SP719?locale=zh_CN&viewlocale=zh_CN)
- [如何使用 DisplayPort 多流传输 (MST) 链接到多台显示器](https://www.dell.com/support/article/hk/zh/hkdhs1/sln293813/%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8-displayport-%E5%A4%9A%E6%B5%81%E4%BC%A0%E8%BE%93-mst-%E9%93%BE%E6%8E%A5%E5%88%B0%E5%A4%9A%E5%8F%B0%E6%98%BE%E7%A4%BA%E5%99%A8?lang=zh)
- [U2518D, Dual MST, Mac Pro, only mirroring](https://www.dell.com/community/Monitors/U2518D-Dual-MST-Mac-Pro-only-mirroring/td-p/7278423)