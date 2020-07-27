---
title: ionic下Android环境搭建
date: 2020-07-27 20:45:06
tags:
- Android
- Ionic
---

> 环境问题说难不难，但是从来也不是那么顺利的。

- 寥寥数字，希望能够帮助使用ionic进行安卓APP开发的朋友们。
- 本人是坚定Mac党，所以命令以Mac下运行为主，Win下请自行查找，都类似。


1. install java jdk
2. install android studio
	
	下载[戳这里](https://developer.android.com/studio)
	
3. install gradle

    ```bash
    $ brew install gradle
    ```
    
4. install android sdk 选择目标版本即可
5. SDK license 协议

    ```sh
    $  ~/Library/Android/sdk/tools/bin/sdkmanager --licenses
    ```
            
6. 安卓手机开发者模式打开，连接电脑

   ```bash
   $ adb devices

   ```

7. 热加载真机启动

	```
	$ ionic cordova run android -l  
	```


如上即可快速搭建ionic下安卓开发调试。



