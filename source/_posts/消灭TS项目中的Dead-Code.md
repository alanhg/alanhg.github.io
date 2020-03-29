---
title: 消灭TS项目中的Dead Code
date: 2020-03-29 22:52:46
tags:
- dead code
- TypeScript
---
> 实际项目开发中，总是会有很多dead code，这些dead code毕竟也是code一部分，占用项目体积事小，但是却对开发造成了困扰，因为你可能改了半天发现不起作用，因为这段代码根本就不执行。
所以面对dead code，个人的认知是一律删除，假如所谓的说辞是"万一以后要用呢！"，我一般的回答是"几月几号呢？当前的代码管理都有Git,本身就存在完整的历史，所以不要为自己的懒惰和不专业找说辞，删！"

当然Team人员的水准参差不齐，认知也不一定一致，最好的办法并非是反复去为他们的错买单，反复指导，而是强制规则约束，及这样一篇有那么几分道理的文章去解释即可。

OK，开搞


![](https://i.imgur.com/rWPKXiP.png)

## TSConfig内置配置
TS配置器，本身就有这样两条规则，来减少dead code.
```json
"compilerOptions":{
 "noUnusedLocals": true,
 "noUnusedParameters": true,
}
```

### noUnusedLocals
没有用到的局部变量就会报错，如下

![](https://i.imgur.com/IuDMVrf.png)

### noUnusedParameters

没有用到的函数参数即报错，如下

![](https://i.imgur.com/Z6GHChP.png)

#### 规避报错
这里说下如何规避这类报错，原因是有时，有些参数确实不用但是又需要声明，比如回调，参数的下标毕竟是固定的，所以确实会存在一些无用的参数，仅仅只是充当占位符。

办法就是下划线开头，TS编译器检测会跳过这种，命名上建议可以用数字表示，这样也好明确参数下标

![](https://i.imgur.com/q8gMMhU.png)


## TSRule

### tslint-no-commented-code-rule
有些人习惯注释代码，所谓的以后删，基本就是一句空话，所以为此，这个规则就可以发挥作用，对于注释超过2行的代码直接报错提示。

![](https://i.imgur.com/QpzqwUi.png)

#### 配置

1. yarn add tslint-no-commented-code-rule -D
2.  tslint.json
	
	```json
	 "no-commented-code": [
      true,
      {
        "minLineCount": 2,
        "ignoredCommentRegex": "^(\\w+$|TODO|FIXME)"
      }
    ]
	```

### ～～～no-unused-variable～～～
这个已经不提倡，


## ts-unused-exports
通过TSC配置，TSRule已经将一部分错误检测出来，代码变的比之前清爽些，但是还有一块没有找出来，那就是无用的导出【函数，类，常量】。

TSRule是无法解决这个层面问题的，因为Rule当前只是单文件的检测。所以这个问题想解决毕竟在全局层面，比如TSC上支持。但是目前官方是不支持的。对此也有个讨论

- https://github.com/microsoft/TypeScript/issues/13408
- https://github.com/microsoft/TypeScript/issues/29293

本想着研究下解决这个，偶然看到已经有人实现了一版。

[ts-unused-exports](https://github.com/pzavolinsky/ts-unused-exports)

![](https://i.imgur.com/tars59f.png)

### 配置

1. yarn add -D ts-unused-exports
2.  ts-unused-exports ./tsconfig.json --showLineNumber --ignoreTestFiles

推荐将其配置在钩子里，比如`pre-commit`阶段，这样提交确保没有dead code引入


## 写在最后

1. 经过这些配置，可以确保代码的基本无冗余。当然规则只是一方面，更多的是team成员素质的提升与一致。
2. 代码整洁之道，这也只是其中一小步，还需要继续不断的发现问题和解决。



