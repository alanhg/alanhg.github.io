---
title: 利用工具提升前端代码质量-StyleLint
tags:
  - lint
  - front end
  - less
abbrlink: c976b46
date: 2020-10-08 21:19:59
---
> 前端三要素，HTML，CSS，JS，无论是SPA，还是MPA，HTML相对较少，所以对于代码风格的控制更多在于JS和CSS。对于JS，我们有ESLint，而对于CSS，推荐使用StyleLint。

这里简单介绍下如何配置

## 配置

### 安装包

```
$ yarn add stylelint-config-standard stylelint -D
```

### 配置文件

.stylelintrc.json

```json

{
  "extends": "stylelint-config-standard",
  "rules": {
    "number-leading-zero": "never",
    "selector-pseudo-class-no-unknown": [
      true,
      {
        "ignorePseudoClasses": [
          "/global/"
        ]
      }
    ]
  }
}
```

### package.json中脚本配置


```json
  "scripts": {
  	"lint-less": "yarn run stylelint \"src/main/webapp/**/*.less\" --syntax=less",
   	"lint-less:fix": "yarn run lint-less --fix"
   },
  "lint-staged": {
      "*.less": [
      "stylelint --syntax=less --fix",
      "prettier --write",
      "git add"
    ]
  }
```

注意

1. lint-staged中的脚本配置主要是为了保证提交时，只检测暂存区的部分文件，而不是所有。
2. `syntax`可以不写，CLI会自动检测，但个人认为明确更佳。

## 接下来？

如上只是简单的入门而已，实际的开发中，因地制宜，调整重写规则即可。当然如果跨项目，也可以利用私有包，搭配extends来实现共享配置。总之在开发中不断打磨即可。

## 写在最后
- 摆正认知，stylelint的使用与eslint都极其类似，毕竟理念都是一致的，两者只是面对不同的语言而已。
- lint控制的是风格，这样最大程度确保人员水平参差不齐及了解项目代码风格，连风格文档实际上都可以节省了，毕竟不遵守风格的代码会有友好提示及报错。
- 重视风格，重视规则。
