---
title: 网站添加opensearch
abbrlink: 7b570d4
date: 2018-02-19 20:33:27
tags:
- WEB
---
> 对于一个具备检索功能的站点，除了本身在站点内部点击页内检索等外，可以通过添加配置文件，从而让浏览器自动发现和提示添加新的搜索插件/扩展到浏览器的搜索栏中。

Firefox下
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-02-19-131050.png)

Chrome下
![](http://or0g12e5e.bkt.clouddn.com/blog/2018-02-19-134323.png)

当然前提是`网站本身具有搜索且支持GET参数传递`即可。建立在这样一个前提下，向下看。

## 编写OpenSearch描述文件

`vi content-search.xml`

```xml
<OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/" slick-uniqueid="3">
  <div>
    <a id="slick_uniqueid"/>
  </div>
  <ShortName>进击之路</ShortName>
  <Description>文章检索</Description>
  <Contact>qianghe421@163.com</Contact>
  <InputEncoding>UTF-8</InputEncoding>
  <Url type="text/html" template="https://1991421.cn/tags/{searchTerms}"/>
  <Url type="application/x-suggestions+json"
       template="https://1991421.cn/tips?q={searchTerms}"/>
  <Image height="32" width="32" type="image/x-icon">https://1991421.cn/favicon.ico</Image>
</OpenSearchDescription>

```
## HTML中添加引用

```html
<link type="application/opensearchdescription+xml"
href="opensearch.xml" title="文章检索" rel="search" />
```

### suggestion支持，后端返回结果集格式

```javascript
res.json(["fir", ["firefox", "first choice", "mozilla firefox"]]);

```
其中，fir为用户输入的关键词

## 写在最后
上述只是使用了部分设定，更详细的设置，看[这里](http://www.opensearch.org/Specifications/OpenSearch/1.1)