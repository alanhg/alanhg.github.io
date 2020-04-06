---
title: IDEA插件-NPM包版本历史
tags:
  - IDEA Plugins
  - 插件开发
abbrlink: 138d7559
date: 2020-02-01 17:06:05
---
> IDEA或WS中，比如对于包版本，我们只能看到当前安装的版本或者最新版本号，但是对于查看历史版本，却没有现成的手段支持。于是我在想不如做个插件来强化下呢。

## 查看包版本历史的需求

查看包版本历史从来不是个多么刚性的需求，但是却也需要。

比如使用webpack4.x，这时我想知道4.x之上又有哪些版本，因为每次的升级不一定是升级到最新。

又比如，我们发布的私服包，有时需要知道私服上当前有多少个版本，因为某些原因，部分版本可能不存在了，我们需要确认下。

等等，需求还是存在的，so，只剩下解决了。

## npm ｜ yarn命令查看包版本历史
npm或者yarn命令本身即支持查询可用包版本历史


```bash
npm view webpack versions --json
yarn info webpack versions
```

## 插件开发大致过程
基于上面的命令，那么插件无非也就是对于此命令包裹了可视化的UI而已。开搞

### 大致的流程

1. 获取用户光标聚焦的包名
2. 执行命令获取包版本历史
3. 弹框列表展示

具体的开发历程这里不赘述，只描述下几个点

### 关键点

####  控制菜单的显示及可用状态

我的需求是用户只有在package.json文件中，单击右键才显示菜单。

方法：重写update方法，Presentation提供了方法来控制。

```java
 @Override
    public void update(@NotNull AnActionEvent e) {
        PsiFile psiFile = e.getData(CommonDataKeys.PSI_FILE);
        String filename = psiFile.getVirtualFile().getName();
        Presentation presentation = e.getPresentation();
        if ("package.json".equals(filename)) {
            presentation.setEnabledAndVisible(true);
            return;
        }
        presentation.setEnabledAndVisible(false);
    }

```
#### 获取包名
我的需求是用户在包名称位置，光标单机右键时即获取包名

方法：PsiTreeUtil提供方法可以根据元素获取直接父元素，从而获取内容

```java
 PsiElement element = Objects.requireNonNull(PsiManager.getInstance(project).findFile(file)).findElementAt(offset);
        PsiElement firstParent = PsiTreeUtil.findFirstParent(element, new Condition<PsiElement>() {
            @Override
            public boolean value(PsiElement psiElement) {
                return true;
            }
        });
        assert firstParent != null;
        String packageName = getPackageName((LeafPsiElement) firstParent);

...
 @NotNull
    private String getPackageName(LeafPsiElement firstParent) {
        String name = firstParent.getText();
        return name.substring(1, name.length() - 1);
    }
```

#### 光标位置显示弹窗

```java

 private void showPopup(String name, List<String> versions, Editor editor) {
        IPopupChooserBuilder<String> popupChooserBuilder = JBPopupFactory.getInstance().createPopupChooserBuilder(versions);
        popupChooserBuilder.setTitle(name);
        JBPopup popup = popupChooserBuilder.createPopup();
        popup.setMinimumSize(new Dimension(80, 0));
        popup.showInBestPositionFor(editor);
    }
```

#### 执行命令

```java

 ArrayList<String> cmds = new ArrayList<>();
        cmds.add("npm");
        GeneralCommandLine generalCommandLine = new GeneralCommandLine(cmds);
        generalCommandLine.setCharset(Charset.forName("UTF-8"));
        generalCommandLine.setWorkDirectory(project.getBasePath());
        generalCommandLine.addParameters("view", name, "versions", "--json");
        String commandLineOutputStr = ScriptRunnerUtil.getProcessOutput(generalCommandLine);
        Gson converter = new Gson();
        Type type = new TypeToken<List<String>>() {
        }.getType();
        List<String> result = converter.fromJson(commandLineOutputStr, type);
```


## 最终效果

![](https://i.imgur.com/V9D3Hr5.gif)

插件商店地址: [戳这里](https://plugins.jetbrains.com/plugin/13748-view-package-versions)

## 写在最后
1. 这应该是我个人开发的第二款IDEA插件了，初衷很简单，现有IDE及插件不支持，索性自己开发，利用插件填补IDE的不足，进而提升个人生产力。
2. 官方文档对于API方法并没有例子，so，单靠IDEA的文档，确实不够用，需要利用多种手段来解决插件开发中的问题，比如我会IDEA官方社区发帖子，Slack上与它们沟通，查看IDE及现有插件的SDK，这些都可以辅助解决当前遇到的问题。so，手段需要多元化。


## 参考文档
- [IntelliJ Platform SDK](http://www.jetbrains.org/intellij/sdk/docs/welcome.html)
- [intellij-community](https://github.com/JetBrains/intellij-community)
- [Developing an IntelliJ / WebStorm JavaScript plugin](https://medium.com/@andresdom/developing-an-intellij-webstorm-javascript-plugin-65416f9afea3)
- [intellij-plugins](https://github.com/JetBrains/intellij-plugins)
- [Slack](https://plugins.jetbrains.com/slack)
- [IDEs Support (IntelliJ Platform) | JetBrains](https://intellij-support.jetbrains.com/hc/en-us/community/posts)
- [官方推荐资源](http://www.jetbrains.org/intellij/sdk/docs/appendix/resources/useful_links.html)
