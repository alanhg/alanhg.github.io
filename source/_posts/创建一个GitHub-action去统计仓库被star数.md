---
title: 编写一个GitHub Action去统计仓库被star数
date: 2021-06-14 00:51:26
tags:
- GitHub Action
- GitHub
---

> 个人的开源项目每当被Star，会收到电报推送消息，这样以此进而激励我继续dev，做受欢迎的项目。
>
> 实现这个自动化的基础设施是GitHub Action，但是现在我想优化下推送体验，当被star时，获取项目:star:数目，于是研究使用Action来实现一键使用。

该action下载地址-[Repo Star Count](https://github.com/marketplace/actions/repo-star-count)。想了解原理的👇看。

## 获取星星数方式

如何获取:star:，GitHub Action本身并没有提供该环境变量，且star event也没有包含该元信息，因此只能通过API方式，好在GitHub API非常丰富。

这里贴下关键代码 

```shell
curl -s 'https://api.github.com/repos/${{ inputs.repoPath }}?page=$i&per_page=100' | jq .stargazers_count
```

## 编写GitHub Action

为了便于多个项目复用使用，于是我进行了Action封装，这样对外只需要消费值即可。

### Action源码

```yml
name: 'Repo Star Count'
description: 'Get count of Github repository stars'
author: 'Alan He'
inputs:
  repoPath:
    description: 'Repository Path'
    required: false
    default: ${{github.repository}}
outputs:
  stars:
    description: "Repo Stars"
    value: ${{ steps.repo-stars.outputs.stars }}
runs:
  using: composite
  steps:
    - id: repo-stars
      run: |
        STARS=`curl -s 'https://api.github.com/repos/${{ inputs.repoPath }}?page=$i&per_page=100' | jq .stargazers_count`
        echo "::set-output name=stars::$STARS"
      shell: bash
branding:
  icon: 'award'
  color: 'green'

```

### 调用该action

workflow中安装该action，直接使用star值即可

```yml
 ...
 steps:
      - name: Star Count
        id: repo-stars
        uses: alanhg/repo-star-count-action@master
       
 # ${{steps.repo-stars.outputs.stars}}      
 ...
```

如上，安装后就不需要care具体如何获取star，只需要使用该值即可。



## 遇到的几个问题

GitHub Action文档虽然全，还是踩坑不少，这里列举下

1. 部署发布的Action不一定会理解在商店搜索到，有时会有**延迟**，只要发布版本成功，即可正常安装

2. workflow报错行号会不准，如果报错17行，可能会是18/16

3. 特定位置的代码注释会导致问题，如下

   ```yaml
       - id: repo-stars
         run: |
   #        STARS=`curl -s 'https://api.github.com/repos/${{ inputs.repoPath }}?page=$i&per_page=100' | jq .stargazers_count`
           echo "::set-output name=stars::$STARS"
         shell: bash
   ```

4. 这里Action导出了star值，如果不导出stars值，而是采用输出该变量到环境变量上是不行的，workflow中无法使用该值



## 相关文档

官方文档仍然是第一手资料，需要阅读下

- https://docs.github.com/en/actions/creating-actions
- https://docs.github.com/en/actions/creating-actions/publishing-actions-in-github-marketplace

## 写在最后

但凡重复，即是体力，但凡人工，必有失误。最好的办法即自动化。如上每次重新编写获取仓库星星数，显然是个体力活。而如上封装后的action隐藏了实现细节，任何仓库的workflow中只要安装即可使用。



