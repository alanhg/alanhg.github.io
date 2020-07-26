---
title: package.json中的一些使用技巧
date: 2020-07-26 10:32:44
tags:
- NodeJS
- npm
---

[toc]


> 对于package.json这个文件，我们并不能只知道依赖与开发依赖，丰富了解，善用package.json可以让我们的应用更改健壮，开发更高效

## 强制开发者使用yarn而不是npm进行装包
总有那些不细心观察项目的人使用npm进行装包，最好的办法不是文档，而是自动检测。

1. 添加 script
package.json

	```json

  "scripts": {
    "preinstall": "node ./scripts/checkYarn.js"
	}
	```
	- npm 会在装包命令启动前执行该script.
	- preinstall,prepublish是内置的一些[钩子](https://docs.npmjs.com/misc/scripts)，当然实际上开发中我们会丰富拓展我们自己的比如start，build之类的。

2. checkYarn.js

	```js
	if (!/yarn\.js$/.test(process.env.npm_execpath || '')) {
  console.warn(
    '\u001b[33mThis repository requires Yarn 1.x for scripts to work 	properly.\u001b[39m\n'
  )
  process.exit(1)
	}
	```
	当使用npm install直接报错。
	
	![](https://static.1991421.cn/2020/2020-07-26-103535.jpeg)


## 限制node,yarn版本
> 开发环境的版本不一致会是个问题，比如之前yarn1.0之前，对于安装包，部分没有哈希值指纹，假如大家的yarn包不一致，一旦装包，这个文件反复在变。所以保证开发环境一致极端重要。

package.json

```json
  "engines": {
    "node": ">=10.16.0",
    "yarn": ">=1.16.0"
  }
```

注意，版本号也是个闭区间比如“10.15.0-10.16.0”。



