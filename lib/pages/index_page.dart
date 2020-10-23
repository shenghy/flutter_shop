import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/currentIndex.dart';

//
// todo: 首页
//
class IndexPage extends StatelessWidget {
  //
  // todo: 底部导航栏
  //
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  //
  // todo: 页面
  //
  final List<Widget> tabBodies = [
    //
    HomePage(),
    //
    //
    CategoryPage(),
    //
    //
    CartPage(),
    ///
    /// todo: 会员中心
    ///
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    // todo: Provide用法
    return Provide<CurrentIndexProvide>(builder: (context, child, val) {
      // todo: 数据
      int currentIndex = Provide.value<CurrentIndexProvide>(context).currentIndex;

      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          //
          //
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          //
          //
          //
          items: bottomTabs,

          /////////////////////////////////////////////////////////////////////////////
          //
          //
          // todo: 特别注意! provider 只是改变了数据 index, 就实现了 页面跳转 !!!
          // todo: 特别注意! provider 只是改变了数据 index, 就实现了 页面跳转 !!!
          //
          //
          onTap: (index) {
            //
            // todo: 只是更改了 index 值, 就实现了 tab 页面跳转???
            //
            Provide.value<CurrentIndexProvide>(context).changeIndex(index);
          },

          /////////////////////////////////////////////////////////////////////////////
        ),

        //
        // todo: 点击 tab, 跳转的页面
        //
        body: IndexedStack(
            //
            //
            index: currentIndex,
            //
            // todo: 跳转页面
            //
            children: tabBodies),
      );
    });
  }
}

// class IndexPage extends StatefulWidget {

//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage>{

//    PageController _pageController;

//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.home),
//       title:Text('首页')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.search),
//       title:Text('分类')
//     ),
//     BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.shopping_cart),
//       title:Text('购物车')
//     ),
//      BottomNavigationBarItem(
//       icon:Icon(CupertinoIcons.profile_circled),
//       title:Text('会员中心')
//     ),
//   ];
//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage()
//   ];
//   int currentIndex= 0;
//   var currentPage ;
//   @override
//   void initState() {
//    currentPage=tabBodies[currentIndex];
//    _pageController=new PageController()
//       ..addListener(() {
//         if (currentPage != _pageController.page.round()) {
//           setState(() {
//             currentPage = _pageController.page.round();
//           });
//         }
//   });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         type:BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items:bottomTabs,
//         onTap: (index){
//           setState(() {
//           //  currentIndex=index;
//           //   currentPage =tabBodies[currentIndex];
//           });

//         },
//       ),
//       body:Provide<CurrentIndexProvide>(
//         builder: (context,child,val){

//           return IndexedStack(
//               index: 0,
//               children: tabBodies
//             );
//         },
//       )
//     );
//   }
// }
