---
title: 架构决策记录-ADR
date: 2020-05-16 20:03:52
tags:
- ADR
- Architecture
---
> 之前年终Review时，与同事探讨一个项目总是会面临各种情况，而项目底层的架构，也是一直在发展，架构背后的人也是在发展，面对这种发展，我们需要系统反思、调整、分享。只有这样才能校正，才能统一整个team的认知等。
> 
> 在交流中同事推荐我去了解 `Architecture Decision Records (ADRs)`，这个概念之前只是喵了一眼，毫无印象，答应要学也一直没有去学=》惭愧。于是今天还债。


## ADR
ADR全称`Architecture Decision Records`,汉化后就是`架构决策记录`，之所以有这样一个概念，其背景正如上述我所提到的，项目是一个变量，在发展，而在这变化中，我们需要去系统记录梳理这些变化点。对于所有的成员也需要一种形式可以了解这些，而最合适的就是文档化。

## 当前我们是如何做的
1. 博客，我喜欢博客去总结一些变化
2. 公司文档-Confluence
3. 个人脑中

如上，其实缺乏一个系统的理论和方式，so，ADR确实可以补充项目运作上的 一点短板。

## ADR模版
业界的前辈们已经总结了一个，当然这只是个实践的一种，具体我们可以活学活用。这个没有标准答案，有收益即可。

- 模版 [戳这里](https://github.com/pmerson/ADR-template/blob/master/ADR-template_zh-CN.md)
- 视频 [SATURN 2017 Talk: Architecture Decision Records in Action
](https://www.youtube.com/watch?time_continue=19&v=41NVge3_cYo&feature=emb_logo)


## 写在最后

1. cl means changelist，当前项目代码往往是在版本管理系统中，CL可以完全体现我们整个项目的代码层面变化。ADR决策最终一定体现在代码上，但决策与代码并非一对一，并且决策也有不提倡，废弃一说，所以如果单纯ADR放在CL上去做并不合适
2. 架构最终仍然影响的是代码，是项目，所以MD文档化，跟着项目强相关托管挺合适
3. ADR只是个系统化面对软件工程中一个问题的理论，so，活学活用。
