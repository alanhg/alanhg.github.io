---
title: TypeScript升级到v4
tags:
  - TypeScript
abbrlink: a3669cff
date: 2020-10-21 23:43:49
---
> 今天花了点时间进行了TypeScript的升级，好处是可以进一步使用TS/JS的新特性，比如短路赋值运算符等。这里简单Mark下升级细节。


*注意，TS只是类型，原则上升级并不会造成项目任何功能BUG，这点要明确_*

## 升级包

```json
{
 "typescript": "4.0.3"
 "@typescript-eslint/eslint-plugin": "^4.5.0",
 "@typescript-eslint/eslint-plugin-tslint": "^4.5.0",
 "@typescript-eslint/parser": "^4.5.0",
}
```
- 以上为主要升级的几个包，其它vendor相关使用，如果出现类型报错，对应升级最新包即可
- @typescript-eslint相关包之所以需要升级，是因为eslint使用了TS的parser，需要升级来保证对于TS@v4的支持

## 遇到的几个问题


1. Parsing error: Cannot read property 'map' of undefined

	![](https://static.1991421.cn/2020/2020-10-21-235644.jpeg)
	
	该问题升级如上的`@typescript-eslint`相关包即可解决
	
2.  Property 'canCostRelief' does not exist on type 'never'.
	
	>  Error:(1236, 35) TS2339: Property 'canCostRelief' does not exist on type 'never'.
  The intersection 'ISaeFeature & { selected: string; }' was reduced to 'never' because property 'selected' has conflicting types in some constituents.
	
 	ISaeFeature本身有selected属性定义，类型为boolean，而这里联合类型为string，所以TS最终类型降为never，因此明确最终真正类型即可解决
 	
3.  This expression is not callable.
	
	```typescript
	 (quoteDetail.quoteLines).every(quoteLine => 	checkQuoteLineMRP(quoteDetail, quoteLine));

	```
	
	如上`quoteLines`的类型是A｜B，但是checkQuoteLineMRP函数中对于quoteLine的签名类型是A，因此类型报错，毕竟A与B并不完全兼容，除非B继承了A。
	
	解决办法即是类型安全，比如`quoteDetail.quoteLines as A[]`，再比如改变checkQuoteLineMRP类型签名即可。

## 写在最后

- 开源虽免费，版本需谨慎。版本升级，从来也都是伴随着坑，当然，升级中遇到问题往往也是个学习的过程。
- 正如一开始所说，TS的升级可以进一步提升类型安全，同时可以更好的使用JS的新特性，因此，阶段性升级是有benefit的。
