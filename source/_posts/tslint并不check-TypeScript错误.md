---
title: TSLint并不check TypeScript错误
tags:
  - TSLint
  - TypeScript
  - Husky
abbrlink: 28a51056
date: 2019-09-10 23:04:32
---
> 这篇文章想说的就是标题这一句话。但是强烈建议你还是看下去，因为搞明白会更有意思。
> TSLint是TypeScipt代码静态分析工具，它解决的是代码规范。提交代码时，前端往往都会跑一遍Lint，检测代码风格，确保统一。但跑过了TSlint就一定构建没问题了吗？？？。
> 
> 答案是不会，比如TS语法错误，就不会被发现，我曾经也以为Lint就会把TS语法错误都抓出来，其实这是错误的。

不信我们试试！

![](http://static.1991421.cn/2019-09-10-150415.jpg)

## TSlint所报的错
![](http://static.1991421.cn/2019-09-10-142254.png)

注意到lint报的错，后面都会说明违反的RULE。所以看见红不一定是TSlint检测的问题！
lint错，在提交时都会被check，简单的还会被自动修复。如果修复不了的直接不让提交。

如上因为只是个单双引号问题，lint工具会自动修复。注意到这次commit会没有change，为啥，因为确实没变，双引号还是被自动修复为原来的单引号了。

![](http://static.1991421.cn/2019-09-10-143949.png)

## TS错误

假如我定义这样一个接口类型，三个属性。
```typescript
interface IStudent {
  name: string;
  sex: 'male' | 'female';
  age: number;
}
```

![](http://static.1991421.cn/2019-09-10-143310.png)

![](http://static.1991421.cn/2019-09-10-143321.png)

new一个student对象时，我只赋值一个属性。果然报错了。但是我commit呢
依然成功。为啥呢，不是有lint吗，so你会发现lint过了不代表真没事

![](http://static.1991421.cn/2019-09-10-143458.png)

假如以上提交代码CI构建的话，应该会直接挂掉。思考下，怎么解决TS错误提前发现呢，那就是做TSC编译。这样错误就可以提前发现了。

## 改进提交钩子-加入TSC编译

找到了问题就好解决了，我们把tsc编译放在预提交阶段执行。我们再重新提交刚才的问题代码。

```json
{
  "hooks": {
     "pre-commit": "tsc --noEmit && lint-staged",
     "pre-push": "yarn run test"
  }
}
```
如愿提交失败，so只要加入TSC，我们就可以确保TS错误可以提前发现。

![](http://static.1991421.cn/2019-09-10-144840.png)

### 注意
- `noEmit`选项指不生成输出文件。
- 需要知道的是，加入了TSC编译，就一定会降低提交速度，毕竟做的事又多了一件。当然这点代码对于提高了CODE安全和质量来说，我觉得可以不care，但你要知道。


## 写在最后

倒逼我去搞明白这个问题的直接原因是，在程序开发重构中，往往会有一些语法错误，并不一定会每个文件，每个错误我们都会注意到，而原来的提交的Lint,UT等check又无法提早发现这种问题。so导致的就是N次的无效构建。

当我彻底搞明白了这点，并且加入了TSC编译到钩子中去，最终push到上游的代码，也将因此变的更健壮了。so，值得。

## 相关文档
- [Using ESLint and Prettier in a TypeScript Project](https://dev.to/robertcoopercode/comment/8o44)