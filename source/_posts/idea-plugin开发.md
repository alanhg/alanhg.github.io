---
title: idea plugin开发
date: 2019-06-02 20:40:41
tags:
- IDEA
- Plugin
-Java
---
> 工作日每天早上我们都会进行CodeReview，大致的流程是一群人看着一块屏幕，分别打开每个项目，看每次的commit，发现有问题的代码，就记录下来行号，文件名，所在项目，问题点等，但记录的过程却是很浪费时间的，也容易错。每次因为要记录，其实也造成了CodeReview的效率低。关于改良CodeReview的的效率，我们也是经过了一系列的努力的。
>
> 一开始，是一个人操作IDE浏览代码，一个人去记录，但是记录的人因为要跟上速度，就不免出现记录不完整，比如代码所谓位置及问题点
> 后来，我们使用IDE的bookmark，进行打标记，但是这种的问题是不支持跨项目，每个项目的都是独立的，另外也无法导出。我们的产出一般是记录在Confluence上。

如上，每次的记录跟进的很差，并且浪费时间。于是，我想,何不开发个Bookmark的增强版呢，吐槽那些不支持的功能，我来！

## 可行性
假如要做，那么就要考虑可行性，梳理下当前我所需要的功能点

1. 记录目标行号，项目名称，文件路径
2. 应用级【多项目】共享
3. 重启IDE也要起作用，与2点接近，实际上就是持久化存储
3. 设定系统剪切板
3. 快捷键绑定支持

## SDK及第三方资料调研
查看了官方资料及相对成熟的插件项目，对于文件系统，系统剪贴板，持久化存储，快捷键绑定等都有支持，断定可以做。

这里吐槽国内的博客文章的2个特点，1是疯狂转发原创缺失，转发就得了，大哥能贴下原来的链接吗，并且图片也搞下啊，有些排版都乱了，2是内容干货少，其实好的文章不见得字数多，但捡重点，讲明白。哎，吾辈继续努力吧。

## 初始化环境
IDEA对于插件开发支持是相当不错的，没办法，自家平台嘛,点击new project
![](http://static.1991421.cn/2019-06-02-125248.png)
点击next,完成

## 项目结构
初始化项目，基本没什么东西，我这里就贴下我的项目结构了。

```
├── README.md
├── bookmarker4idea.iml
├── out
├── resources
│   └── META-INF
│       └── plugin.xml // 配置文件
└── src  //源代码
    ├── cn
    │   └── alanhe
    │       ├── BookMarkX.java
    │       ├── BookMarkXPersistentStateComponent.java
    │       ├── BookmarkXItemState.java
    │       └── CopyBookMarkX.java
    ├── icon
    │   └── bookmarker.png // 图标等静态资源
    └── test // 测试

```
## plugin.xml
其实开发主要就两部分，Java和xml,我们定义菜单，图标，事件和持久化存储都需要在这里进行配置
这里贴出我的插件部分配置
```xml
<idea-plugin>
    <id>cn.alanhe.plugin.bookmarkx4idea</id>
    <name>bookmarkx4idea</name>
    <version>1.0</version>
    <vendor email="i@alanhe.me" url="https://github.com/alanhg/bookmarkex4idea">personal</vendor>

    <!-- please see http://www.jetbrains.org/intellij/sdk/docs/basics/getting_started/build_number_ranges.html for description -->
    <idea-version since-build="173.0"/>

    <!-- please see http://www.jetbrains.org/intellij/sdk/docs/basics/getting_started/plugin_compatibility.html
         on how to target different products -->
    <!--     uncomment to enable plugin in all products-->
    <depends>com.intellij.modules.lang</depends>

    <extensions defaultExtensionNs="com.intellij">
        <applicationService serviceImplementation="cn.alanhe.BookMarkXPersistentStateComponent"/>
    </extensions>

    <actions>
        <!-- Add your actions here -->
        <action id="bookmark" class="cn.alanhe.BookMarkX" text="toggle BookMarkx" description="bookmark">
            <add-to-group group-id="Bookmarks"/>
            <keyboard-shortcut keymap="$default" first-keystroke="ctrl alt B"/>
        </action>
        <action id="ExportBookMark" class="cn.alanhe.CopyBookMarkX" text="Copy BookMark to Clipboard"
                icon="/icon/bookmarker.png"
                description="Copy BookMark to Clipboard">
            <add-to-group group-id="EditorPopupMenu" anchor="first"/>
        </action>
    </actions>
</idea-plugin>
```




## 相关文档
- http://www.jetbrains.org/intellij/sdk/docs/welcome.html
- https://corochann.com/intellij-plugin-development-introduction-persiststatecomponent-903.html
- https://intellij-support.jetbrains.com/hc/en-us/community/posts/360001787320-Create-VirtualFile-or-PsiFile-from-content?page=1#community_comment_360000524140
- http://programandonet.com/questions/90284/intellij-idea-plugin-persistentstatecomponent-loadstate-no-se-llama

