---
title: CI优化-自动发起MR
date: 2020-08-02 15:45:22
tags:
- GitLab
- CI
- Merge Request
---
> 在实际的项目分支管理中，我们往往有这样的需求，当我们面向生产-直接修复一个bugfix，生产分支确定OK后，我们还需要手动发起MR到其它分支，分支环境多了，这个问题会显的愈发啰嗦，因为完全是个体力活。但凡人工，必有失误，那么这个流程能否自动化呢。

## 分支自动化设想

![](https://static.1991421.cn/2020/2020-08-02-154614.jpeg)

简要介绍下图中的几个环境也即分支

1. master即我们的生产
2. uat即业务测试环境
3. sit即团队内测试人员测试环境
4. dit即我们从事开发的集成环境


当前的工作流程是，如果我们基于master即生产修复了一个bug,那么这个fix/456就会人工合并到master，但接下来这些代码还需要合并到uat=>sit=>dit，最终流入DIT开发主干，因为这几个分支实际上是个包含关系。于是，就造成了开发或者运维人员的重复操作。


正如一开始提到的，但凡人工必有失误。久而久之，这样的操作流程大概率出现的悲剧就是忘记了MR-也就是丢失代码。因此必须做到自动化。


## 自动化实现
借着周末的时间，完善了下Team的这块自动化。实现的基本原理实际上只是shell脚本发起了请求，毕竟gitlab本身是开放了API，所以具备了可行性。


.gitlab-ci.yml

 ```yml
 image: xxxxx/alpine:latest

variables:
  PRIVATE_TOKEN: NcWQWe9nLhxgrkNEg1Zs # gitlab账户的私有令牌

stages:
  - openMr
  
cache:
  paths:
    - node_modules

# Merge UAT 到 SIT
openMr:
  image: "xxxxx/node:10.16.0"
  before_script: [] 
  stage: openMr
  variables:
    TARGET_BRANCH: sit
  only:
    - /^uat\/*/ # We have a very strict naming convention
  except:
    variables:
      - $CI_COMMIT_MESSAGE =~ /Merge branch 'sit' into 'uat'/
  script:
    - chmod +x ./scripts/merge-request.sh
    - HOST=${CI_PROJECT_URL} CI_PROJECT_ID=${CI_PROJECT_ID} CI_COMMIT_REF_NAME=${CI_COMMIT_REF_NAME} GITLAB_USER_ID=${GITLAB_USER_ID} PRIVATE_TOKEN=${PRIVATE_TOKEN} TARGET_BRANCH=${TARGET_BRANCH} ./scripts/merge-request.sh 

 ```
 
 
 merge-request.sh
 
```shell
  #!/usr/bin/env bash
# Extract the host where the server is running, and add the URL to the APIs
[[ $HOST =~ ^https?://[^/]+ ]] && HOST="${BASH_REMATCH[0]}/api/v4/projects/"

# The description of our new MR, we want to remove the branch after the MR has
# been closed
BODY="{
    \"id\": ${CI_PROJECT_ID},
    \"source_branch\": \"${CI_COMMIT_REF_NAME}\",
    \"target_branch\": \"${TARGET_BRANCH}\",
    \"remove_source_branch\": true,
    \"title\": \"WIP: ${CI_COMMIT_REF_NAME}到${TARGET_BRANCH}合并",
    \"assignee_id\":\"${GITLAB_USER_ID}\"
}";

# Require a list of all the merge request and take a look if there is already
# one with the same source branch
LISTMR=`curl --silent "${HOST}${CI_PROJECT_ID}/merge_requests?state=opened" --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}"`;
COUNTBRANCHES=`echo ${LISTMR} | grep -o "\"source_branch\":\"${CI_COMMIT_REF_NAME}\"" | wc -l`;

# No MR found, let's create a new one
if [ ${COUNTBRANCHES} -eq "0" ]; then
    curl -X POST "${HOST}${CI_PROJECT_ID}/merge_requests" \
        --header "PRIVATE-TOKEN:${PRIVATE_TOKEN}" \
        --header "Content-Type: application/json" \
        --data "${BODY}";

    echo "Opened a new merge request: WIP: ${CI_COMMIT_REF_NAME} and assigned to you";
    exit;
fi

echo "No new merge request opened";

```
 
下载[戳这里 ](https://gist.github.com/alanhg/19a9483222bb309a62776901f0493b57)
  
### 注意
 看似很简单的配置，实际上还是有一些坑
 
 1. 执行shell需要chmod+x，不然会报没权
 2. except那里之所以会利用CI_COMMIT_MESSAGE进行正则筛选，是因为比如UAT分支发生了SIT MR到UAT这种情况就需要避免触发MR，不然UAT又会MR到SIT，这不就是个死锁吗。


## 写在最后

- 看似一小步，但解决了人力成本，还是有价值的。
- 原理上来说仍然是git的钩子配合了脚本化访问GitLab API请求,因此假如
- 不是用GitLab的CI机制，实际上利用Jenkins也可以解决。


## 参考文档
- [How to automatically create a new MR on GitLab with GitLab CI](https://about.gitlab.com/blog/2017/09/05/how-to-automatically-create-a-new-mr-on-gitlab-with-gitlab-ci/)