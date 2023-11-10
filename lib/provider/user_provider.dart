import 'dart:convert';

import 'package:e_commerce_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  void setUser(String user) {
    this.user = User.fromMap(jsonDecode(user));
    notifyListeners();
  }

  void setUserFromModel(User user) {
    this.user = user;
    notifyListeners();
  }
}
