import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

//
// todo: 商品详情页 - 路由 handler
//
Handler detailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;

  print('debugX: router >> index >> goods details - goodsID is ${goodsId}');

  return DetailsPage(goodsId);
});
