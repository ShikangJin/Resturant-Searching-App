import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String token;

  AuthProvider() {
    token = '';
  }

  handleLogin() {
    token = '1234';
    notifyListeners();
  }
}
