---
title: '【译】TypeScript vs. JavaScript: Should You Migrate Your Project to TypeScript?'
date: 2018-06-30 22:09:37
tags:
- TypeScript
- 译
---
> 16年9月,Angular2首个正式版放出，官方是推荐使用TypeScript进行开发的，由此，玩Angular的开发者大多都选择TypeScript。除了Angular框架，其它的框架，如React,Vue实际上也都相继支持TS开发，TS现在的确是挺火的。但TS好在哪呢，与JS差异在哪，解决的痛点是什么呢，这点一直没去系统的梳理。
最近看到篇文章写的很棒，这里译一下，兴许能帮到大家。

![](http://or0g12e5e.bkt.clouddn.com/2018-07-01-025045.jpg)

在编程领域，TypeScript(TS)和JavaScript(JS)是两种流行的开发语言，但两者的区别是什么，什么情况下适用?在这篇文章里，我们对比两门语言，看看两者如何，讨论下它们的主要区别，和彼此的优缺点。

## 定义TypeScript
TypeScript是JavaScript的超集，可以编译成JavaScript(EcmaScript 3+)。TypeScript提供类型注释，以此在编译环节进行可选、静态类型分析。因为是JavaScript的超集，所有的JavaScript语法在TS中都是有效的。然而，这并不意味着所有JavaScript都可以在TypeScript编译器下执行通过。
```typescript
let a = 'a';
a = 1; // throws: error TS2322: Type '1' is not assignable to type 'string'.
```
## TypeScript的优势
### 类型注释
TypeScript被创造来进行"静态类型分析"，它允许我们创造安全的声明，我们来对比下面的JavaScript和TypeScript函数:
```javascript
// Basic JavaScript
function getPassword(clearTextPassword) {
    if(clearTextPassword) {
        return 'password';
    }
    return '********';
}

let password = getPassword('false'); // "password"
```
JavaScript无法避免函数以无效的参数调用，在实际运行中，也不会报错。如果是使用TypeScript，这点完全可以避免，以下是TypeScript的类型注释:
```typescript
// Written with TypeScript
function getPassword(clearTextPassword: boolean) : string {
    if(clearTextPassword) {
        return 'password';
    }
    return '********';
}

let password = getPassword('false'); // throws: error TS2345: Argument of type '"false"' is not assignable to parameter of type 'boolean'.
```
这个例子描述我们如何能够避免使用意外类型调用。历史原因，JavaScript的问题之一就是类型检查缺失造成的问题追踪,这会导致不熟悉JavaScript复杂性的人产生不良结果。

### 语言功能
除了静态类型分析外，TypeScript也添加了以下功能点
- [接口](https://www.tslang.cn/docs/handbook/interfaces.html)
- [泛型](https://www.tslang.cn/docs/handbook/generics.html)
- [命名空间](https://www.tslang.cn/docs/handbook/namespaces.html)
- [空检查](https://www.tslang.cn/docs/release-notes/typescript-2.0.html)
- [访问修饰符](https://www.tslang.cn/docs/handbook/classes.html)

## API文档
假如上面的getPassword(...)函数属于一个类库，我如何知道函数的传参类型呢，有jsdoc，许多IDE，编辑器，比如VSCode都支持。也有一些类库的文档，比如Dash这种工具。但是这些都没有提供如TypeScript这样的体验。
考虑fetch API 这个例子。下面的截图描述了，我们用VSCode Peek Definition这个功能。用这些工具，我们可以发现热输入参数的类型和返回参数的类型。这些工具是好于通过传统的JavaScript和jsdocs的。

![](http://or0g12e5e.bkt.clouddn.com/2018-07-01-032550.jpg)

## 误解
对于可能选择TypeScript的人，会有许多的误解，这里选择部分来说下。
- **ES6功能**：选择TS的原因，部分是奔着ES6的功能，比如模块，类，箭头函数，或者其它一些。然而，这并不是一个好的原因，因为这些完全可以通过Babel实现。事实上，并不常见于在一个应用中看到TypeScript与Babel并存。
- **比JavaScript容易**:在多数情况下，这种说法未免主观了些。有些论点说，TS引入了语法噪声。但最重要的是，TS不隐藏JS。这不是一个忽视JavaScript的接口。TS仍然是JavaScript的超集，并且对于与静态类型检查(this，域，原型，等等)无关的问题，它并不提供保护。因此，开发者们请保持强大的JS能力。
- **类型正确==程序正确**:虽然这明显是个不正确的观点，但我相信静态类型检查提供了一个人工安全网，开发者可以视其为理所应当。如果类型正确不意味着程序正确，那我们如何去继续做，确保我们的程序能够满足我们的目的呢?答案我认为就是单元测试，如果我们知道去通过单元测试来证明我们的程序是正确的，那么这些测试应该也能避免大多数类型的错误。
- **静态类型**支持摇树优化:摇树优化是通过静态构造(如命名模块导入/导出和常量)来消除死代码，TypeScript目前不支持摇树优化。

## 语法与编译对比
通常听到开发者选择TypeScript是因为模块和类这些功能。然而，这些功能在ES6标准下的JS也是可以的，理解这点很重要。你可以通过Babel转译成ES5来满足浏览器兼容性。因为这个困惑，这里有个语法对比。对于每一个功能，你将能够看到TypeScript版本和它编译后的ES5版JavaScript，还有ES6和利用babel转义的ES5。
### 类

```typescript
// -- TypeScript -- //
class Article {
    name: string;
    constructor(name: string) {
        this.name = name;
    }
}

// -- TypeScript compiled output -- //
var Article = /** @class */ (function () {
    function Article(name) {
        this.name = name;
    }
    return Article;
}());
```
```javascript
// -- JavaScript with Babel -- //
class Article {
    constructor(name) {
        this.name = name;
    }
}

// -- Babel compiled output -- //
"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Article = function Article(name) {
    _classCallCheck(this, Article);

    this.name = name;
};
Modules
```
### 模块
```typescript
// -- TypeScript -- //
export default class Article { }

// -- TypeScript compiled output -- //
define(["require", "exports"], function (require, exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    var Article = /** @class */ (function () {
        function Article() {
        }
        return Article;
    }());
    exports.default = Article;
});
```
```javascript
// -- JavaScript with Babel -- //
export default class Article { }

// -- Babel compiled output -- //
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Article = function Article() {
  _classCallCheck(this, Article);
};

exports.default = Article;

```
### 可选参
```typescript
// -- TypeScript -- //
function log(message: string = null) { }

// -- TypeScript compiled output -- //
function log(message) {
    if (message === void 0) { message = null; }
}
```
```javascript
// -- JavaScript with Babel -- //
function Log(message = null) { }

// -- Babel compiled output -- //
"use strict";

function Log() {
  var message = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : null;
}
```

## 什么时候选择:TypeScript vs . JavaScript
### TypeScript
- 喜欢编辑阶段类型检查:通过使用vanilla JavaScript在运行阶段进行类型检查，然而，这也引入了额外的运行环境，如果在编译阶段进行检查就可以避免这个问题。
- 新类库或者框架下开发:假设你们正准备起步用React开发一个新项目。你并不熟悉React的API,但因为他们提供了类型定义，你可以智能感知，它会通过导航帮助你发现新的接口，快速了解。
- 大型项目或者多人开发：当我们再进行较大项目的开发，或者说你有介个开发者协作开发时，TypeScript是有意义的。使用TypeScript的接口，访问修饰符是无价的(类成员可以被声明)

### JavaScript
- **构建工具要求**：TypeScript多了步构建去生成最终执行的JavaScript文件。然而没有构建工具来进行JS开发正在变的越来越少见。
- **小项目**:TypeScript对应小团队或者代码量较小的项目项目可能有点过火了，没必要。
- **健壮的测试工作流**：如果你有一只已经实现了测试驱动开发的团队的话，切换到TypeScript可能开销会大于回报。
- **已添加依赖**：为了去使用TS类库，你讲需要他们的类型定义。每一个类型定义都意味着一个额外的npm包。因为这些额外的包，你要承受这些包可能没人维护或者错误的风险，你也将会失去TS的优点。*注意*[DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped)项目致力于减少这些风险。流行的项目类型定义基本在这里都可以找到。
- **框架不支持**：如果你的框架本身就不支持TS，比如[EmberJS](https://github.com/emberjs/ember.js)(虽然，这个已经列入计划，TS已经是[Glimmer](https://glimmerjs.com/)的一种开发语言。)，那么你不能充分使用它的功能了。

## 其它考虑
所以，你已经决定了，是时候引入一个类型系统到你的前端开发工作流中去了。TypeScript是唯一选择？答案是No,事实上，还有其它两个主流的工具来做类型注释，它们也值得考虑并且已经在讨论。
- [FaceBook's Flow](https://github.com/facebook/flow)
- [Google's Closure](https://developers.google.com/closure/compiler/)

---

原文链接:[TypeScript vs. JavaScript: Should You Migrate Your Project to TypeScript?](https://stackify.com/typescript-vs-javascript-migrate/)