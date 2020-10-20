import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './provide/counter.dart';

void main() {
  //
  // todo: provider 数据定义
  //
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var counter = Counter();

  //
  // todo: 数据状态管理
  //
  var providers = Providers();

  //
  // todo: 全局注册 provider 写法
  //
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<Counter>.value(counter));

  //
  // todo: 基于 provider 进行数据状态管理
  //
  runApp(ProviderNode(
      //
      //
      //
      child: MyApp(),

      //
      // todo: 挂载
      //
      providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    // todo: 路由
    //
    final router = Router();

    // todo: 路由注册 handler
    Routes.configureRoutes(router);

    // todo: 全局变量, 这个写法不清晰, 可以改进
    Application.router = router;

    return Container(
      child: MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,

          //
          // todo: 路由生成
          //
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
            primaryColor: Colors.pink,
          ),

          //
          // todo: 首页入口
          //
          home: IndexPage()),
    );
  }
}
