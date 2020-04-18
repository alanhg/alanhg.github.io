---
title: 项目引入WebSocket
tags:
  - WebSocket
  - Spring Boot
abbrlink: 9896a547
date: 2020-04-16 22:57:20
---
> 最近项目存在一个需求，就是用户从我们A系统中打开标签页操作B系统，在点击某个操作按钮时，回call我们系统的API，改变一些数据。而我们要做到在事件爆发时，执行一些列动作，比如--页面刷新。
这个需求的背后其实在告诉我们系统需要具备后端主动推送消息到前端的能力。如何做呢？WebSocket.

于是，开始搭建支持。

![](http://static.1991421.cn/2020/2020-04-16-235427.png)

## Tech Stack

首先，介绍下当前项目的技术栈

- React `v16.4.2`
- SpringBoot `v2.1.6.RELEASE`

WS技术本身已经很成熟，所以这两块的配置开发没有多难，这里贴下关键代码块

## SpringBoot

```java

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/topic");
        config.setApplicationDestinationPrefixes("/app");
    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/websocket").setAllowedOrigins("*").withSockJS();
    }

}
```

```java
@RestController
public class GreetingController {
    private final SimpMessagingTemplate simpMessagingTemplate;

    public GreetingController(SimpMessagingTemplate simpMessagingTemplate) {
        this.simpMessagingTemplate = simpMessagingTemplate;
    }

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Greeting greeting(HelloMessage message) throws Exception {
        System.out.println("Request: get message: " + message);
        return new Greeting("Response: Hello, " + HtmlUtils.htmlEscape(message.getName()) + "!");
    }

    @GetMapping("/broadcast")
    public String sendBroadcastCommand(@RequestParam String command) {
        simpMessagingTemplate.convertAndSend("/topic/broadcast", command);
        return command;
    }
}
```


## React

```html
<script src="static/js/stomp.min.js"></script>
<script src="static/js/sockjs-1.0.0.min.js"></script>
```


```typescript

function watchBroadcast() {
  const socket = new SockJS('/websocket');
  const client = Stomp.over(socket);
  client.connect(
    {},
    () => {
      client.subscribe('/topic/broadcast', res => {
       console.log(res.body)
        });
    }
  );
}
```

## 效果
当call了`/broadcast`API,则后端会发送消息到前端。

就是如此简单，但是在实际开发中还是会有些许坑的，继续看

## 注意点

1. 如果后端有`拦截器`，注意进行下白名单设置，比如这里的`/websocket`,否则会报`302`
2. `SocketJS前后端版本需要对应`，这里我的后端SocketJS版本是`1.0.0`，所以相应前端sockjs也要是`1.0.0`,否则会报兼容性错
3. 在实际开发中遇到了本地运行OK，部署上去报500错，原因是部署打包使用了`spring-boot-starter-undertow`,而本地运行实际上走的不是这个容器，我这里是最终选择去掉了它。但请注意undertow应该是支持的，只是版本问题。
4. 我的场景是后端API被call进而发消息给前端，所以是GetMapping与simpMessagingTemplate同时使用，假如是双通讯，第一个例子即可。GetMapping与SendTo双注解测试不OK，看来这种场景下，必须这么写
5. WebSocket不会增加新的端口号，还是80和443，但是因为通讯用了WS协议，所以容器层比如Nginx和浏览器客户端需要支持
6.  同一服务连接可以建立多个，统一事件可以订阅多个，所以要注意，否则可能出现重复处理问题，并且也造成了冗余资源开销

## 写在最后
- 为何需要有WebSocket呢，看这样一句话`HTTP 协议有一个缺陷：通信只能由客户端发起，而WS的引入可以让WEB前后端具备了双向通讯能力`，SO，何时该用，很明确。
- 我所在的引入了WS，使得类似场景的需求变的很简单`比如服务端定向收集客户端信息等等`，所以值得。


## 参考文档
- [WebSocket 教程](http://www.ruanyifeng.com/blog/2017/05/websocket.html)
- [What is the difference between WebSocket and STOMP protocols?](https://stackoverflow.com/questions/40988030/what-is-the-difference-between-websocket-and-stomp-protocols/48373153)
- [完全理解TCP/UDP、HTTP长连接、Websocket、SockJS/Socket.IO以及STOMP的区别和联系](https://juejin.im/post/5da95a745188252ba420ab39#comment)