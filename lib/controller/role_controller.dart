import 'package:flutter/material.dart';

class UserType extends ChangeNotifier {
  String _usertype = '';
  String get usertype => _usertype;

  set setuserType(String usertype) {
    _usertype = usertype;
    notifyListeners();
  }
}
