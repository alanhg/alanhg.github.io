---
title: '[译]Boostrap3 vs 4'
tags:
  - Bootstrap
  - Bootstrap4
  - CSS
  - 译
abbrlink: cebcfde4
date: 2018-06-20 06:48:15
---
> Bootstrap于1月19日放出了4的正式版，4带来了一些重要的改变，添加了新的组件，同时也废弃了一些。这里是Bootstrap 3与4的区别

![](http://static.1991421.cn/2018-06-21-114624.png)

原文链接:[这里](https://www.quackit.com/bootstrap/bootstrap_4/differences_between_bootstrap_3_and_bootstrap_4.cfm)
## 组件差异
|组件|Bootstrap 3| Bootstrap 4|
|---|---|---|
|全局|||
|CSS源文件|LESS|SCSS|
|CSS主要单位|px|rem|
|媒体查询单位|px|px|
|全局字体大小|14px|16px|
|缺省字体集|Helvetica Neue, Helvetica, Arial, sans-serif|Uses a "native font stack" (user's system fonts), with a fallback to Helvetica Neue, Arial, and sans-serif|
|栅格化|||
|栅格参数 | 4种栅格系统(xs,sm,md,lg) | 5种(xs,sm,md,lg,xl) *Bootstrap 4已经删除了最小断点的的xs,因此col-*覆盖了所有所有设备`不再需要标明这种情况得尺寸了`*|
|偏移|用col-*-offset-*去偏移列,例如col-md-offset-4|用offset-*-*去偏移列，例如,offset-md-4.|
|表格|||
|黑色主题表格|不支持|增加dark表格样式，用`.table-dark`|
|Table表头样式|不支持|`.thead-light` 和 `.thead-dark`|
|紧缩表格|`.table-condensed`|`.table-sm`|
|状态类|Bootstrap 3 不用`.table-`前缀，例如Bootstrap 3 用`.active`然而Bootstrap 4 用`.table-active`,状态关键词都是(active,success,info,warning,danger)|添加`.table-`前缀来做表格的状态类
|响应式表格| `.table-responsive`必须添加到父级div元素上 |一样，同时增加了`table-responsive-*`来表明断点`.table-responsive-sm -md -lg -xl`|
|表单|||
|水平表单|使用`form-horizontal`|废除了`form-horizontal`，当需要使用栅格化的话，使用`.row`，同时引入`.form-row`类|
||Form布局的话使用`.control-label`进行栅格布局|使用`col-form-label-*`进行栅格布局|
|复选框与按钮|`.radio`,`.radio-inline`,`.checkbox`,`checkbox-inline`|`.form-check`,`.form-check-label`,`.form-check-input`,`.form-check-inline`|
|表单控件尺寸|`.input-lg`,`input-sm`|`form-control-lg`,``form-control-sm|
|表单Label大小||`.col-form-label-sm`,`.col-form-label-lg`
|Help Text|用`.help-block`显示帮助信息|`.form-text`|
|校验和反馈图标|包含所有校验状态样式,图标使用的glyphicons|去除校验样式|
|标题|不支持|提供`.col-form-label`用于legend标签|
|固定文本|用`.form-control-static`去渲染固定文本|`.form-control-plaintext`|
|自定义表单|不支持|支持|
|按钮|||
|样式|`.btn-secondary`不可用|去掉`.btn-default`，增加了`btn-secondary`,`btn-light`,和`btn-dark`|
|边框按钮|不支持|`btn-outline-*`为按钮增加边框颜色|
|按钮尺寸|`.btn-xs`可用|`.btn-xs`删除,`.btn-sm`,`.btn-lg`可用|
|控件组|
|Classes|使用`.input-group-addon`和`.input-group-btn`|废除了`.input-group-addon`,`input-group-btn`,增加了`input-group-prepend`,`.input-group-append`，也增加了`.input-group-text`用于空间组中文本|
|媒体对象|||
|Classes|`.media`,`.media-body`等|媒体对象可以直接使用flex布局类|
|下拉菜单|||
|结构|`<ul><li>`|`<ul><div>`均可|
|菜单头部|`.dropdown-header`|`.dropdown-header`用在`<h1>-<h2>`标记上，已不再使用`<li>`|
|分割线|`.divider`|`.dropdown-divider`|
|禁用菜单项|`.disabled`|`.disabled`|
|按钮组|||
|巨小?|`btn-group-xs`|废除`.btn-group-xs`|
|导航|||
|内联导航||`.nav-inline`|
|导航栏|||
|颜色||`.navbar-light`,`navbar-darl`,和`.bg-*`|
|导航栏对齐|`.navbar-right`,`.navbar-left`|使用spacing间距和flex布局|
|导航栏表单|`.navbar-form`|废除`.navbar-form`|
|固定导航栏|`.navbar-fixed-top`和`navbar-fixed-bottom`|`fixed-top`,`fixed-bottom`|
|分页|||
|缺省分页|`.pagination`|每个`<li>`或者`<a>`都要添加`.page-item`|
|翻页|`.previous`和`.next`|废除|
|超大屏幕|||
|全宽|`.jumbotron`|`.jumbotron-fluid`|
|Glyphicons|
|支持性|支持|不支持|
|印刷|
|引用|缺省使用`<blockquote>`元素|引入`.blockquote`样式应用于`<blockquote>`元素上
|对齐|使用`.block-reverse`来右对齐|使用文本工具类`.text-center`和`.text-right`来对齐元素
|头部|`page-header`支持|`page-header`不支持|
|描述列表|使用`.dl-horizonal`来描述水平列表|水平列表的话，在`<dl>`上加入`.row`，在`<dt><dd>`上使用栅格系统|
|非响应式使用|
|支持性|支持|不支持|
|List Groups|
|链接列表，按钮列表|`.list-group-item`到a元素上|`.list-group-item-action`到a元素上|
|折叠|
|展示内容|`.in`|`.show`|
|卡片|
|支持性|支持|不支持|
|Panel面板|
|支持性|支持|不支持|
|Well容器|支持|不支持|
|缩略图|
|支持性|支持|不支持|
|路径导航|
|类|用`.breadcrumb`|同时也要求加入`.breadcrumb-item`用在li元素上
| 轮播 |
|轮播项|用`.item`|用`.carousel-item`
|附加导航（Affix）|||
|支持性|支持|不支持|

## 浏览器支持
![](http://static.1991421.cn/2018-06-27-040213.png)

## 写在最后
以上只是列出需要关注的差异点，具体还是看官网吧。
+ [官网](https://getbootstrap.com/docs/4.0/getting-started/introduction/)
+ [GitHub仓库](https://github.com/twbs/bootstrap)
