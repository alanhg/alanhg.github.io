---
title: yarn.lock中的integrity
date: 2020-03-19 23:00:57
tags:
- yarn
- frontend
---
> 在提交代码时会发现yarn.lock文件有这样的diff，多了一些integrity属性，有时又会删除一些。不明所以，这里就简单梳理下该属性。

![](https://i.imgur.com/ZuxPmBc.png)

![](https://i.imgur.com/H7gXr8t.jpg)

## 作用
`确保资源完整性[包版本，内容]`，yarn down下来资源后，用计算出的integrity值与文件中的进行匹配，如果不一致，则安装失败。

## integrity值怎么算出来的
一般是`哈希值的生成算法=》base64编码`


## 为什么不是每个包都有?
__理论上每个包都应该有__


### v1.9.4
这里我复现下当时问题， 删除lock文件，重新执行yarn install,发现包还是没有integrity参数

 ![](https://i.imgur.com/m8wleBK.png)
 
###  v1.22.4
 删除当前lock文件，重新执行yarn install,发现每个包都有integrity参数了
  ![](https://i.imgur.com/X65ldCD.png)
  
### 结论
版本BUG，所以建议直接升级即可。  

## 参考文档

- [What is the integrity property inside yarn.lock file?](https://stackoverflow.com/questions/53540429/what-is-the-integrity-property-inside-yarn-lock-file)
- [Subresource Integrity](https://developer.mozilla.org/zh-CN/docs/Web/Security/%E5%AD%90%E8%B5%84%E6%BA%90%E5%AE%8C%E6%95%B4%E6%80%A7)
- [Resource Integrity](https://w3c.github.io/webappsec-subresource-integrity/#resource-integrity)