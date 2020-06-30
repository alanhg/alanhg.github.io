---
title: Failed to load response data
date: 2020-06-30 14:17:34
tags:
- Chrome
---
> 最近测试团队提出一个问题-Web有个请求`Failed to load response data`


![](https://static.1991421.cn/2020/2020-06-30-142100.jpeg)

于是开始了分析及解决，这里Mark下


## 排除情况
1. response.status是200，说明请求正常发起及返回
2. 该请求的返回体为空，但面对空返回体，Chrome显示是`This request has no response data available`，而这里显示并不同，所以不是这个问题

## 原因确定
因为排除掉了上述的原因，那么敲定一定是浏览器端的代码问题了，然后发现问题请求的代码执行后，紧接着是页面刷新。由此确定了====》是因为`立即刷新导致请求的response没有来得及加载造成的。`


## 问题复现
比如发起一个异步请求且没有返回体，响应回复后直接刷新页面，发现问题完美复现，但是比如刻意增加延迟2秒，则显示为`This request has no response data available`. 到此问题彻底搞明白了。


## 延伸


### Canceled
    
  我们平时谈到的请求状态是围绕着请求回复成功握手，进而返回的哥哥状态。但初次之外还有些其它情况，比如上述这种，还有canceled状态，该状态一般是因为JS脚本中人工中断了请求，或者请求还在处理中，而页面刷新所造成的。


## 写在最后
关于该问题的资料，在网上搜索发现并没有提到这种情况，因此记录下，兴许帮助些朋友。


## 参考文档

- [Chrome dev tools fails to show response even the content returned has header Content-Type:text/html; charset=UTF-8](https://stackoverflow.com/questions/38924798/chrome-dev-tools-fails-to-show-response-even-the-content-returned-has-header-con/38925237#38925237)




