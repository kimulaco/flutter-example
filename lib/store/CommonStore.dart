import 'package:flutter/material.dart';

class CommonStore with ChangeNotifier {
  String _userName;

  String get userName { return _userName; }

  void updateUserName(String newUserName) {
    _userName = newUserName;
    notifyListeners();
  }
}