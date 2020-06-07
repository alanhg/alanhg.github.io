---
title: Alfred Workflow实现一键切换Maven设定
tags:
  - Maven
  - Alfred
  - Workflow
abbrlink: 5a73137b
date: 2019-08-18 23:32:29
---
> 因为公司项目需要使用公司的内部Maven资源，在家里并不需要，这样来回切换设置，很耗时。本着自动化的思想，考虑做个脚本来切换源。

## 脚本化-初步方案
在网上看到一位道友的文章-脚本切换，给了启发。这里贴下脚本化。

```bash
#!/bin/bash

base_dir=~/.m2
setting_home=settings_home.xml
setting_work=settings_work.xml

PS3='Please enter the number of your choice: '
options=("home" "work")
select opt in "${options[@]}"
do
    case $opt in
        "home")
        ln -sfn ${base_dir}/${setting_home} ${base_dir}/settings.xml
            echo "Switched setting.xml to home!"
            break
            ;;
        "work")
        ln -sfn ${base_dir}/${setting_work} ${base_dir}/settings.xml
            echo "Switched setting.xml to work!"
            break
            ;;
  
    esac
done
```
如上，即可实现交互式执行脚本来做切换。但这种方案还是需要每次执行下脚本。
有办法做到一键切换吗？有的！Alfred就可以。

## 打造Alfred Workflow-进阶方案

如何做呢？

###  添加input keyword

![](http://static.1991421.cn/2019-08-18-153917.png)

###  添加list filter

![](http://static.1991421.cn/2019-08-18-154603.png)

###   添加脚本执行

针对上面的脚本，进行下改进。

```bash
base_dir=~/.m2
setting_home=settings_home.xml
setting_work=setting_work.xml

if [ "{query}" == "home" ];
then
        ln -sfn ${base_dir}/${setting_home} ${base_dir}/settings.xml
else
        ln -sfn ${base_dir}/${setting_work} ${base_dir}/settings.xml
fi
```
#### mvn setting默认配置
这里贴下maven默认的settings.xml配置
[戳这里](https://gist.github.com/alanhg/3f52e12a45eb09778d569cb9b26d058d)

### 添加notification
为了提升体验，每次切换成功后，通知下。

### 最终效果

![](http://static.1991421.cn/2019-08-18-155747.png)

![](http://static.1991421.cn/2019-08-18-154741.png)

到这里，我们就可以做到一键切换Maven设定了。完美。

## 参考文档
- [Shell 脚本切换 Maven 的 settings.xml](https://windmt.com/2018/04/13/swith-maven-settings/)

