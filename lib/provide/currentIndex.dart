import 'package:flutter/material.dart';

//
// todo: 关键, 底部 bar 的页面切换
//
class CurrentIndexProvide with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int newIndex) {
    currentIndex = newIndex;

    //
    //
    //
    notifyListeners();
  }
}
