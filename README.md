# SinaWeibo-WatchKit
WatchKit 新浪微博Demo
-------
###demo简介：
实现功能：watch模拟器与iphone模拟器通讯，<br>
让iphone向新浪微博请求微博数据并保存至本地数据库，<br>
再让watch通过app Group 获取数据并显示。
###运行步骤：
####1.申请新浪微博开放平台接口使用<br>
由于使用了新浪微博接口，<br>
所以需要在[新浪微博开放平台](http://open.weibo.com/)申请应用<br> 
####2.当申请了应用之后，需要在申请的应用的应用信息页面，<br>
找到新浪提供的APP key，App secret，<br>
以及自己填写的应用地址（此地址可以随便写，并不影响）<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/weiboPage.png) <br>
填写到项目中OAuth授权下的LYROAuthViewController.m文件的三个宏<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/OAuth.png)<br>
####3.修改应用对应的开发者账号<br>
由于watchkit应用与iphone应用数据共享，<br>
需要打开APP Group 功能，<br>
需要修改项目以下两个target对应的开发者账号<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeAppleId01.png)<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeAppleId02.png)<br>
####4.修改应用bundle id<br>
由于开发者账号变化，需要修改应用的bundle id,<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeBundleId01.png)<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeBundleId02.png)<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeBundleId03.png)<br>
需要注意的是，由于watchkit的target较多，<br>
需要仔细检查WatchKit App,WatchKit Extension的bundle id,<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeBundleId04.png)<br>
不然模拟器运行时会报：SPErrorInvalidBundleNoGizmoBinaryMessage错误<br>
5.修改target的App Group 标识<br>
修改两个target的App Group标识<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeAppGroup01.png)<br>
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeAppGroup02.png)<br>
6.修改LYRWeiboKit文件夹中LYRAppGroup.h文件的App Group标识宏
![](https://github.com/kof97500/SinaWeibo-WatchKit/raw/master/images/changeAppGroup03.png)<br>


