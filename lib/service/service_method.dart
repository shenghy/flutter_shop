import "package:dio/dio.dart";
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

/*
*
* todo: 一些 http post API 定义, 获取后端数据. 恰当归类是属于 dao/http. 归类 service 不恰当
*
* */

//
// todo: http 异步加载数据
//
Future request(url, {formData}) async {
  try {
    //print('开始获取数据...............');
    Response response;

    //
    // todo: http post
    //
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

    print('debugX: http post url: ${servicePath[url]}');

    // post format:
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    // resp:
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

//获得商城首页信息的方法
Future getHomePageContent() async {
  try {
    print('开始获取首页数据...............');
    Response response;

    //
    //
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");

    // todo: http post req
    var formData = {'lon': '115.02932', 'lat': '35.76189'};

    //
    // todo: async do http post
    //
    response = await dio.post(servicePath['homePageContext'], data: formData);

    // todo: http resp
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}

//获得火爆专区商品的方法
Future getHomePageBeloConten() async {
  try {
    print('开始获取下拉列表数据.................');
    Response response;

    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;

    //
    // todo: do http post
    //
    response = await dio.post(servicePath['homePageBelowConten'], data: page);

    //
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
