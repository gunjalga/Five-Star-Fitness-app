import 'package:flutter/material.dart';

class Subscribed extends ChangeNotifier {
  bool sub = false;

  set setSub(value) {
    sub = value;
    notifyListeners();
  }

  bool get getSub {
    return sub;
  }

}