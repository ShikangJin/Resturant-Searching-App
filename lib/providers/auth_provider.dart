import 'package:cmpe277_project/entity/User.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String token;
  User user;

  AuthProvider() {
    token = '';
    user = User(
        1,
        'Test User',
        'https://images2.minutemediacdn.com/image/upload/c_crop,h_1193,w_2121,x_0,y_64/f_auto,q_auto,w_1100/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg',
        'test@gmail.com');
  }

  handleLogin() {
    token = '1234';
    notifyListeners();
  }

  handleLogout() {
    token = '';
    notifyListeners();
  }
}
