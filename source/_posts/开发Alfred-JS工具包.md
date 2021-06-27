---
title: 开发Alfred JS工具包
date: 2021-06-27 16:02:37
tags:
- Alfred
- JavaScript
---

> 因为本人主要从事前端开发，于是Alfred的workflow更多是采用JS去写，但是每次都重复在写Script Filter，参数拆分拼接等等，于是萌生了开发个JS工具包的念头，这样以后workflow中常用的代码块直接调用即可，效率必然高不少。
>
> 心动不如行动，开搞。

这里贴出我的工具包地址，[戳这里](https://www.npmjs.com/package/@stacker/alfred-utils)。相关开发直接安装即可使用



好奇源码的，访问该仓库GitHub地址。



这里了解开发中的几点设计。

## 技术栈

- TypeScript
- NodeJS

其它UT/hooks/CI也一个不少

## 技术上几点说明

- 这里使用TS-ESModule进行编写，最终TSC编译成CommonJS即可。因为这里只是服务于Alfred，一定是Node环境，因此只输出CommonJS版，当然如果想输出ES版也很简单，增加配置文件即可

- 当前的IDE对于TS支持已经非常棒，因此TSC编译时，选择输出.d.ts文件
- standard-version进行server版本管理
- 整个版本发布采用GitHub Action进行自动发布，同时发布OK会telegram消息推送我
- 为了确保类库的健壮性，增加hook进行UT检测

## 几个坑

- TSC编译是增量编译，因此需要每次先rimraf文件夹比较好

- .gitignore/.npmignore/Package.json-files区别需要搞清楚，配置影响最终发布的文件

- TSC默认会将所有TS进行编译，因此需要明确包含哪些文件，比如Test不需要编译

- 为了方便用户导入使用，往往我们会增加一个index文件，而其中写法需要注意

  ```typescript
  export {default as http} from './http';
  export {default as utils} from './utils';
  ```

- TypeScript支持直接CommonJS模块编写，但是我们也可以使用ES语法编写模块，而最终编译成CommonJS即可，这里即是采用的该方案

## 包使用

```shell
npm install @stacker/alfred-utils --save
```



```js
const { utils, http } = require('@stacker/alfred-utils');

utils.outputScriptFilter({
      items: utils.filterItemsBy(items, query, 'title')
 });
```



如上即时工具包的简单用法。



## 写在最后

工具包将开发中常见操作抽象封装，这样具体使用时只需要消费即可，以后开发workflow可以更快也更安全了。
