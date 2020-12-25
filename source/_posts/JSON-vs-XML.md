---
title: JSON vs XML
tags:
  - JSON
  - 数据交换格式
abbrlink: 64eb705f
date: 2020-12-20 22:52:12
---

> 前后端分离的今天，后台提供的API一般都是JSON格式数据，但要知道这只是一种格式选项，其它有很多，比如XML。并不是任何服务通讯，前后端通讯都会使用JSON，一些服务我们也会明确使用XML而非JSON。因此对于两种格式的区别需要明晰，这样才能按需采用。

![](https://static.1991421.cn/2020/2020-12-21-220255.jpeg)

## 定义

了解一个技术先从命名及发音开始，具体JSON，XML的介绍见WIKI

JSON：JavaScript Object Notation

	- 发音：JAY-sawn

XML：E**x**tensible **M**arkup **L**anguage

		- 发音： /ˌeks em ˈel/

### 为什么XML不叫EML？

好奇这点，于是Google了下，找到了相关的[问题](https://softwareengineering.stackexchange.com/questions/88405/why-is-xml-not-called-eml)，相对准确的答案是确定XML时，委员会成员都提出了自己建议的全称及简称，其中一个便是`XML：Extensible Markup Language`,根据投票结果最终敲定了使用`XML` ，X代表着anything、特别、很酷， 并且在数学领域，代表着变量，未知，可能。

难怪coding领域naming一直是一件_难事_

## JSON vs XML

在实际的开发中，选择数据格式的前提是了解区别，这里列出关键Diff

- JSON相比较XML`体积`更小，`解析速度`更快
- JSON不支持`注释`，XML支持
- JSON有明确的`数据类型`有(字符串，布尔，数字，对象，数组，null)6种`数据类型`，XML对于数据类型没有限制
- XML支持`命名空间`，而JSON不支持

个人比较赞成知乎上一个朋友的[回答](https://www.zhihu.com/question/25636060)

> json的存在是典型的20%功能解决80%需求。
> 为什么不要xml？因为里面80%的功能你不需要，等你需要的时候你就明白，这事只能xml干，json不行。



## JSON序列化与反序列化

了解了JSON，XML就需要了解序列化问题，这中间也有坑存在。

以JSON为数据格式，语言为Java，JavaScript，来说明下使用中需要注意的几个点，不注意就妥妥的坑。

### Java

1. 实现`Serializable`接口的类必须要提供一个`public的无参构造器`，如果没有无参数的构造函数，在运行时会抛出异常：`java.io.InvalidClassException`

2. MVC controller中传输的对象`不需要`实现Serializable也可以传输是因为controller传输的不是对象而是将对象与网络报文绑定，并不涉及序列化及反序列化

3. 日常使用的Jackson及Gson库在进行序列化和反序列时，目标类`不需要`实现Serializable接口的。

4. 在实现了序列化的类文件，经常会看到serialVersionUID变量

   serialVersionUID是为了控制版本是否兼容，如果我们认为修改bean是向后兼容，则不修改，反之则提高值。如果不显式定义serialVersionUID的值，Java会根据类细节自动生成serialVersionUID，如果对类源码修改，重新编译，serialVersionUID可能会变化，serialVersionUID的默认值依赖于Java编译器的实现，因此为了确保安全，手动声明比较好。

### JavaScript

1. JSON.parse之后的对象get方法是undefined

   

   ```typescript
   class Person {
     firstname: string;
     lastname: string;
   
     get fullname(): string {
       return this.firstname + ' ' + this.lastname;
     }
   }
   
   const p = new Person();
   p.firstname = 'alan';
   p.lastname = 'he';
   console.log(p.fullname); // alan he
   
   const p2 = JSON.parse('{"firstname":"alan","lastname":"he"}') as Person;
   console.log(p2.fullname); // undefined
   ```

   反序列化之后对象不具备类中定义的方法，因此需要实例化一个类对象，比如下面的做法

   ```typescript
   const userJSONObj = JSON.parse('{"firstname":"alan","lastname":"he"}');
   const p2 = new Person(userJSONObj['firstname'], userJSONObj['lastname']);
   console.log(p2.fullname); // alan he
   ```



## 参考文档

- [JSON vs XML: What's the Difference?](https://www.guru99.com/json-vs-xml-difference.html)
- [[Typescript method on class undefined](https://stackoverflow.com/questions/43367692/typescript-method-on-class-undefined)](https://stackoverflow.com/questions/12702548/constructor-overload-in-typescript)
- [Serializable和Externalizable浅析](https://my.oschina.net/wangmengjun/blog/1588096)

