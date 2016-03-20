# Objective-C Demos

Objective-C 中各种实用的demos

## 目录

- 00-实用分类
	- Foundation+XNExtension:重写系统方法，过滤掉Array中添加或者访问元素为nil崩溃的情况
	- NSString+XNDirectory: 获取沙盒中缓存文件路径
	- NSObject+Log: 打印数组、字典中元素(将.m文件拖进工程即可)
	- UIFont+ItalicChineseFont: 获取倾斜的中文字体(中文不支持倾斜，这里是设置倾斜角度)
	- NSString+base64(支持iOS7以上版本)
    - UIImage+XNExtension:通过UIColor产生一个单色图片
    - NSTimer+Convince:使用Block将NSTimer封装起来更好用
  
- 01-使用AVPlayer封装的视频播放Demo
  
- 02-二维码
  
  	- 01-生成二维码
  
  	- 02-扫描二维码
  
- 03-通讯录中联系人信息的获取
  
  - 01-通讯录(弹出UI)的联系人信息的获取
  - 02-通讯录(不弹出UI)的联系人信息的获取
  
- 04-皮肤工具类Demo
  
- 05-硬件信息的获取

- 07-网络图片加载(支持图片内存缓存，使用BlockOpertion封装下载操作)

- 08-网络图片加载(支持图片沙盒缓存，使用自定义XNDownLoadOperation封装下载操作)

- 09-网络图片加载(使用NSCache做图片的缓存容器，并可以设置最多缓存的图片数减少内存占用，但会增加文件读写，因为首先从本地读文件，读不到采取网络加载)

- 10-应用程序通知（当程序从后台进入前台后，如果当前控制器被激活要执行刷新操作）

- 11-NSCache的使用（专业缓存类，类似于NSDictionary）

- 12-NSNotificationCenter技巧（多控制器中使用通知中心监听全局消息，如果多个控制器都想响应，在viewDidLoad中添加观察者，dealloc中移除；如果只有当前激活的控制器希望响应，可以在viewDidAppear中添加观察者，viewDidDisappear中移除观察者）

- 13-Socket编程Demo

- 14-根据label的内容计算cell的高度Demo

- 15-请求URL中包含中文需进行的转义Demo

- 16-重载实现竖直button

- 17-UIImage分类：实现通过UIColor产生一个单色图片的Demo