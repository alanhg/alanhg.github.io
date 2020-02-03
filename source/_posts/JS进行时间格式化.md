---
title: JS进行时间格式化
date: 2020-02-03 23:53:35
tags:
- JavaScript
---
> 最近WEB中对于时间格式化有了个性化需求，解决的同时，这里记录下。

## 需求一：走0时区
 为了时间显示统一化，要求按照0时区时间展示，因为之前我们都是封装统一的轮子-使用momentJS做的日期格式化，所以只需要在WEB启动时做下时区设定即可。

 ```typescript
 
 moment.tz.setDefault('Africa/Abidjan');
 
 ```

注意：`Africa/Abidjan`即是0时区



##   需求二：时间显示格式按照系统所在国家风格，时区统一

如果是en-us即en

```
2/3/2020
February 3, 2020 at 3:18 PM

```

如果是en-gb

```
03/02/2020
3 February 2020 at 15:17

```
`因为要求时区还需要维持0时区`，只是显示的形式按照国家走，所以无法直接利用moment就实现，因为moment格式化要么按照既定的时区走，要么就需要手动提供显示格式，很不方便，最后发现JS原生就有toLocaleDateString函数。

于是方案就出来了

```typescript
# 日期
moment().toDate().toLocaleDateString(navigator.language, {
  timeZone: moment.defaultZone.name
})

# 日期加时间
moment().toDate().toLocaleDateString(navigator.language, {
  timeStyle: 'short',
  dateStyle: 'long',
  timeZone: moment.defaultZone.name
})
```

## 浏览器语言
如上，既然支持了多区域时间格式化，如何测试呢。这就需要了解浏览器语言设定。这里有几点说明下

1. 浏览器作为应用程序，安装时，缺省语言走的就是系统语言
2. 浏览器本身支持个性化设定语言，所以浏览器语言可以与系统语言存在差异，但作为一个WEB，永远保持与浏览器一致，或者特殊需要，比如就一种语言等，这都说得通。所以并不需要跟着系统语言走。
3. 比如，Chrome语言如何设定，[戳这里](https://www.digitaltrends.com/web/how-to-change-your-language-in-google-chrome/)
4. 假如Chrome中我们将第一个语言按照如上例子的修改，刷新WEB即可测试显示效果


## 写在最后
虽是一个小问题，但这里记录下。
