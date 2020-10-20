
# Pick some codes:

- 代码一些写法.
- 值得参考

## 下拉+异步加载+分页:

- [lib/pages/home_page.dart](lib/pages/home_page.dart)
    - HomePage() : 火爆商品的加载方式. 
        - EasyRefresh() : 基于第三方 lib 实现.


## 动态构建页面:

- [lib/pages/details_page.dart:39](lib/pages/details_page.dart)
    - FutureBuilder(): 动态获取数据+构建页面
    


## 数据状态管理: provider 写法

- [lib/provide/details_info.dart:10](lib/provide/details_info.dart)
    - DetailsInfoProvide()
        - async http post query + notifyListeners 通知
        - 数据获取+通知信号



## provider 定义+实现+交互:

- [lib/provide/cart.dart](./lib/provide/cart.dart)
- 这个购物车 provider, 比较典型. 
- 补充了一些注释, 总结了 provider 的使用特点. 


## xxx:


## xxx:


## xxx:









