

# hotfix: 

- 指定 flutter 版本: `1.17.5`
- 修复编译报错: 依赖包版本问题

## 一些代码阅读笔记: 

- [code pick](./code-pick.md)
- 一些功能写法参考.
- 要点: 
    - [x] 路由包使用
    - [x] http (dio) 包使用
    - [x] 跨组件数据传递方式: 基于 provide.
    - [x] 下拉加载页面.
- 最有价值的页面: 商品分类页(跨组件数据传递).
    - 其他页面没啥特别. 
    - 代码风格和习惯不好, 可以改进的点很多.


## 运行: 

```bash 

flutter run 

```

## 修复编译报错:

- flutter 版本: 使用 fvm 管理 flutter 版本. 

```bash

-> % flutter --version
Flutter 1.17.5 • channel unknown • unknown source
Framework • revision 8af6b2f038 (4 months ago) • 2020-06-30 12:53:55 -0700
Engine • revision ee76268252
Tools • Dart 2.8.4


{
  "flutterSdkVersion": "1.17.5"
}

```

- fix service url: lib/config/service_url.dart

```dart

//const serviceUrl= 'http://v.jspang.com:8088/baixing/';
const serviceUrl= 'https://wxmini.baixingliangfan.cn/baixing/';
//const serviceUrl= 'http://test.baixingliangfan.cn/baixing/';


```

## notes: 

- 代码跟踪: 

```bash

- lib/main.dart
    - lib/pages/index_page.dart  // 底部 tab bar 导航栏
        - lib/pages/home_page.dart // 首页
        - lib/pages/category_page.dart // 分类页

```




🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀

🚀

🚀               分割线

🚀

🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀






# Flutter的移动电商实战

项目和教程都在更新中............

完全模仿了百姓生活+小程序的项目，数据来自Fiddle提取，有完整的接口API文档。页面包括首页、商品列表页、商品详细页、购物车页面和会员中心。

目前项目还在开发当中，配有完整的视频和文字教程，是你Flutter进阶必备项目。

## 教程文章地址

教程文章地址(60节，超5万字教程，持续更新中)：[https://jspang.com/post/FlutterShop.html](https://jspang.com/post/FlutterShop.html)

## 用到的组件

- dio:用于向后端接口作HTTP请求数据
- flutter_swiper: 轮播插件，制作了商城首页的轮播效果
- flutter_screenutil:用于不同屏幕的适配，一次设计，适配所有屏幕
- url_launcher:用于打开网页和实现原生电话的拨打
- flutter_easyrefresh：下拉刷新或者上拉加载插件，方便好用，可定制。
- provide：谷歌最新推出的Flutter状态管理插件，亲儿子，用的爽。
- fluttertoast：Toast轻提示插件，APP必不可少，IOS和Android通用。


## 图片展示

![商城图片](http://blogimages.jspang.com/Flutter_shop_01.jpg)


## 所有项目知识点梳理

![知识点梳理](http://blogimages.jspang.com/Flutter%E7%A7%BB%E5%8A%A8%E7%94%B5%E5%95%86%E5%AE%9E%E6%88%98-%E7%9F%A5%E8%AF%86%E7%82%B9%E6%A2%B3%E7%90%86.png)


## 更新日志：

- 商品分类页面增加了打开详细页的功能。[2019/4/23]

- 更新首页的分类导航，跳转到分类页面，并且可以跟随变化。[2019/4/22]

- 商品详细页面主要UI布局完成，还有app的路由系统制作完成。[2019/4/4]

- 第一次上传项目到GitHub上，我已经写了35课教程，把首页和商品分类页面制作完成。[2019/3/28]







## 知识架构图


## 一起学习

我建立了一个QQ群，大家一起学习:

**qq群：806799257**

入群问题：Flutter出自于哪个公司？

入群答案：google (注意全小写，最好用电脑端加入，移动端Bug)




