---
title: ionic实现oauth授权
tags:
  - ionic
  - oauth
  - wakatime
  - codetracker
abbrlink: 3ca825ae
date: 2017-07-09 00:19:04
---
## 背景
最近在开发一款APP-CodeTracker,其实就是使用WakaTime-API拿到一些数据进行APP展示，而获取这些数据有两种办法，第一种是本身WakaTime账号给与的API-KEY，另一种方式是oauth2授权，用户通过登录账户授权给该APP，进而拿到授权后的令牌，获取相关信息。
本身输入API-KEY是最简单的方式，但是在实际使用中，因为APIKEY是很长且无需的字符串，用户并不可能记住，所以必须实现授权登录，查阅资料最终实现了这个功能，效果如下

![wakatime-oauth](//static.1991421.cn/wakatime-oauth.gif)

## 实现方法

### 主要代码
仅贴重要部分
```typescript
@Component({
    selector: 'page-welcome',
    templateUrl: 'welcome.html'
})
export class WelcomePage {

    apiKey: string = '';
    loading: Loading;
    accessToken: string;

    constructor(public navCtrl: NavController,
                private apiService: ApiService,
                private authService: AuthService,
                public loadingCtrl: LoadingController,
                private iab: InAppBrowser) {
        this.loading = this.loadingCtrl.create({
            spinner: 'bubbles',
            showBackdrop: true
            // content: 'Please wait...'
        });
    }


    /**
     * wakatime授权
     */
    grantClicked() {
        let url = `https://wakatime.com/oauth/authorize?client_id=${CLIENT_ID}&response_type=token&redirect_uri=${REDIRECT_URI}&scope=email,read_stats`;
        let browser = this.iab.create(url, "_blank", "location=no,clearsessioncache=yes,clearcache=yes");
        let listener = browser.on('loadstart').subscribe((event: any) => {
            //Ignore the wakatime authorize screen
            if (event.url.indexOf('oauth/authorize') > -1) {
                return;
            }
            //Check the redirect uri
            if (event.url.indexOf(REDIRECT_URI) > -1) {
                listener.unsubscribe();
                browser.close();
                let token = event.url.split('=')[1].split('&')[0];
                console.log(event.url);
                this.accessToken = token;
                LocalSettingService.setAuthorization(this.accessToken);
                this.login();
            } else {
                console.log("Could not authenticate");
            }
        });
    }
}


```
### 说明
+ 原理上:这里其实就是APP内部启动浏览器，让用户登录对应平台输入用户名密码后，授权成功会回调，且带上了令牌，这个时候只要监听到浏览器URI变化了，拿到对应的令牌，然后继续执行目标操作即可。
+ `REDIRECT_URI`对于APP的话，就是`http://localhost`
+ 我这里登录授权成功,回调后的URI如下
```
http://localhost/#access_token=sec_VjDDAPwUz8b6p6RezqckosgD2oNVqS0aYyuFGo4gpEYsRpIVcgmxzXTId8iKpelEszZpuzQJc4cWM6Na&refresh_token=ref_EDkGC1NyhcnEU76mYlg7FRuWdymLDNDUcvF4NhqT4UNUUECPqIGrM1xU2mXzSyfmTCvqn9sVdn2baO6k&scope=email%2Cread_stats&uid=1fcb745b-b90e-4660-9c2d-2ae97a8ba010&token_type=bearer&expires_in=43200
```
其它授权系统类似。
+ 关于oauth有不明白的，建议看阮一峰老师的文章[理解OAuth 2.0](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)
