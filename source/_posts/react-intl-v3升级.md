---
title: react-intl v3升级
date: 2020-06-13 16:48:50
tags:
- react-intl
- react
---
> 趁着周末做下react-intl的类库升级。当前最新版本是`v4.6.9`,项目使用的版本是`v2.3.18`，这里决定升级到`v3@latest`

## 升级带来的benefit
1. 修复已知的BUG，原先的版本当我传入`de-de`，国际化失效，当时的workaround是我将localData的key永远设定为en
2. 针对localeData部分，体积会减小，因为已经使用了浏览器自带的Intl相关API
3. withRef迁移到forwardRef，这也是目前组件通用的方式，有益于统一
4. 之前已经做了React，Redux这些主要类库的升级，Intl升级有益于整体架子将来的迭代而升级
5. 之前的国际化方法，比如formatMessage返回的是Node节点，比如包含了Span标签，而v3返回的是文本，严格来说渲染也会降低浏览器的开销，毕竟少了一对节点，当然比如有些国际化地方需要简单的文本，这样就可以直接满足

_虽说开源虽免费，版本须谨慎，但永恒不变，对于发展中的WEB技术和本身的产品项目都是不利的，所以还是需要渐进升级。_


## 升级细目

官方也给出了v2=>v3的升级指南，当然升级从来都没那么顺利过，于是这里将关键点一一说明

## 配置

如何升级呢，看这里，这里罗列了主要的关键点，但比如values类型文件等，根据错误提示，直接替换修改即可。

### package.json

```json
"react-intl": "^3.12.1"
```

#### 注意

v3已自带TS类型定义，之前的`@types/react-intl`需remove

### tsconfig.json

```json
    "lib": ["es2015", "es2017", "dom", "es2018.intl", "esnext.intl"]
```

#### typings.d.ts


```typescript
import { IntlShape } from 'react-intl';

declare global {
  interface Window {
    intl: IntlShape;
  }
}

```
#### 注意

- 这里之所以要加定义，是因为我在WEB初始化时，将intl的对象赋值给了Window自定义对象intl，假如不需要的skip
- 这里比较有意思的是，TS项目中有时我们需要支持JSON，SVG等的模块导入，所以往往需要`declare module '*.svg';`,但是这种声明与上面的global声明会有冲突，解决办法就是物理分离两个d.ts文件。


![](http://static.1991421.cn/2020/2020-06-13-171323.jpeg)



### UT

intl的升级对于UT也是会有影响的，主要在工具函数上，配置如下

```typescript
import { mount, render, shallow } from 'enzyme';
import React from 'react';
import { createIntl, IntlProvider } from 'react-intl';
import renderer from 'react-test-renderer';

const messages = {}; // en.json

const intl = createIntl({ locale: 'en', messages, onError: () => '' });

function nodeWithIntlProp(node) {
  return React.cloneElement(node, { intl });
}

export function mountWithIntl(node) {
  return mount(node, {
    // @ts-ignore
    wrappingComponent: IntlProvider,
    wrappingComponentProps: {
      locale: 'en',
      defaultLocale: 'en',
      messages
    }
  });
}

export function renderWithIntl(node) {
  return render(<IntlProvider locale='en' messages={messages} onError={() => ''}>{node}</IntlProvider>);
}

export function rendererWithIntl(node) {
  return renderer.create(<IntlProvider locale='en' messages={messages} onError={() => ''}>{node}</IntlProvider>);
}

```

### 接口定义修改

InjectedIntlProps=>WrappedComponentProps，
withRef=>forwardRef

全局替换即可，但注意别搞错了。

## 写在最后
经过如上的配置，升级即可完成。当然这里因为我考虑到系统稳定性，所以没有从v2直接升级v4,但粗略看了下3=>4的变化较小，所以等系统稳定一段时间，再做升级

## 参考文档
- [Upgrade Guide (v2 -> v3)](https://formatjs.io/docs/react-intl/upgrade-guide-3x)
