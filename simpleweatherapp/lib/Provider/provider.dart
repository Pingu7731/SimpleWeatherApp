import 'package:flutter/material.dart';

class UIprovider extends ChangeNotifier {
  bool _isdark = true;
  bool get isdark => _isdark;

  void changeTheme(bool value) {
    _isdark = value;
    notifyListeners();
  }
}
