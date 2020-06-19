---
title: ionic安卓版签名打包
tags:
  - ionic
  - android
  - release
abbrlink: '92816972'
date: 2017-05-30 18:37:13
---

### 创建平台
```
ionic cordova platform add android 
```
### 创建签名文件

```
keytool -genkey -v -keystore he-release.keystore -alias he -keyalg RSA -keysize 2048 -validity 10000
```

### 创建签名配置文件
在`platforms/andoroid`下创建`release-signing.properties`配置文件
```
key.store=<YOUR_KEYSTORE>.keystore
key.store.password=<YOUR_KEYSTORE password>
key.alias=<YOUR_ALIAS>
key.alias.password=<YOUR_ALIAS password>
```
### 执行打包命令
`ionic cordova build android --prod --release`
在`/platforms/android/build/outputs/apk`下就会看到有`android-release.apk`文件。

![cordova-build-android](https://static.1991421.cn/cordova-build-android.png)

其实也可以打包出来为签名版本的apk，通过命令行手动加签名，但是对比这个方案就会略显麻烦，建议按照上述这种方式，自动化加上签名。

参考文章[Ionic 2 : Building A Release Android APK](http://ionichelper.forlearning.net/ionic-2-building-a-release-android-apk/)
