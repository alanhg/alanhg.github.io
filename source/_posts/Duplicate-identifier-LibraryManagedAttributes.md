---
title: Duplicate identifier LibraryManagedAttributes
tags:
  - TypeScript
  - Yarn
  - NodeJS
abbrlink: 6874b85d
date: 2019-12-24 13:43:47
---


> 最近升级前端某个包时，报以下错误。经过分析，最终fixed，这里Mark下

![](http://static.1991421.cn/2019-12-24-034917.png)

## 原因

查看具体报错意思是存在两个版本的React类型定义。

![](http://static.1991421.cn/2019-12-24-053024.png)

![](http://static.1991421.cn/2019-12-24-053111.png)

yarn.lock`中@types/react`版本,注意有两个

![](http://static.1991421.cn/2019-12-24-053203.png)


### 解决办法

### TSC配置skipLibCheck`错误姿势`

假如在tsconfig.json中增加skipLibCheck配置，重新进行TSC编译，实际上是OK的，但不建议这么做，因为这样是在放弃部分的类型安全。so，别这么做，虽然可以。

### Package.json `当前做法`
增加以下配置
```json
"resolutions": {
    "@types/react": "~16.8.19"
  }
```
重新执行yarn命令，再看lock会发现，版本只有一个了。

![](http://static.1991421.cn/2019-12-24-053955.png)

### 其它办法
除了上面的解决方案意外，我们可以手动或者[工具化](https://github.com/atlassian/yarn-deduplicate)删除多出来的重复包问题，当然lock文件难免要修改。

## 参考资料
- [Yarn upgrade creates duplicate dependency resolution #3967
](https://github.com/yarnpkg/yarn/issues/3967)
- [yarn-deduplicate](https://github.com/atlassian/yarn-deduplicate)
- [TypeScript Compiler Options](https://www.typescriptlang.org/docs/handbook/compiler-options.html)
- https://eggjs.org/zh-cn/tutorials/typescript.html
- [yarn selective-version-resolutions](https://yarnpkg.com/en/docs/selective-version-resolutions)
- [package-lock.json和yarn.lock的包依赖区别](https://segmentfault.com/a/1190000017075256)
