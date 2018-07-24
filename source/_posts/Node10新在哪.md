---
title: 【译】Node10新在哪
date: 2018-07-24 21:58:08
tags:
- Node
- 译
---
> 每一个玩Node的人都深陷版本旋涡，停上一段时间，差了好几版，我之前玩Node是v6，现在都v10了，可怕不可怕。有人说`前端十八个月难度翻一倍`，这话我信。所以新东西，还是尽可能积极跟进，Node v10发布有段时间了，这里翻译篇文章，介绍下亮点。

![Node.js](https://ws2.sinaimg.cn/large/006tKfTcly1ftkxbekhq8j30m805z0t3.jpg)
原文网址：[戳这里](https://levelup.gitconnected.com/whats-new-in-node-10-ad360ae55ee4)

Node.js v10于2018年4月24日已经发布，10月将进入[长期支持（LTS）](https://zh.wikipedia.org/wiki/%E9%95%B7%E6%9C%9F%E6%94%AF%E6%8F%B4)，我们来看下这次发布中指的关注的一些功能。
### 添加错误码
Node中的错误信息已被标准化。
在过去，处理错误是一件头疼的事。之前的错误只包含一个字符串信息，如果我们想根据特定的错误信息执行操作，唯一的办法是进行字符串的匹配。
因为错误处理需要额外的字符串匹配，即使是最小的更新也无法添加到下一个主要版本，这样才不破坏语义化版本。将错误信息解耦处理啊，这样开发者可以不引入破坏型更新的前提下改进错误信息。想了解更多，[戳这里](https://medium.com/the-node-js-collection/node-js-errors-changes-you-need-to-know-about-dc8c82417f65)

### N-API不再是实验性的
Node文档介绍，N-API作为构建本地化插件的API。这是独立于JavaScript运行环境的插件,并作为Node.js的一部分进行维护。这个API是跨Node.js版本的应用程序接口。它旨在与JavaScript引擎的修改与插件隔离，并且允许模块在一个版本下编译，无需编译却在另一个版本中直接运行。

N-API在Node 8中试验性引入，在10版中稳定。Node版本的更新将不会再引起模块的损坏，并且也会引入Node v6.x与8.x之间的兼容性。

### 原生Node HTTP/2更加稳定
Node 8引入了试验性的HTTP/2模块，这是一个重要的更新。HTTP/2提升了标准的HTTP协议。

- 多路复用
- 单一连接
- 服务器推送
- 优先级
- 头部压缩
结束试验阶段，原生HTTP/2模块将能够提升Node服务器从而提供更佳的WEB体验。

### V8引擎 v6.6表现提升
Node停止了V8 JavaScript引擎，Node.js v10中装了最新版本的引擎。对于浏览器，Chrome 66下的v8引擎v6.6能够减少转换和编译20-40%的JavaScript时间。因此，我们可以预期Node 10在这方面有更大的收益，同时它也提供异步生成器和阵列表现。
使用软件，速度至关重要，最新版的Node致力于提升这些。想了解更多，[戳这里](https://v8project.blogspot.com/2018/04/improved-code-caching.html)

### ES模块（ESM）更好地支持
```javascript
// ESM
import pkg from “./pkg”
export default { a, b: 2 }
vs.
// CJS
const pkg = require(“./pkg”)
module.exports = { a, b: 2 }
```
虽然在Node 10下，我们还没看到ES模块化的全支持，但是Node团队仍在努力，这个将会持续发展。
Node之前一直在用CommonJS(CJS),一个新的模块系统叫做ECMAScript模块（ESM）。Node已经朝着这个方向去努力。

Node集成ESM并不是很简单的意见事情，因为这点与当前的系统会有冲突。然而Node致力于找到一个解决方案，[Gil Tayar](https://medium.com/u/c845cd91bc98)围绕这个话题，写了一篇文章。感兴趣，[戳这里](https://medium.com/@giltayar/native-es-modules-in-nodejs-status-and-future-directions-part-i-ee5ea3001f71)

### 诊断追踪改进
事件追踪添加从而能够更可视化。这个心的两点能够用于提升计时和表现问题的分析。这个API能够允许用户打开或关闭事件，有能力按需去诊断问题。

### npm v6到来
npm最近从v5.7升级到v6.0，Node 10跟进了这个更新。npm的提升主要在表现，安全和稳定性上。v6想了解更多，[戳这里](https://medium.com/npm-inc/announcing-npm-6-5d0b1799a905)

### OpenSSL升级到 1.1.0
Node配备了现代化加密支持，支持使用新加入的ChaCha20加密和Poly1305认证。TLS 1.3最近刚敲定，等Node 10在10月份进入LTS的时候，将完全支持这个标准。
### ‘fs’函数有了Promise实验性支持
与文件系统交互式许多Node应用的主要功能，Node 10将增加给fs包增加Promise试验性版本。之前这些函数处理异步操作是通过callback，但可以使用Node 8附带的util.promisfy函数进行转换。现在开发者可以用promise实现fs，不需要其它额外的步骤。

#### 总结
Node团队持续推进新的功能，从而使开发者可以给用户构建更佳的体验。Node10未来会推出前沿的技术，使得错误处理，构建本地插件，和一些其它显而易见的提升。
Node10将从2018年10月份进入LTS直到2021年4月份。Node团队遵循特殊的奇偶发布周期。在进入LTS的同时，Node11也会在10月份发布。奇数版本意味着试验性的功能，而偶数版本都是LTS版本。这也将标志着Node 4长期支持的弃用。
快乐的JavaScripting吧！
