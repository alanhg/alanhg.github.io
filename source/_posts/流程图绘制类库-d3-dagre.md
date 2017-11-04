---
title: 流程图绘制类库-dagre-d3
tags:
  - D3
  - dagre
  - JavaScript
abbrlink: f626e54c
date: 2017-11-04 19:54:27
---
> 最近项目需要实现前端流程图绘制，于是进行一次系统的技术调研，包括echarts,highcharts，jsPlumbs,jointJS,RaphaelJs,d3等。echarts,highcharts由于本身就没有很好的流程图模型，更适合柱状图，饼状图等，所以直接pass，其它的，经过对比，最终敲定了D3。


摘录一篇博文中的榜单，作者将这些流程图类库进行了总结，可以看出D3还是很厉害的。
![Score board](http://or0g12e5e.bkt.clouddn.com/blog/2017-11-04-121118.png)
博文链接，[点击这里](https://www.erp5.com/javascript-10.Flow.Chart)

决定用D3之后，如果直接D3来写，未免过于辛苦，查了一遍，找到了基于D3的类库-dagre-d3.在使用中，随着不断的深入，对于这个类库有了充分的了解，百度还是谷歌，觉得资料都太少了，尤其中文，
这里，将其总结下。

## dagre-d3-你需要知道的几点

### 干嘛的?
`Dagre`是一个能够在客户端轻松创建流程图的`JavaScript`类库，而dagre-d3可以理解为是Dagre的前端，它使用D3来进行渲染。

### 项目活跃度
`dagre-d3`能够有1K+的星星数，说明这个类库还是很受欢迎的，但是无论是dagre还是d3-dagre已经处于非活跃状态，作者本人已经不再维护了。

### 用法
这里直接上一个简单的demo，说明下

[源码看这里](https://github.com/alanhg/angular-demo)

html部分

```html
<div class="container">
    <div class="col-sm-6">
        <svg width=960 height=400>
            <g/>
        </svg>
    </div>
</div>

```

```typescript
// 缩放功能实现
 let svg = d3.select("svg"),
            inner = svg.select("g"),
            zoom = d3.behavior.zoom().on("zoom", function () {
                inner.attr("transform", d3.event.transform);
            });
        svg.call(zoom);
 // Create the input graph
this.g = new dagreD3.graphlib.Graph({});
// 添加节点
this.g.setNode(0, {label: 'VVV'});
this.g.setNode(1, {label: "A"});
this.g.setNode(2, {label: "B"});

// 添加边
this.g.setEdge(0, 1);
this.g.setEdge(0, 2);

// 渲染
this.render(inner, this.g);
```
