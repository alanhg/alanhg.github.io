---
title: 利用工具提升前端代码质量-SonarQube
tags:
  - Sonar Qube
  - Code Review
abbrlink: 902b069f
date: 2021-01-28 15:15:19
---

> 最近后端项目中投入使用了SonarQube，响应他们的号召，我在前端也开始使用。随着使用的同时，也发现之前对于Sonar的认知有错，这里Mark下。



## SonarQube VS ESLint

作为前端ESlint再熟悉不过了，ESLint本身确保了代码风格的一致，再加上我们的UT，之前认为不需要Sonar的存在，但当实际使用后发现SonarQube与ESLint有所不同。

1. ESLint仅仅是代码风格的检测，我们关注的是每次检测出现的问题，然后`人工/自动`修复问题
2. Sonar代码除了风格检测，还可以检测出一些写法上的问题即潜藏BUG，并且提供了趋势图，这样可以了解进展情况

由此可以确定，Sonar更强大丰富些，一定程度可以与ESLint互补，在大型项目及人员参差不齐的情况下，可以一定程度的为项目保驾护航，值得一试。



## 配置

如何配置呢，大致如下

1. SonarQube Web创建新项目
2. 项目下增加`sonar-project.properties`，按需配置，
3. GitLab CI增加如下PipeLine

```
sonar:
  stage: sonar_scanner
  image: "nexus.abc.cn/sonarsource/sonar-scanner-cli:4"
  allow_failure: true
  services:
    - docker:stable-dind
  script:
    - sonar-scanner -Dsonar.projectKey=$SONAR_QUBE_PROJECT_KEY
  only:
    - /^sprint/
```

如上，当新提交到sprint前缀的分支时即会触发sonar扫描。当然这只是第一步，以后根据实际情况调整检测配置即可。

## 写在最后

人工必有失误，即使是再高超的程序员，因此Sonar这类的工具可以填补人工的不足，时刻提醒我们系统有哪些潜在的问题。

## 参考资料

- https://stackshare.io/stackups/eslint-vs-sonarqube