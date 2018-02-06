---
title: Safari无痕浏览模式检测
tags:
  - Safari
  - Frontend
abbrlink: 4d421bfa
date: 2018-02-06 21:59:47
---
> 为了能给用户提供个性化服务，所以有了Cookie小甜饼的存在，之后HTML5又有了localStorage，sessionStorage.
但是苹果的Safari浏览器在无痕浏览模式下是禁止localStorage操作，网页里存在此操作便会报错。
面对这种情况，我们前端可能需要去判断用户是否开启了无痕浏览模式，进而提醒用户。

## Show Code

```javascript
function isPrivateMode() {
  var isPrivate = false;
  try {
    window.openDatabase(null, null, null, null);
  } catch (_) {
    isPrivate = true;
  }
  return isPrivate;
}

if (isPrivateMode()) {
  alert("您的浏览器不支持本地存储，请关闭无痕浏览");
  window.location.href="https://support.apple.com/zh-cn/HT203036";
}

```
## 相关链接

[Apple官网无痕浏览介绍](https://support.apple.com/zh-cn/HT203036)

## 写在最后
这里之所以判别不用`localStorage`,`sessionStorage`，是因为`Safari 11`已经不适用，所以需要这样判断。
