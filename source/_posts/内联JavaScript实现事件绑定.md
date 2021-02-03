---
title: 内联JavaScript实现事件绑定
tags:
  - JavaScript
abbrlink: 424aa3e7
date: 2021-01-26 16:17:08
---

> 框架类库极度流行，它们都提供了各种各样简单的方式来操作JS，也或者其他的语言技术。使用一时爽，更为可怕的是它们也会折叠一部分的认知。比如这里要说的内联JS实现事件绑定，在实际开发中确实不怎么使用，但不代表不会使用，且需要懂。



## React中事件绑定

先说下React中的事件绑定，React帮我们包装了一些事情。

1. 比如事件绑定，我们使用onClick，原生JS是onclick，一个是驼峰，一个是纯小写，很好区分

2. React下比如一个列表我们循环增加事件绑定，不会造成性能的浪费，因为React最终还是会实现事件委托，当然写法上，还是不建议，每个单独的事件绑定，毕竟source code维护及调试也会是个问题

3. React下进行事件绑定，我们可以方便的拿到事件参数event，当然这个参数名字我们也可以自定义

   ```jsx
      <Button onClick={this.handleClickCancel}>
                 <GlobalI18n.CANCEL />
               </Button>
   
     private handleClickCancel = (e) => this.props.callback(e.target.id);
   ```



## 原生内联下的事件绑定

原生内联下需要如下写法

```html
    <p id="p">selectedIndex: <span>0</span></p>

    <select id="select" onchange="print(event)">
      <option selected>Option A</option>
      <option>Option B</option>
      <option>Option C</option>
      <option>Option D</option>
      <option>Option E</option>
    </select>

    <script>
      var selectedIndexEle = document
        .getElementById('p')
        .querySelector('span');

      function print({ target: e }) {
        selectedIndexEle.innerText = e.selectedIndex;
      }
    </script>
```

1. 内联如果想传递事件当参，需要准确的命名为`event`，比如`e`不行。

   ​	WHY？因为这里的`event`即`window.event`，是准确的引用调用，

2. 假如事件处理并不需要消费本身事件的任何特殊逻辑，比如阻止默认行为等，还可以改为`print(this)`，因为这是this指向的即是该DOM元素本身

3. 当然除了这两种方式，还可以Script标签中bind绑定事件，这样可以直接使用event，与React下类似。

   ```javascript
         document
           .getElementById('select')
           .addEventListener('change', function (e) {
             print(e);
           });
   ```

   

## 写在最后

问题简单，但很基础，开发中小心注意吧。