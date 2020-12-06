---
title: React componentWillUnmount的局限性
tags:
  - React
  - JavaScript
abbrlink: 5d45162e
date: 2020-12-05 16:30:03
---

> componentWillUnmount意味着组件即将销毁时触发该钩子，但假如用户直接关闭浏览器tab，则该钩子时是不会被触发的。

这个问题在特定的场景下需要考虑，比如我在做websocket相关开发时，场景是用户进入某详情页，即开启文章topic订阅，当用户切换到其它URL时，该文章订阅即取消，因此我将这个取消订阅的动作放在了componentWillUnmount中，但假如用户直接关闭TAB页，则程序无法知道，因此就会BUG。

## Why?
直接关闭Tab意味着直接销毁该tab页的HTML，JS，CSS资源，因此react的lifecycle就更不会执行了，因此在实际开发中要意识到该钩子的局限性。


## 原生window beforeunload 事件

以上问题可以通过原生window beforeunload 事件互补解决。例子如下

```javascript
  constructor(props) {
    super(props);
    window.removeEventListener('beforeunload', this.listener);
    window.addEventListener('beforeunload', this.listener);
  }

  listener = function(e) {
    console.log('will unmount');
    e.returnValue = '';
  };
```

## 写在最后


- 如果即可实现假如用户直接关闭网页，也可正常执行指定逻辑。
- 以上虽然可以解决，但有一点注意即该事件尽可能放在根组件之类的，原因很简单，如果实在循环列表组件中进行绑定，则开销巨大，这点需要注意。
- 这里虽然谈的是React的componentWillUnmount，但Angular,Vue等JS类库面临同样的问题。





