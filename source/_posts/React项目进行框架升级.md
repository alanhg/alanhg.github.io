---
title: React项目进行框架升级
date: 2020-03-23 23:23:19
tags:
- React
---
> 开源虽免费，版本需谨慎。升级确实存在一定的风险，但如清晰每次升级的点[fix/feat/breaking change]，这个风险也会降低，或者没有。同时长远来看技术始终需要与时俱进的。尤其是产品迭代。
>
> 目前从事的WEB项目进入了一个新的迭代，于是借着周末的时间，进行下框架升级试验。



![](https://i.imgur.com/oyx1qPD.png)

## 动机
升级本身不单单只是改变一些依赖模块的版本号，而是版本号背后的一些改变，功能或者性能，或者设计模式。

这里列举下我相对关注的一些地方

## 关于的几个点


### TypeScript

1. Optional Chaining
2. nullish coalescing


### React

1. Scheduler
2. lazy / Suspense
3. Hooks


### React intl的v4
1. v4使用浏览器的原生intl，这样也就意味着体积会有所减小。
2. FormattedMessage可以返回纯文本，而非HTML元素，比如表单校验中的抛错实际上需要国际化


### 其它Benefit
1. 因为版本较新，文档，或者本身轮子的BUG都好沟通和追踪


## 升级后遇到的问题
> 升级从来不是单单的更改一些版本号，还是会有些许坑。 这里列举下我遇到的几个问题


1. 扩展全局类型声明

	之前类型声明并没有加declare global，但是在升级之后编译报错，应该是检测语法更为严格的原因，所以需要以下配置才可。

	```typescript
	import { IntlShape } from 'react-intl';

	declare global {
  		interface Window {
    		intl: IntlShape;
  		}
	}
	```
2. intl相关的UT辅助函数失效
3. TS2307: Cannot find module './index.less'

	在typings.d.ts中以下这么写会造成less，svg等模块导入失效报错

	```typescript

	declare module '*.less';

	declare module '*.svg';

	declare module '*.png';

	import { IntlShape } from 'react-intl';

	declare global {
  		interface Window {
    		intl: IntlShape;
  			}
	}
	```

	解决办法是分开两个文件，

	```typescript

	// Extend typings
	import { IntlShape } from 'react-intl';

	declare global {
  	interface Window {
    	intl: IntlShape;
  	}
		}
	```

	```typescript
	declare module '*.less';
declare module '*.svg';
declare module '*.png';

	```

  原因：

   1. ` declare gloabl`需要是一个模块，而内部需要有导入或者导出
   2. 周围的声明 `declare module '*.svg';` 不能有顶级的import或者export 存在


## 升级包

1. TypeScript `~3.3.1 =>  ~3.8.3`
2. react `16.4.2=> 16.13.0`
3. react-dom `16.4.2 => 16.12.0`
3. react-intl `^2.7.2 => ^3.11.0`
4. react-router-dom `5.0.1 => 5.1.2`
5. react-redux `4.0.3 => 7.2.0`
6. antd `3.20.0`=>`3.26.13`



## 写在最后

升级从来都是个挖坑，踩坑到填坑的过程。但收益有几点

1. 未来的可能性会更多些，因为技术足够的新
2. 能够平滑的升级，自身对于相关技术的熟悉度一定有了更深的理解和提高。

so，just do it!



## 参考资料
- https://github.com/formatjs/react-intl/blob/master/docs/Upgrade-Guide.md
- https://github.com/formatjs/react-intl/blob/master/docs/Components.md
- https://github.com/facebook/react/blob/master/CHANGELOG.md
- https://www.typescriptlang.org/tsconfig
