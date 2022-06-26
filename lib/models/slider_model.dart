import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double? _currentpage = 0;

  double? get getCurrentPage => _currentpage;

  set setCurrentPage(double? page) {
    _currentpage = page;
    notifyListeners();
  }
}