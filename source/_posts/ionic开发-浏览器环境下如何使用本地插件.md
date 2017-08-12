---
title: ionic开发-浏览器环境下如何使用本地插件
tags:
  - ionic
  - ionic native
abbrlink: 2944f645
date: 2017-05-30 16:05:25
---
[官方原文](https://ionicframework.com/docs/native/browser.html)

## 浏览器环境下使用本地化插件

ionic native拥有130多个移动SDK插件，这点使得可能构建强大的ionic app。

由于历史原因，在浏览器环境下测试这些本地插件是很困难的，要求ionic开发者比如在物理设备或者虚拟机中进行测试，这是相当慢的一个过程。

ionic native3.0现在允许开发者能够伪装，在浏览器环境下通过重写类，是的能够提供测试数据，或者访问本地化API，比如HealthKit。

这意味着大量的ionic app能够不必部署到真机或者模拟器，就可以在浏览器环境下完全的构建了。一流的开发速度，闻所未闻。

## 伪装插件

为了在浏览器环境下去使用ionic本地化插件，你只需要拓展这些传统插件类和重写一些函数。

让我们伪装下`Camera`插件返回一张图片吧。

首先在根模块导入`Camera`类.
```
import { Camera } from '@ionic-native/camera';
```

然后创建类，拓展`Camera`类，伪装一个实现。

```
providers: [
  { provide: Camera, useClass: CameraMock }
]

```
下面是完整的例子

```typescript
import { NgModule, ErrorHandler } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { IonicApp, IonicModule, IonicErrorHandler } from 'ionic-angular';
import { MyApp } from './app.component';
import { HomePage } from '../pages/home/home';

import { Camera } from '@ionic-native/camera';

class CameraMock extends Camera {
  getPicture(options) {
    return new Promise((resolve, reject) => {
      resolve("BASE_64_ENCODED_DATA_GOES_HERE");
    })
  }
}

@NgModule({
  declarations: [
    MyApp,
    HomePage
  ],
  imports: [
    BrowserModule,
    IonicModule.forRoot(MyApp)
  ],
  bootstrap: [IonicApp],
  entryComponents: [
    MyApp,
    HomePage
  ],
  providers: [
    {provide: ErrorHandler, useClass: IonicErrorHandler},
    { provide: Camera, useClass: CameraMock }
  ]
})
export class AppModule {}

```
