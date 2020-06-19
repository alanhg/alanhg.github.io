---
title: 项目中Less与CSS modules的实践
tags:
  - CSS
  - CSS Modules
  - Less
  - FrontEnd
abbrlink: 32c4cd52
date: 2019-09-01 22:46:00
---
> 最近接手的项目前端，关于样式这块用到了Less和CSS modules，这里梳理总结一番。
 
![](https://static.1991421.cn/2019-08-26-145228.jpg)

show实际代码之前，有必要先从背景上了解下两者。

## Less为何物
我们要知道，前端三要素，CSS，HTML，JavaScript。CSS主打样式问题，HTML主打内容，JS控制交互，这是基础，也是基石。

但我们也知道CSS过于僵硬，你可以说它写的都是静态量。我们习惯于面向对象，我们习惯于公式，另外即使对于CSS，我们也希望能够DRY。等等。so能不能加强下CSS呢。那么LESS就出来了。

> Less (which stands for Leaner Style Sheets) is a backwards-compatible language extension for CSS. This is the official documentation for Less, the language and Less.js, the JavaScript tool that converts your Less styles to CSS styles.

一句话，LESS是CSS预处理器。除了LESS，还有SCSS，但大差不差。最终在现有项目中，我确定用LESS。

原因有两个

1. UI组件库我们选择了antd，antd本身使用的是LESS,尽可能与其保持一致有利于我们UI整体的掌控
2. 写法上，个人习惯了Less

## Less优势

less的优势，也正是css本身无法解决的痛点，正如上面所介绍的，使用less可以让我们，利用变量和公式等更好的重用CSS。

## CSS Modules为何物
> A CSS Module is a CSS file in which all class names and animation names are scoped locally by default. All URLs (url(...)) and @imports are in module request format (./xxx and ../xxx means relative, xxx and xxx/yyy means in modules folder, i. e. in node_modules).

`一句话来说就是一个CSS模块就是一个CSS文件，文件中所有的类名和动画名都有其各自的作用域。`

### 唠叨下我上一个项目前端

> 先说下之前的项目，使用了less，没有使用CSS module，对于样式没有局部作用域和全局作用域的区分，样式命名上也是群星璀璨。最终对于样式这块带来的严重的后果就是，会出现很多的!important,很多的拆了东墙补西墙。样式整体也没有很好的规划设计，复用性为0.维护性我认为也为0`悲观来说`

怎么解决呢。为此，我痛定思痛，决定使用CSS Modules。

## 上代码

### 项目技术背景
- TypeScript`~3.3.1`
- React`16.4.2`
- Webpack`4.17.1`

了解了背景前提，开搞。

## typings.d.ts
为了支持Less在TS组件下以模块形式导入，需要做下声明

typings.d.ts

```typescript
declare module '*.less';

```

## Webpack.js

webpack中需要增加对应的rule

```javascript
{
        test: /\.less$/,
        use: [
          require.resolve('style-loader'),
          {
            loader: require.resolve('css-loader'),
            options: {
              importLoaders: 1,
              localsConvention: 'camelCase',
              modules: {
                mode: 'local',
                localIdentName: '[name]-[local]-[hash:base64:5]'
              },
              sourceMap: options.env !== 'production'
            }
          },
          {
            loader: require.resolve('less-loader'),
            options: {
              javascriptEnabled: true,
              sourceMap: options.env !== 'production'
            }
          }
        ]
      }
```

有几点注意

1. sourceMap配置是为了在开发环境下，方便Less调试
2. css module的开启是在css-loader，而非less-loader中
3.  localIdentName中定义的命名规则，我采用了烤串命名法，当然小蛇命名法也可以


## React项目下样式书写

### local

footer.less

```
.footer {
  background-color: rgb(0, 0, 0);
  color: #999999;
  padding: 49px 155px 70px;
  font-size: 14px;
  letter-spacing: 0;
  text-align: left;
  line-height: 18px;
  }
```

![](https://static.1991421.cn/2019-09-01-134344.png)

#### 最终效果


![](https://static.1991421.cn/2019-09-02-115014.png)

注意

- 假如在less中，我们使用了烤串命名法比如.footer-bg，在组件中使用仍然会是驼峰 footerBg
- 个人建议CSS模块化的样式，采用驼峰命名，这样保证了组件与less文件中的一致性。非模块化样式，即我们要global的，采用烤串命名法，两者予以区分。


### global
全局样式的书写只要加上:gloabl选择器即可。global标明全局作用域后，编译时，不会增加hash指纹

```css
:global {
  .table-tip {
    font-family: @font-bold;
    font-size: 12px;
    color: @blue;
    letter-spacing: 0;
    text-align: center;
    background: @light-blue;
    border-radius: 5px;
    padding-top: 16px;
    padding-bottom: 16px;
    padding-left: 22px;
  
```

全局样式在各个组件下都可以正常使用，使用方式时直接className即可

```html
<div className="table-tip">
            <FormattedMessage id={'tip'} />
          </div>
```
#### 最终效果
![](https://static.1991421.cn/2019-09-02-114926.png)

## 样式整体规划设计
因为有了less和css modules的加持，对于项目整体的样式，我进行了下规划设计

### theme

app项目中，我单独建立了文件夹叫theme

```
.
├── antd.less
├── company.less
└── theme.less
```

- antd.less用于重写默认的风格，比如按钮颜色，窗体大小间距,表单样式等
- theme.less下定义字体变量，网站整体的基础色系等
- company.less的存在，是因为我考虑提取在项目开发的同时，将项目通用样式抽离到company下，形成一套公司统一风格的UI样式，因为当前背景时公司的N个项目遵从统一的风格，那么在这个项目推进的同时，将其抽离出去，以后只要同步了theme整个文件夹，那么基础UI就有了。DRY嘛。假如不考虑项目样式的重用性，这个文件可以删除。

### app.less
这里是用于全局`global`的样式定义，当然也会导入theme下声明的antd样式，从而在加载时覆盖了默认的样式，同时导入了theme变量。

### component.less
有了全局的样式，再加上全局定义的一系列变量，那么对于单个组件下，只需要按需创建自己的个性化样式即可。对于字体及颜色等通用值设定，导入theme.less即可。

## 说说Angular下的样式模块化方案
因为之前我玩过Angular2，人家是个框架，自带全套解决方案。我们索性聊聊它是怎么处理样式模块化问题的。

`我们现在讨论的Angular指的是Angular2及以后，现在最新版本是`9.0.0-next.4`。`

贴下我写的组件样式，最终解析结果如下。

home.component.css

```css
h1[class='say hello'] {
    color: red;
}
```

![](https://static.1991421.cn/2019-09-01-140741.png)

看到这里你应该就明白了，它实质上是利用了CSS属性选择器做到了CSS模块化，对比CSS module的CSS类名方案，其实会发现两者异曲同工。

## 写在最后
假如不采用CSS Modules方案，利用BEM等也不不能解决问题。但不可否认，这个方案更优雅。基于以上的设定，我们的样式就不会出现意外影响，混乱不堪的局面。

当然好的工具是一方面，更重要的是使用工具的Team，形成统一的认知。so，加油！

## 相关文档
- https://github.com/css-modules/css-modules
- [CSS Modules入门Ⅰ：它是什么？为什么要使用它？](https://zhuanlan.zhihu.com/p/23571898)
- [CSS Modules 模块化方案](https://zhuanlan.zhihu.com/p/20495964)
- [BEM](https://css-tricks.com/bem-101/)
- [Angular组件样式](https://angular.io/guide/component-styles)
- [Case Styles: Camel, Pascal, Snake, and Kebab Case](https://medium.com/better-programming/string-case-styles-camel-pascal-snake-and-kebab-case-981407998841)
