---
title: React中事件处理器命名规范【译】
date: 2020-04-11 14:50:00
tags:
- React
- JavaScript
- Convention
---
> 命名一直是个很有挑战的事情，需要做到的是一定的表意，一定的抽象，一定的言简意赅。之前看到一篇非常不错的文章【即该文】讲述一些事件处理函数的命名规范，其中的手法与我自己在实践中的一些认知一致，但解释的更为有理有力，这里翻译下，权当自己做了次复习，兴许也可以帮助一些Coder。


![](http://static.1991421.cn/2020/2020-04-11-184938.png)

虽翻译，仍推荐看下英文原版

[EVENT HANDLER NAMING IN REACT](https://jaketrent.com/post/naming-event-handlers-react/)


## 参数Props
当定义参数名称时，我通常以on来做前缀，比如一个onClick。这个做法与JS本身的事件机制一致，这么做，可以提供与其相似的事件处理函数。

## 函数命名
对于函数命名，我遵循相同的模式，但会使用 handle** 来替代 on**，比如handleClick。效果会是这样

```jsx
<MyComponent onClick={handleClick} />
```
on这个单词用于表明我们的函数绑定到的事件，而handle表明事件触发后调用了谁。

注意，我还会使用同样的动词，Click,这样的好处是，我们可以了解这是一个click事件的发生。比如点击操作，一个alert消失，有些人喜欢将这个函数命名为handleDismiss或者其它的叫法，但我倾向于保持与实际动作一致的命名。这是个非常好的映射方式。通常语义化的命名是被JS本身的事件机制识别的。


## 更复杂的命名
再复杂的命名应该也不会有[这个](https://zh.wikipedia.org/wiki/%E8%A5%BF%E7%8F%AD%E7%89%99%E8%AF%AD%E5%A7%93%E5%90%8D)复杂吧，想想事件更多，处理逻辑更多的场景。

比如有alert和form,命名可能会是这样

```jsx
onAlertClick={handleAlertClick}
onFormSubmit={handleFormSubmit}
```

在单词顺序上，我喜欢名词在前，比如Alert，紧接着再是动词click，其它的事件也是这个理念去做。这样当按照字符排序时，一类的会在一块。

```jsx
onAlertClick={handleAlertClick}
onAlertHover={handleAlertHover}
```


## 组件拆分
关于如何下手拆分组件，实际上是一个热门的话题，也是一门艺术。单看命名这里，一个看法是，如果我们面对一个模块中有多个事件处理器定义，那么我们将缺乏一些抽象，因此，我们应该拆开，从而可以更好的封装。比如下面这个例子


```jsx
onRegistrationSubmit
onLoginSubmit
```

拆分后，我们可以得到这样简洁的命名

```
onSubmit in registration-form.js
onSubmit in login-form.js
```


## 内置事件命名
有些事件处理器是React内置的，比如onClick，onSubmit，它们会在button或者form中触发。

当我们使用这些名称传递到我们的自定义组件时需要小心。比如你可能根本不需要这个组件是可点击的。

为什么有这个担忧，因为比如我们在使用参数时，用到了扩展运算符。所以有时候名称一致也会是个麻烦，这个取决于使用场景。

```jsx

function MyComponent(props) {
  return <div {...props}>Stuff that might really need the onClick...</div>
}
```


如果我传递一个onClick参数到一个组件中，使得可以内部使用，但同时我又会去解构使用所有的参数，那么我会很小心的确定命名。因为我并不想使div成为可点击的。

## 写在最后
- 之前看过重构一书，很认同里面的一个观点，就是变量命名是需要思考的，也是可能会在逐步的重构中变化的，总而言之是需要花心思的，并非随意一写。
- 上述文章中作者对于事件处理函数的命名的观点我非常赞同，尤其比如将组件拆分后，本身组件就具备了上下文，所以函数命名上就可以一定的精简，从onRegistrationSubmit到onSubmit.这个变化，就等同于，有时，比如遍历一个country数组，需要使用临时变量，我就很不喜欢写成country，因为在country数组这个明确的上下文时，其实我们命名为item，这种抽象的项没什么不好，有时一定的抽象便于复用，退一步来说，即使拷贝了变成user遍历，至少里面的变量不用重命名，不是吗？
- 思维要活，不要太死。代码跟说话一样，不要说废话。
- 这篇文章对我的收益是至少前端事件函数的命名有了系统而科学的规范。当然还是得活学活用。


