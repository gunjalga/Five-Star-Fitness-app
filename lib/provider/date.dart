import 'package:flutter/material.dart';

class TodayDate extends ChangeNotifier {
  bool today = true;

  set setToday(value) {
    today = value;
    notifyListeners();
  }

  bool get getToday {
    return today;
  }

}