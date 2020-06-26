---
title: JS开发调试下的断言实践
tags:
  - JavaScript
  - 断言
abbrlink: 11f23b63
date: 2020-06-25 00:53:46
---
> 一直以来有个不正确认识，就是断言只服务于测试。确实，在实际的项目中断言更多出现在了UT里，久而久之潜移默化下的我认为确实如此，然而这是错的。

## 断言的概念
> 在程序设计中，断言（assertion）是一种放在程序中的一阶逻辑（如一个结果为真或是假的逻辑判断式），目的是为了标示与验证程序开发者预期的结果－当程序运行到断言的位置时，对应的断言应该为真。若断言不为真时，程序会中止运行，并给出错误消息。
> ...
> 断言的使用有助于程序设计者设计、开发及理解程序。

摘自WIKI-[戳这里](https://zh.wikipedia.org/wiki/%E6%96%B7%E8%A8%80_(%E7%A8%8B%E5%BC%8F))

如上，断言是一种程序逻辑，一种基于契约式的设计。测试只是用到了断言，我们并不应该将测试与断言画上充分必要符号。


## UT中的断言
先来看下我们司空见惯的UT里，断言经常出现，expect，assertThat即是。

### Jest

```typescript
  it('should show children elements when permission is true and when is true', () => {
    const wrapper = shallow(<LAuthShow permission when>}><h1>hello</h1></LAuthShow>);
    expect(wrapper.contains(<h1>hello</h1>)).toBeTruthy();
  });
```

### Java

```java
    @Test
    void should_response_boolean_when_check_star_given_country() {
        String country = "US";
        given(ppcFeignClient.isStarDeal(country)).willReturn(true);
        Boolean isStarDeal = ppcService.isStarDeal(country);
        assertThat(isStarDeal).isTrue();
    }
```


## 实际业务代码

如上即是测试中的断言，这是我们一般用到的场景。

实际上在具体的业务代码中也可以加入部分的断言，这些断言可以在确保不该发生的情况发生时，能够执行一些动作，比如error日志的记录，这样在排查错误时，我们可以一定程度的提高效率，以此可以互补异常，错误栈的不足。


### 举个例子

```typescript
  
  const quote = buildQuote(quoteState);
  console.assert(Boolean(quote.currency), 'currency should not be non-null');
 
  const quoteResponseDTO = (yield call(quotationApi.saveQuote, quote)).data;
  
```


我这里要call后端存储quote，quote身上的currency是`不该出现空`的情况，但如果极端情况空，我希望能知道这个错误，能够在调试开发阶段提醒即可，从而追溯这个空的原因，真正的解决掉。

如上的情况，加断言就是个很好的方式。

当然实际开发中我们可以封装下`console.assert`,比如可以这样,除了控制台日志报错，我们也可以加其它操作，比如消息提示等等。

```typescript
export const assert = (condition?: boolean, message?: string, ...data: any[]): void => {
       console.assert(condition, message, data);
       ...
       showNotice('error');
}

```
### 强化断言处理

生产环境需要断言吗？个人觉得不需要，毕竟这个只是在开发阶段服务就够了，所以将其再改造下,这样生产打包即可不受影响。比如可以理解环境变量来做个判断，如果生产打包，则返回void即可。

```typescript
export const assert = (condition?: boolean, message?: string, ...data: any[]): void => {
if( process.env.NODE_ENV === 'prod' ){
	return ;
}
console.assert(condition, message, data);
showNotice('error');
}
```

## Spring 下Assert

Spring是成熟的Java系框架，其中它也有断言的实践。

比如表单校验,对比直接判断抛出异常这个写法会优雅一些。

```java
public InputStream getData(String file){
    Assert.hasText(file,"file入参不是有效的文件地址");
}
```


## 写在最后

1. 聊聊数语，我想关键就一点，就是断言是一种调试程序的方式，但并不局限于UT
2. 上述的例子，如果不用断言不也可以解决吗？是的，断言毕竟只是一个调试手段，逻辑判断，异常处理都可以做到。但是个人是这么想的，断言即是契约，即是约定该如此，而断言的情况没有满足，就需要找到，去消除问题满足，所以它并不在该出现的情况范围内，而比如我们异常是情况的一种，比如400，404，这也是一种response，异常出现的频率是高于断言的，所以两者是有区别的。
	
	比如我们如果写成if currency为空，进行console错误日志打印，确实可以，但别扭，因为这是将一种本不该出现的情况逻辑与正常逻辑放到了一起，可以但不优雅。 
3. 当前我所在做的项目是个以数据为主的平台WEB，很多关键数据的缺失都会造成操作故障，但是很多时候很难查找。为此之前所做的手段是大量的日志，大量的异常捕捉，但我想部分的场景实际上如果使用断言，程序可读性及可调式性能够得到一定的提升。

## 参考文档
- https://www.runoob.com/w3cnote/c-assert.html
- [断言 (程序)](https://zh.wikipedia.org/wiki/%E6%96%B7%E8%A8%80_(%E7%A8%8B%E5%BC%8F))

