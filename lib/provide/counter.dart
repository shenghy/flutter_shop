import 'package:flutter/material.dart';

// todo: 计数器
class Counter with ChangeNotifier {
  int value = 0;

  increment() {
    value++;

    // todo: 注意这里
    notifyListeners();
  }
}
