---
title: Antd表格表头与内容单元格没对齐问题
date: 2020-02-05 18:15:08
tags:
- CSS
- Compatibility
- Browser
---
> 最近解决样式遇到了这样的问题，具体如图。

![](https://i.imgur.com/rB3RoI1.png)

如图即问题现象

## 复现
固定表头，设定百分比宽

## 排查步骤

- 测试发现Mac下Chrome`Version 79.0.3945.130 `无此问题
- Windows10下的Chrome`Version 79.0.3945.130`存在此问题
- Windows10下的Edge没事
- 浏览器拖拽到拓展屏无此问题

经过以上对比得到的线索-`系统，浏览器，不同屏幕`，基于这个方向调查，最终确定了。

## 问题原因说明

1. `PC端屏幕显示设置缩放比例`对页面布局会有影响

	![](https://i.imgur.com/46VkpbC.png)

	如果修改为100%，页面重绘，问题消失

2. 在Windows下，Chrome的滚动窗格默认是占据空间，但Mac并不会，这点与版本无关，与系统有关。Mac为何没事，比如Mac下的Chrome,注意到滚动窗格是不计算在宽度之内的，你可以理解为是不同的层

	![](https://i.imgur.com/sNtAceB.png)

3. 错位的直接原因是`Windows下设备像素比不是1时，表头的纵向滚动窗格与表格内容的滚动窗格宽度不一致，所以容器宽度与表格内容的宽度也不一致`，而列因为我们设定的宽度百分比，造成了两者宽度不一致，所以出现了这个问题。当我们手动将电脑的缩放比例改为100%，这时滚动窗格宽度也就都一致了，所以也就不存在不对齐问题。
    但为什么设备像素比不是1时，表头的纵向滚动窗格与表格内容的滚动窗格宽度不一致？不知道，maybe都算一个BUG。

### 设备像素比

问题搞明白了，顺便了解下背后的本质原因===_设备像素比_。

当我们修改了缩放比例，实际上修改的就是`设备像素比`,假如我们设定了150%，实际上设备像素比就是1.5，也就是比如普通的文本12px,但实际上物理显示的大小会是18px,当然我们CSS里提示的还会是12px。这就说明了，为什么有时网页看上去字体比别人大。

通过JS脚本执行，我们也可以获取实际上的`设备像素比`.

![](https://i.imgur.com/qUM7eQy.png)

## 如何解决
问题确定了，方案要么是控制滚动条宽度一致，要么就是让滚动条宽度不计算。这里我直接设定滚动条不占用空间

```css

.ant-table-small>.ant-table-content .ant-table-header{
    overflow-y: overlay !important;
}

.ant-table-fixed-header>.ant-table-content>.ant-table-scroll>.ant-table-body{
    overflow-y: overlay !important;
}
```

_注意_ overlay为只在`WebKit，Blink`内核浏览器下支持
>
Behaves the same as auto, but with the scrollbars drawn on top of content instead of taking up space. Only supported in WebKit-based (e.g., Safari) and Blink-based (e.g., Chrome or Opera) browsers.

摘自MDN

另，这里之所以开挂加 !important，是因为antd组件增加的滚动样式为行内式，为了work，必须这么做。

## 引用文档

- [View display settings in Windows 10](https://support.microsoft.com/en-us/help/4027860/windows-10-view-display-settings)
- [Window.devicePixelRatio](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/devicePixelRatio)
- [如何解决滚动条scrollbar出现造成的页面宽度被挤压的问题？](https://segmentfault.com/a/1190000017044563)
- [CSS MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/overflow)



