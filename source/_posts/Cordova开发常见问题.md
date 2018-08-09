---
title: Cordova开发常见问题
tags:
  - Cordova
  - Android
  - ionic
abbrlink: 29ac284a
date: 2017-10-09 21:55:12
---
> 在利用ionic或者直接使用Cordova开发会经常遇见些问题，这里总结下,`本文持续更新`

+ [Android版，代号、标记和细分版本 (Build) 号关系](#代号、标记和细分版本(Build)号关系)
+ [crosswalk-webview是否需要](#crosswalk-webview是否需要)
+ [config.xml文件修改，平台重新添加?](#config.xml文件修改，平台重新添加?)
+ [IOS-相册权限](#Missing Info.plist key)
+ [IOS-打包上传，构建版本中不显示](#IOS-打包上传，构建版本中不显示)
+ [Could not find an installed version of Gradle](#Gradle)
+ [com.android.ide.common.process.ProcessException: Failed to execute aapt]

## 代号、标记和细分版本 (Build) 号关系

代号|版本|API级别
---|---|---
Nougat|7.1|	API 级别 25
Nougat|7.0|	API 级别 24
Marshmallow|	6.0|	API 级别 23
Lollipop|	5.1	|API 级别 22
Lollipop|	5.0	|API 级别 21
KitKat|	4.4-4.4.4	|API 级别 19
Jelly Bean|	4.3.x	|API 级别 18
Jelly Bean|	4.2.x	|API 级别 17
Jelly Bean|	4.1.x	|API 级别 16
Ice Cream Sandwich|	4.0.3-4.0.4|	API 级别 15，NDK 8

最新最全信息，[点击查看官网文档](https://source.android.com/source/build-numbers)

## crosswalk-webview是否需要

[cordova-plugin-crosswalk-webview](https://github.com/crosswalk-project/cordova-plugin-crosswalk-webview)

这个插件，主要是解决老手机卡顿APP操作下卡顿问题，但如果不考虑较旧手机(Android4.4以下)，那么不建议安装
> Android 4.4之前的Android系统浏览器内核是WebKit，Android4.4系统浏览器切换到了Chromium(内核是Webkit的分支Blink)。

安装该插件，就是使用[Crosswalk Webview](http://blog.csdn.net/itcatface/article/details/49799337)替代了系统的WebView.
本质就是将`Chromium`带到APP里,但是4.4及以后已经切换到了`Chromium`

优点:
+ 不依赖安卓版本
+ 兼容性
+ 表现提升，对比老系统webviews的话

不足:
+ 增加内存开销
+ 增加APK体积大小(17MB左右)
+ 增加安装体积(50MB左右)

## config.xml文件修改，平台重新添加?

- ionic项目的的话，`不需要`，执行`ionic cordova build platform`或者`ionic cordova run platform`，ionic-cli直接更新平台中对应的code了。
- Cordova初始化构建的项目，需要rm然后再add。

## IOS-相册权限

如果APP没有声明相机权限，在实际的APP操作中，访问相册，APP会直接闪退并报错。所以必须添加对应插件，具体配置信息如下:

```
 <edit-config target="NSCameraUsageDescription" file="*-Info.plist" mode="merge">
      <string>need camera access to take pictures</string>
    </edit-config>
    <edit-config target="NSMicrophoneUsageDescription" file="*-Info.plist" mode="merge">
      <string>need microphone access to record sounds</string>
    </edit-config>
    <edit-config target="NSPhotoLibraryUsageDescription" file="*-Info.plist" mode="merge">
      <string>need to photo library access to get pictures from there</string>
    </edit-config>
    
<plugin name="cordova-plugin-media-capture" spec="~1.4.3">
    <variable name="CAMERA_USAGE_DESCRIPTION" value="App would like to access the camera."/>
    <variable name="MICROPHONE_USAGE_DESCRIPTION" value="App would like to access the microphone."/>
    <variable name="PHOTOLIBRARY_USAGE_DESCRIPTION" value="App would like to access the library."/>
  </plugin>
```
注意`edit-config`标签中的内容会打包进入info.list文件中，这段必须写，否则，最终打包的APP提交构建版本会失败
## IOS-打包上传，构建版本中不显示

如果打包上传，提示了成功，但是在Itunes Connect-活动-所有构建版本中没有看到，说明提交APP被打回来了，都会有邮件，并说明了错误信息。
比如下面信息。
> Missing Info.plist key - This app attempts to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSPhotoLibraryUsageDescription key with a string value explaining to the user how the app uses this data.
    Once these issues have been corrected, you can then redeliver the corrected binary.
    
对应修复后，再次提交，直接刷新页面，就会提示，提交的版本及状态。

## <span id="Gradle">Could not find an installed version of Gradle</span>
完整错误是
> Could not find an installed version of Gradle either in Android Studio, or on your system to install the gradle wrapper. Please include gradle in your path, or install Android Studio

官方网站，有相关介绍如下:
> As of cordova-android@4.0.0, Cordova for Android projects are built using Gradle. 

所以明白了问题，解决方案正如错误而言，安装Gradle即可。

如果是`mac`建议，执行`brew install gradle`即可。

## com.android.ide.common.process.ProcessException: Failed to execute aapt
执行`cordova build android`会报此错误，原因在于项目中的crosswalk-webview。解决办法
1. 卸载cordova-plugin-crosswalk-webview插件
	`cordova plugin rm cordova-plugin-crosswalk-webview`
2. 安装cordova-android-support-gradle-release插件
	`cordova plugin add cordova-android-support-gradle-release`
两种办法都可，取决于我们还是否使用crosswalk，关于使用它的优缺点，[戳这里](https://github.com/crosswalk-project/cordova-plugin-crosswalk-webview)

