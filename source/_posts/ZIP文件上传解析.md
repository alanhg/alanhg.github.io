---
title: ZIP文件上传解析
date: 2021-07-11 15:22:51
tags:
- JavaScript
- IO
---

> 最近在做上传功能，需要将ZIP文件读取内容传到后台，后台将数据写入创建ZIP文件，最后解压处理，但是联调时，报错提示ZIP文件不合法。

由报错可以断定写入ZIP文件的字节流肯定不对。



## 当前代码

查了下当前的读取ZIP文件的代码如下

### 前端

```javascript
   const reader = new FileReader();
      reader.readAsText(file, 'UTF-8'); 
      reader.onload = (evt) => {
        setUploadContent(Base64.encode(evt.target.result));
      };
```

### 后端

而后端`go语言`的写入代码大致如下

```go
	decContractsSource, err := base64.StdEncoding.DecodeString(h.Req.ContractsSourceBase64)
	if err != nil {
		msg := fmt.Sprintf("base64 DecodeString error %v", err)
		seelog.Errorf(msg)
		h.SetBaseResponse(apiCommon.ErrCodeInternalError, msg)
		return
	}
	content := []byte(decContractsSource)
	err = ioutil.WriteFile("hellooworld.zip", content, 0644)
	if err != nil {
		msg := fmt.Sprintf("WriteFile error, AppId{%v} %v", h.Req.AppId, err)
		seelog.Errorf(msg)
		h.SetBaseResponse(apiCommon.ErrCodeInternalError, msg)
		return
	}
```

可以看出后端只是解码，然后构造字节流写入ZIP文件。



问题大概率是前端读取上存在问题。



## 关于ZIP

以下摘自WIKI

> **ZIP** is an [archive file format](https://en.wikipedia.org/wiki/Archive_file_format) that supports [lossless data compression](https://en.wikipedia.org/wiki/Lossless_compression). 

而JS中`reader.readAsText`是读取文本类型文件，ZIP本身是个压缩格式，如果按照文本读取，应该是会丢失部分字节数据。所以这里确实有错。



## JS下的几个readAPI

- FileReader.readAsDataURL()
  - 文件读写，且会进行base64编码
- FileReader.readAsText()
  - 文本文件读写

- FileReader.readAsArrayBuffer()
  - 二进制数组
  
- ~~FileReader.readAsBinaryString()非标准API，已废除~~

对于ZIP，不能使用`readAsText`，于是这里换成`readAsDataURL`，同时，编码后字符串因为有前缀MIME，因此要去掉`data:application/zip;base64,`

最终改写后，测试OK。



## Demo

- 为了验证这个问题，这里做了个小[Demo](https://github.com/alanhg/express-demo)，感兴趣的可以看看。

- `FileReader.readAsDataURL()`适用文本/压缩文件，因此在使用中可以完全替代`readAsText`



这里贴下关键代码块

```javascript
const reader = new FileReader();
reader.readAsDataURL(file); 
···
fileContent = evt.target.result.replace(/^(data:[a-z-\/]+;base64,)/, '')
···

···
// 后端
const buff = new Buffer(req.body.file, 'base64');
fs.writeFileSync(`./test.${req.body.fileType === 'zip' ? 'zip' : 'txt'}`, buff);
···
```



## 其它坑

这里我的文件上传类型限制在`.zip`，但是Mac-chrome下发现，xlsx也被允许，查了下资料发现。xlsx本身也是压缩格式，因此会被允许。对此只能在JS层面再强化限制。



## 写在最后

- 压缩文件的本质是利用算法将A长度大小的内容压缩为B长度，而普通文本文件并不会进行压缩，因此如果使用readAsText进行读取，长度自然比真实的会短。

  





