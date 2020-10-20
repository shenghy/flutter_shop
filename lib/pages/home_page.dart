import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

//--------
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/currentIndex.dart';
import '../model/category.dart';

//
// todo: 首页内容
//
class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var formData = {'lon': '115.02932', 'lat': '35.76189'};

    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),

        //
        //
        //
        body: FutureBuilder(
          // todo: http 请求数据
          future: request('homePageContext', formData: formData),

          //
          // todo: 构建页面:
          //    - 有数据: 构建页面.
          //    - 无数据: 提示数据加载中.
          //
          builder: (context, snapshot) {
            //
            //todo: 复杂页面构造
            //
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());

              //
              // todo: part1 - 轮播
              //
              List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 顶部轮播组件数

              //
              // todo: part2 - 二级分类
              //
              List<Map> navigatorList = (data['data']['category'] as List).cast(); //类别列表

              //
              // todo: part2 - 广告
              //
              String advertesPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
              String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
              String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话

              //
              // todo: part3 - 推荐部分
              //
              List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 商品推荐
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
              List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片
              List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片
              List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片

              //
              // todo: 上拉异步加载实现: 基于 flutter_easyrefresh-1.2.7 包实现
              //
              return EasyRefresh(
                //
                // todo: 下拉刷新事件 event
                //
                refreshFooter: ClassicsFooter(
                    key: _footerKey,
                    // todo: 关键参数, 通过 key, 捕捉事件
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText: '',
                    moreInfo: '加载中',
                    loadReadyText: '上拉加载....'),
                child: ListView(
                  //
                  // todo:
                  //
                  children: <Widget>[
                    //
                    // todo: 首页轮播商品
                    //
                    SwiperDiy(swiperDataList: swiperDataList), //页面顶部轮播组件

                    //////////////////////////////////////////////////////////////////////////////////////////

                    //
                    // todo: 头部商品分类, 实现方式?? provider 做了什么? 效果怎么达到的? 跳转第二个 tab???
                    //  这个组件有点特殊, 实现方式
                    //
                    TopNavigator(navigatorList: navigatorList), //导航组件

                    //////////////////////////////////////////////////////////////////////////////////////////

                    // todo: 广告
                    AdBanner(advertesPicture: advertesPicture),

                    // todo: 唤醒手机拨号界面 - 使用第三方 lib
                    LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone), //广告组件

                    //
                    // todo: 推荐商品
                    //
                    Recommend(recommendList: recommendList),

                    //
                    // todo: 中秋
                    //
                    FloorTitle(picture_address: floor1Title),
                    FloorContent(floorGoodsList: floor1),

                    // todo: 国庆
                    FloorTitle(picture_address: floor2Title),
                    FloorContent(floorGoodsList: floor2),

                    // todo: 团员惠
                    FloorTitle(picture_address: floor3Title),
                    FloorContent(floorGoodsList: floor3),

                    //////////////////////////////////////////////////////////////////////////////////////////

                    //
                    // todo: 火热专区 - 异步下拉加载写法.
                    //
                    _hotGoods(),

                    //////////////////////////////////////////////////////////////////////////////////////////
                  ],
                ),

                //
                // todo: 异步加载
                //
                loadMore: () async {
                  print('开始加载更多');
                  //
                  // todo: 分页+异步下拉+刷新技巧, 这个写法.
                  //
                  var formPage = {'page': page};

                  //
                  // todo: 这种写法, 异步请求+对数据.then()处理
                  //
                  await request('homePageBelowConten', formData: formPage).then((val) {
                    var data = json.decode(val.toString());

                    List<Map> newGoodsList = (data['data'] as List).cast();

                    // todo: 注意
                    setState(() {
                      //
                      // todo: 数据获取+写入 list, 这个 list 后续会更新页面列表显示
                      //
                      hotGoodsList.addAll(newGoodsList);

                      //
                      // todo: 分页计数
                      //
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }

  //火爆商品接口
  void _getHotGoods() {
    var formPage = {'page': page};
    request('homePageBelowConten', formData: formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    child: Text('火爆专区'),
  );

  //
  // todo:
  //
  //火爆专区子项
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      //
      // todo: list -> map 写法
      //
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {
              // todo: 页面跳转
              Application.router.navigateTo(context, "/detail?id=${val['goodsId']}");
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: <Widget>[
                  //
                  // todo: 商品信息: 图片+名称+价格
                  //
                  Image.network(
                    val['image'],
                    width: ScreenUtil().setWidth(375),
                  ),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text(' ');
    }
  }

  //火爆专区组合
  Widget _hotGoods() {
    return Container(
        child: Column(
      children: <Widget>[
        hotTitle,

        //
        // todo: 异步下拉加载
        //
        _wrapList(),
      ],
    ));
  }
}

// 首页轮播组件编写
class SwiperDiy extends StatelessWidget {
  // todo: 组件需要的数据 list
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //
      // todo: size
      //
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),

      //
      // todo: 轮播组件
      //
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //
            // todo: 点击事件 - 页面跳转
            //
            onTap: () {
              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },

            //
            //
            //
            child: Image.network("${swiperDataList[index]['image']}", fit: BoxFit.fill),
          );
        },
        itemCount: swiperDataList.length,

        //
        // todo: 分页
        //
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//首页导航组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item, index) {
    // print('------------------${item}');
    return InkWell(
      //
      // todo: 点击事件响应
      //
      onTap: () {
        //
        // todo: 这里的实现??? 怎么做到的???
        //
        _goCategory(context, index, item['mallCategoryId']);
      },

      //
      //
      //
      child: Column(
        children: <Widget>[
          //
          //
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),

          //
          // todo: 分类名称
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  //
  // todo: ??? 这里是怎么处理的???
  //

  void _goCategory(context, int index, String categroyId) async {
    //
    // todo: http post
    //
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);

      List list = category.data;

      ////////////////////////////////////////////////////////////////////////////////////////////////

      //
      // todo: provider 管理数据 ???????
      //
      Provide.value<ChildCategory>(context).changeCategory(categroyId, index);
      Provide.value<ChildCategory>(context).getChildCategory(list[index].bxMallSubDto, categroyId);
      Provide.value<CurrentIndexProvide>(context).changeIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    //
    //
    //
    var tempIndex = -1;

    //
    //
    //
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5.0),
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),

      //
      // todo: 网格
      //
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),

        //
        // todo: 网格元素
        //
        children: navigatorList.map((item) {
          tempIndex++;

          //
          //
          //
          return _gridViewItemUI(context, item, tempIndex);
        }).toList(),
      ),
    );
  }
}

