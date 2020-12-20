---
title: Git快照是什么
date: 2020-12-20 15:22:32
tags:
- Git
- VCS
---

> Git越玩越喜欢，但有些底层的认识还不系统全面，比如快照是什么，Git又是如何存储这些快照的，关于这些机理，这里Mark下。



## 快照记录

- Git在每次commit时会对仓库中所有文件进行扫描，如果某文件发生变化，则会将新文件生成一个[Blob](https://zh.wikipedia.org/wiki/%E4%BA%8C%E9%80%B2%E4%BD%8D%E5%A4%A7%E5%9E%8B%E7%89%A9%E4%BB%B6)二进制文件，记录当前Commit时文件的所有内容，如果文件没有变化，则记录一个链接指向之前存储的文件

- 对于单次commit本身有个索引存储，利用这个索引可以找到这些变化和没变化的文件

下图可以方便理解每个快照即版本的仓库情况



![](https://static.1991421.cn/2020/2020-12-20-153213.jpeg)

## 快照存储

知道了快照记录的策略，那快照又存储在哪呢======》.git这个隐藏文件夹

文件中项挺多，这里只关心存储历史快照的位置，即index，objects，其它的部分推荐查阅Pro Git了解

![](https://static.1991421.cn/2020/2020-12-20-154131.jpeg)



为了理解Git是如何具体存储的，这里初始化一个空项目

`mkdir git-demo & cd git-demo & git init &  echo "just a demo">  README.md` 

开始执行git操作

### git add

当执行`git add . `时，index文件中会存储提交信息文件的索引。这里查看索引需要使用底层命令`git ls-files -s`

```bash
$ git ls-files -s
100644 a730a28e53d8defdda8fe953829afdfc906e463a 0	README.md
```

注意，因为是二进制文件，没法直接文本查看，只能如上查看。可以看出索引文件记录的是文件名称`README.md`，和在Git文件系统中存储的blob文件名称`a730a28e53d8defdda8fe953829afdfc906e463a`即40位SHA-1值

具体的blob文件存储在`.git/objects`，注意前两位a7是文件夹，后38位为文件名称。

这时，使用`git cat-file -p a730a2`可以查看提交文件的完整内容。

```bash
$ git cat-file -p a730a2
just a demo
```

### git commit

当执行` git commit -m 'init readme'`，提交本地仓库成功后

```bash
$ git commit -m 'init readme'
[master (root-commit) 79821c6] init readme
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
```

重新查看`.git/objects`目录下，会发现多了两个文件夹

```bash
$  ll .git/objects/
total 0
drwxr-xr-x  3 qhe  staff    96B Dec 20 22:22 4e
drwxr-xr-x  3 qhe  staff    96B Dec 20 22:22 79
drwxr-xr-x  3 qhe  staff    96B Dec 20 16:24 a7
drwxr-xr-x  2 qhe  staff    64B Dec 20 16:24 info
drwxr-xr-x  2 qhe  staff    64B Dec 20 16:24 pack
```

其中`79`记录的是这次提交的内容，而4e记录的是个树对象，保存了提交相关的文件名等

```bash
$ git cat-file -t 4edb6d
tree
```

到此，大致了解了日常Git操作中是如何记录存储这一个个节点快照的。

### 内存占用

如上，对于变化的文件都会进行全量的存储即存储为二进制文件，那长远来看，内存占用就会比较大，对此，Git也有优化

> Git会权衡时间和空间利用率进行优化存储，保存当前最新版本的整个文件，而对于时间久远或不经常使用的版本，只保留Diff，因此也就一定程度的做到了存储空间与读取加载速度的平衡。

## 总结

列出我们日常基本操作下的Git图



![](https://static.1991421.cn/2020/2020-12-20-154508.jpeg)

- git add时，文件会被存储到暂存区 index/objects文件中
- git commit时，文件会被存储到本地仓库即objects文件中

当然`git push`时，这些对象就会被发送到上游服务器，但要知道Git是分布式的，因此上游与我们本地实际上内容一样。

## 写在最后

- Git给人的感觉是简单但又很强大，这应该也是优秀软件设计的特点吧。
- 了解Git的这些底层原理有利于更高效的使用Git，同时对于日常开发中遇到的一些问题也会有些许的借鉴意义，比如上述的存储策略。



## 参考文档

- [Where Git staged files are stored?](https://stackoverflow.com/questions/27264809/where-git-staged-files-are-stored)
- [深入 Git：index 檔案](https://titangene.github.io/article/git-index.html)

