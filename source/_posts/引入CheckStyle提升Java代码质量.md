---
title: 引入CheckStyle提升Java代码质量
date: 2020-03-15 20:33:57
tags:
- Java
---
> 最近参与部分后端开发，觉得后端的代码上有些乱，比如无用导入，无用变量，访问修饰符不合理等等，这类问题以前也吐槽了多次，但始终一直拖着没有去定标准，推进规范化。于是，趁着周末，下定决心搞一搞。
> 
> 与Java不同的是，前端JS/TS部分，因为有Husky+Tslint控制，风格层面就可以有效保障，难道后端就不行吗？肯定也可以。


## CheckStyle
用什么控制呢，关于技术选型，似乎毫无疑问，之前曾翻看ThoughtWorks的19年技术栈统计报告，对于代码风格控制这块，大多选择CheckStyle。

![](https://i.imgur.com/mTleaK6.jpg)

OK，随众

### 使用方式

关于如何使用，有以下几个方式

1. IDEA插件
2. Maven插件
3. 自写脚本

### 选择脚本

考虑了下，决定脚本实现，理由如下

1. IDEA插件目前的文件扫描范围是所有文件，并不支持只扫描changed files或者stage中的文件,`项目开源,so有兴趣的可以提PR支持下`
2. Maven插件可以做到构建打包阶段，或者测试阶段跑，但是无法做到在pre commit时候做检测
3.  脚本，可以自己编写pre-commit hook进行。但一个新入的dev就需要手动或执行命令将检测钩子放入.git/hooks下。

确定方案就开搞

## 具体配置

### 配置

配置所需文件如下

![](https://i.imgur.com/ykQ6mrs.png)

1. init.sh是作为开发初始化实施部署的，内容就是一个拷贝命令，这里`不支持Window默认的shell，当然用git bash可以`

	```bash
#!/bin/bash -e
cp pre-commit ../../.git/hooks/
chmod +x ../../.git/hooks/pre-commit
```
	
2. pre-commit
	
	主要的检测靠这个，具体的代码，[戳这里](https://gist.github.com/alanhg/baa359d064b17988bb8cd89a0bbe4c2e)。__注意，文件没有后缀。名字是Git的钩子，不可改。__
3. checkstyle.jar
	 
	 这个就是checkstyle的程序包
4. google_checks.xml
   
   自定义代码风格配置.想修改，增加规则等直接这里修改


## 实现效果
当提交时，有错，提交失败，并会提示具体的错误文件及行列号

![](https://i.imgur.com/3JOKl7Q.png)

就这么爽

## 前端钩子工具husky

之前一直有个疑问。husky如何做到的跟钩子集成

因为想做到Git提交时检测，这就一定跟钩子打交道。上面的操作，最终是把想执行的checkstyle命令放到了pre-commit钩子中去。那前端的Husky肯定也是一样的吧？

![](https://i.imgur.com/WnFB45q.png)

如上即为当我们安装了husky包时，实际上会创建一堆的Git钩子，而内容均是执行husky中的脚本命令，可以理解为脚本命令的参数就是husky给我们开的配置口子，这样一想，实际上与上面我们的方案是一致的。

我们执行`init.sh等价于npm i husky`


## 强行控制代码风格有必要吗？
如上开心的控制住了代码风格，当然因为依赖着git hooks,假如提交时候就是把hooks关了，真的没招，之前就遇到过这样的队友。

诚然我们也可以构建打包时也加上检测。所以不合法的开挂提交后，我们仍然能让这些代码构建失败，报红。

但，问题是，这些人没有意识到统一代码风格的价值。我觉得只能用这一张图来感化这些人了。

![](https://i.imgur.com/5VEPZ8j.jpg)

## 写在最后

经过如上的配置，终于解决了一直拖着的技术栈，同时有这么两点收获

1. Java代码风格的保障有了初步的方案，当然还可以继续再优化，比如是否可以自动修复一些错误呢？
2. Git的钩子机制有了更多的了解，也明白了husky是如何去实现的。

## 参考链接

1. [Introduction to CheckStyle](https://www.baeldung.com/checkstyle-java)
2. [使用 Checkstyle 检查代码风格](https://juejin.im/post/5bcb56286fb9a05d0e2e9bbc)
3. [在git commit前自动检查checkstyle](https://jimolonely.github.io/2018/09/28/java/007-checkstyle-idea-git-pre-commit/)
4. [拯救Java Code Style强迫症](http://insights.thoughtworkers.org/save-java-code-style-obsessive-compulsive-disorder/)

