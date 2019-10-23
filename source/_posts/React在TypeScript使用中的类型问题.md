---
title: React在TypeScript使用中的类型问题
date: 2019-10-23 23:18:22
tags:
- TypeScript
- React
---
> 前端项目在TypeScript加持下可以提升代码健壮性。当然使用中难免还是会遇到很多类型定义上的问题，这里总结一番。


## children在function组件下的使用

```typescript
import React from 'react';

interface IProps {
  permission: boolean;
}

const AuthShow = ({ permission, children }: React.PropsWithChildren<IProps>) => {
  return <>{isPermit() ? children : null}</>;
};

export default AuthShow;
```
