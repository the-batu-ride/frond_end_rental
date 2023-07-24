import 'package:flutter/material.dart';
import 'package:frond_end_rental/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setLoginnedUser(User user) {
    _user = user;
    notifyListeners();
  }
}
