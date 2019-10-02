---
title: Jest单元测试配置
tags:
  - Jest
  - React
  - UT
abbrlink: 492248be
date: 2019-10-02 21:09:05
---
> 最近在做公司级UI组件库，对于测试这块，决定继续沿用Jest。因为追求简单，果断舍弃拷贝粘贴这个捷径，从零开始进行配置。这里Mark下。

![](http://static.1991421.cn/2019-10-02-131039.jpg)

## 上概念
玩之前，先了解下Jest是干嘛的

> Jest is a delightful JavaScript Testing Framework with a focus on simplicity.

> It works with projects using: Babel, TypeScript, Node, React, Angular, Vue and more!

上述是官方的介绍，由此我们知道Jest不止适用于React，JS。

## 前端技术栈
贴下，我的前端项目使用的技术栈。

- React
- TypeScript
- antd

so，基于此，来配置测试

## 基本配置

### package.json

这里只贴出因为UT所需要安装的包

```json
{
  "devDependencies": {
    "@types/enzyme": "3.1.13",
    "@types/jest": "23.3.1",
    "enzyme": "3.5.0",
    "enzyme-adapter-react-16": "1.3.0",
    "identity-obj-proxy": "3.0.0",
    "jest": "23.5.0",
    "ts-jest": "23.1.4",
  }
}

```

### 各个包的作用
1. @types/** 

	所需类库的TS定义文件
2. enzyme

	一个测试工具，注意它只能用于react
	
3. enzyme-adapter-react-16
	
	服务于react组件测试
4. identity-obj-proxy

   mock对象，比如UT测试组件可能导入了图片或者less样式。
5. jest
   
   目标测试框架，肯定要安
6. ts-jest
   
   因为我们是用TS写的UT，so需要安装这个包，假如我们用JS写UT，那就可以删除这个包。

### jest.conf.js

```javascript
module.exports = {
  transform: {
    '^.+\\.tsx?$': 'ts-jest'
  },
  testMatch: ['<rootDir>/test/**/+(*.)+(spec.ts?(x))'],
  coverageDirectory: '<rootDir>/test-results/',
  testPathIgnorePatterns: ['<rootDir>/node_modules/'],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
  globals: {
    'ts-jest': {
      tsConfigFile: './tsconfig.test.json'
    }
  },
  moduleNameMapper: {
    '\\.(less)$': 'identity-obj-proxy'
  },
  setupFiles: ['<rootDir>/test/enzyme-setup.ts']
};

```
### script

```json
{
 "scripts": {
    "test": "jest --coverage --logHeapUsage --maxWorkers=2 --config ./jest.conf.js"
  } 
}
```

- coverage是为了显示测试代码覆盖率信息
- maxWorkers是为了提速UT耗时，这个值建议不用过大。

更多配置，[看官网](https://jestjs.io/docs/en/cli)

关于maxWorkers,可以看[这里](https://www.peterbe.com/plog/ideal-number-of-workers-in-jest-maxWorkers)

### jest中的配置关键点

1. 因为我这里的前端组件中有导入less文件，所以这里做了模块代理。
2. setupFiles之所以配置，是因为我用enzyme进行了react组件测试


## 遇到的问题

### test match 0

在实际跑UT，一开始发现出现了match为0.直接原因就是Jest找不到我们的test case。

![](http://static.1991421.cn/2019-10-02-124010.jpg)

解决办法是两点

1. testMatch确保路径正确
2. moduleFileExtensions要加上


## 写在最后

经过上述的配置，执行test命令，即可看到下面的输出结果。当然jest的配置比这里的多得多，这里只是个简单的起步，接下来就是根据实际情况逐步改进丰富了。

![](http://static.1991421.cn/2019-10-02-125402.jpg)

虽然只是粗糙而简短介绍，也希望能帮到大家吧。

## 参考资料
- [jest configuration - offcial doc ](https://jestjs.io/docs/en/configuration)
- [Jest单元测试配置和所遇问题解决办法](https://github.com/yinxin630/blog/issues/22)
