---
title: 'GitHub项目Star,实现Telegram通知'
tags:
  - GitHub
  - GitHub Actions
  - Telegram
  - Telegram Bot
abbrlink: 6f739775
date: 2021-01-25 23:29:33
---

> 很喜欢开源项目获得的成就感，近一年坚持做了几个开源项目，也收获了网友的一些Star，有些还加微信，提需求等，开源魅力也就在这里吧。
>
> 那么比如有人Star你的项目，能够及时收到电报通知会更好点，因为之前已做过NPM包发版通知，因此这个做起来也就简单了，但因为还是有些小坑，这里Mark下，兴许帮到些朋友。



![](https://static.1991421.cn/2021/2021-01-25-234819.jpeg)



## 配置

```yaml
env:
  REPO_NAME: ${{ github.event.repository.name }}
steps:
      - name: Notify
        uses: appleboy/telegram-action@master
        with:
          to: ${{ secrets.TELEGRAM_TO }}
          token: ${{ secrets.TELEGRAM_TOKEN }}
          message: Someone stars **${{env.REPO_NAME}}** repository, see [here](https://github.com/${{github.repository}}).
          format: markdown
```

完整配置[戳这里](https://github.com/alanhg/alfred-workflows/blob/master/.github/workflows/main.yml)



## 配置说明

GitHub Action中的变量有很多中，`${{ github.event.repository.name }}`、`${{github.repository}}`为上下文环境变量，这个不需要配置，直接使用，`${{ secrets.TELEGRAM_TO }}`为仓库配置变量，需要在仓库设置中设定。



### GITHUB_SERVER_URL 不能用？

官网有说到默认环境变量有`$GITHUB_SERVER_URL`，且使用方式是`$GITHUB_SERVER_URL`，但如果写在上述的message中会不work，原因是环境变量是针对于使用shell时作为使用，如果是job step中需要使用github上下文



### Telegram配置参数获取

- TELEGRAM_TOKEN
  - 通过@BotFather，创建Bot获取，注意Token完整格式会是这样`12345678:BBFntuCD6nRx1ZIYZ-eCyfP1UO4FeAjnz2M`
- TELEGRAM_TO
  - 先随便给该bot发送一条信息，确保开启了聊天
  - 访问 https://api.telegram.org/bot/12345678:BBFntuCD6nRx1ZIYZ-eCyfP1UO4FeAjnz2M/getUpdates，获取其中的chatID

## 写在最后

如上即可实现自定义电报通知，搞起来吧。
