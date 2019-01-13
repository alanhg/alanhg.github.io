---
title: 写个Alfred Workflow，方便看电视剧
date: 2019-01-13 12:22:12
tags:
- Alfred
- Workflow
---

> Alfred鼎鼎大名，有人说，Mac自带Spotlight,不也一样吗？不一样，Alfred最厉害的是workflow，利用它你可以查询GitHub项目，查API文档，查单词，查IP等等。

当然除了网上一些的workflow之外，我们往往也都有自己的个性化需求，这时就可以自己尝试写几个。我就有这样的需求，所以花了点时间，把玩了下，这里以一个电视剧检索插件为例，记录下编写中要点，兴许帮到写朋友。

## 初始化Workflow
打开Alfred设定，点击左下角的加号，选择blank Workflow

按照提示，填写名称，分类，描述等。
![](http://static.1991421.cn/2019-01-13-035730.png)

## 添加ScriptFilter
我这里因为需要利用脚本去实现，所以选择添加Script filter.`右键 => inputs => Script Filter`
依次填写信息

这里的language可还算丰富，我考虑使用NodeJS来实现脚本，所以选择bash,利用bash去执行Node，这里填写脚本如下
```bash
/usr/local/bin/node yy.js "{query}"
```
{query}指的是在alfred输入框中参数

![](http://static.1991421.cn/2019-01-13-035809.png)

### 说明
- keyword指的是唤起Alfred，输入的关键词，比如这里我写yy，即输入yy，会进入该插件，参数上，我选择可空
- placeholder指的是还没返回结果前的提示信息


## 具体脚本实现
上面的脚本确保了在用户唤起Alfred，输入yy及参数执行了yy脚本，那么下来就是脚本具体实现，从而返回结果给Alfred了

```javascript
const cheerio = require('cheerio');
const axios = require('axios');
const fs = require('fs');
const url = 'http://ly6080.com.cn'
var keyword = process.argv[2];
console.error(keyword);

async function searchMovies() {
    const res = await axios.get(url + '/index.php?m=vod-search&wd=' + encodeURI(keyword));
    var $ = cheerio.load(res.data);
    var arr = $('.index-area').find('li');
    var result_array = [];
    for (var i = 0; i < arr.length; i++) {
        const item = arr.eq(i);
        const actors = [];
        item.find('.actor').each(function (i, elem) {
            actors.push($(this).text());
        });
        const imgUrl = item.find('img').attr('data-original');
        const imgName = imgUrl.slice(imgUrl.lastIndexOf('/') + 1);
        if (!fs.existsSync('./thumbs/' + imgName)) {
            const imgData = (await axios.get(imgUrl, { responseType:"arraybuffer" })).data;
            fs.writeFileSync('./thumbs/' + imgName,imgData);
        }
        result_array.push({
            title: item.find('.name').text(),
            subtitle: actors.join('/'),
            arg: url + item.find('.link-hover').attr('href'),
            icon: {
                path: __dirname + '/thumbs/' + imgName
            }
        })
    }
    console.log(JSON.stringify({ items: result_array }));
}
searchMovies();


```

### 说明
- Alfred对返回结果的结构是有要求的，所以最后console打印的对象结构是必须如此的，具体结构看[官方文档](https://www.alfredapp.com/help/workflows/inputs/script-filter/json/)
- js脚本里的结果，是以log形式传给bash命令，也就是流入alfred，假如注掉最后一句话，会失效
- 我这里因为想实现电影海报的展示，所以实现了图片的本地缓存化，当然弊端就是延迟明显，为了降低延迟，所以做了点判断，如果有就不再下载。


## 添加action-打开URL
当前面得到了检索的目标影片信息后，那么就应该是打开URL了，所以选中刚才的Script Filter，右键 => Insert After => Actions => Open URL,`query就是上一步结果中的arg`

![](http://static.1991421.cn/2019-01-13-040621.png)

## 添加通知
为了进一步提升体验，来个通知，右键 => Insert After => Outputs => Post Notification 

## 最终效果

![](http://static.1991421.cn/2019-01-13-041740.png)

## 写在最后
以前为了看电视剧，需要打开浏览器，输入网址，搜索电视，点击观看，总共有4部，现在只需要唤起Alfred，输入`yy 超人`，选择要看的电视，回车即可以观看。节约点时间，这就再开心不过了。

插件托管进[alfred-workflows](https://github.com/alanhg/alfred-workflows)

## 相关链接

* https://www.alfredapp.com/help/workflows/inputs/script-filter/json/
* https://www.cnblogs.com/MuYunyun/p/7323128.html
* https://www.alfredforum.com/topic/3873-script-filter-icon-from-url/

