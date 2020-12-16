import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

//
// todo: app 全局路由表定义
//
class Routes {
  // todo: 根路由
  static String root = '/';

  // todo: 商品详情页
  static String detailsPage = '/detail';

  // todo: 路由注册
  static void configureRoutes(Router router) {
    //
    // todo: error 路由注册: 404 handler
    //
    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('debugX: ERROR====>router not found !!!');
      return;
    });

    //
    // todo: 业务路由注册: (类似 web server, 定义路由匹配表: [url, handler])
    //
    router.define(detailsPage, handler: detailsHandler); // todo: 商品详情 url -> handler
  }
}
