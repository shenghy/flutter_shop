import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';


import './provide/counter.dart';

void main(){
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();;

  var counter =Counter();
  var providers  =Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(child:MyApp(),providers:providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: MaterialApp(
        title:'百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor:Colors.pink,
        ),
        home:IndexPage()
      ),
    );
  }
}