import 'package:flutter/material.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  //
  // todo: model 字段定义
  //
  List<CategoryListData> goodsList = [];

  ////////////////////////////////////////////////
  //
  // todo: action 行为定义
  //
  ////////////////////////////////////////////////

  //点击大类时更换商品列表
  getGoodsList(List<CategoryListData> list) {
    goodsList = list;

    //
    //
    //
    notifyListeners();
  }

  //上拉加载列表
  addGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);

    //
    //
    //
    notifyListeners();
  }
}
