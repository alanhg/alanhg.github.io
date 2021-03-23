---
title: package.json中的一些使用技巧
tags:
  - NodeJS
  - npm
abbrlink: 5db5ae2e
date: 2020-07-26 10:32:44
---




> 对于package.json这个文件，我们并不能只知道依赖与开发依赖，丰富了解，善用package.json可以让我们的应用更改健壮，开发更高效

## 强制开发者使用yarn而不是npm进行装包
总有那些不细心观察项目的人使用npm进行装包，最好的办法不是文档，而是自动检测。

1. 添加 script
package.json

	```json
	
	```

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



## License

如果仓库设置了`private:true`，则协议字段license可以不用设定，npm会忽视该设定，如果没有，则需要进行设定为任何一个协议，比如MIT，否则打包时会报错如下。

> No license field

注意，有时提示的协议缺失说的并不一定是项目根路径下的package.json文件，而是系统用户目录下的等。具体是哪个文件可以根据错误提示确定即可。