//广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key key, this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      color: Colors.white,
      child: Image.network(advertesPicture),
    );
  }
}

// todo: 唤醒手机拨号界面
class LeaderPhone extends StatelessWidget {
  final String leaderImage; //店长图片
  final String leaderPhone; //店长电话

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        //
        // todo: 打开手机拨号面板
        //
        onTap: _launchURL,

        //
        //
        //
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;

    //
    // todo: 第三方 lib 实现, 唤醒手机拨号界面
    //
    if (await canLaunch(url)) {
      print('debugX: dial phone No: $url');

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  /*
  * todo:
  *  - 控件事件 event - onTap()
  *
  *
  * */

  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          //
          // todo:
          //
          _titleWidget(),

          //
          // todo:
          //
          _recommedList(context)
        ],
      ),
    );
  }

//推荐商品标题
  Widget _titleWidget() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
        decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: Text('商品推荐', style: TextStyle(color: Colors.pink)));
  }

  // todo: 推荐商品列表
  Widget _recommedList(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,

        //
        // todo: 构建商品列表+支持点击跳转到商品详情
        //
        itemBuilder: (context, index) {
          return _item(index, context);
        },
      ),
    );
  }

  //
  //
  //
  Widget _item(index, context) {
    return InkWell(
      //
      // todo: 添加点击事件+响应, 页面跳转->详情页
      //
      onTap: () {
        // todo: 页面跳转
        Application.router.navigateTo(context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        width: ScreenUtil().setWidth(280),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: Colors.white, border: Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            //
            // todo: 商品信息
            //
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address; // 图片地址
  FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品组件
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //
          _firstRow(context),

          //
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodsList[1]),
            _goodsItem(context, floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        //
        //
        //
        onTap: () {
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
