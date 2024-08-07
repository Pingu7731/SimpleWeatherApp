import 'package:flutter/material.dart';

class UIprovider extends ChangeNotifier {
  bool _isdark = false;
  bool get isdark => _isdark;
  bool _checkisicondark = false;
  bool get checkisicondark => _checkisicondark;
  void changeTheme(bool value) {
    _checkisicondark = value;
    _isdark = value;
    notifyListeners();
  }
}
