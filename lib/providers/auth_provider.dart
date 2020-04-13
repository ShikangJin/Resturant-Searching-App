import 'package:cmpe277_project/entity/User.dart';
import 'package:cmpe277_project/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String token = '';
  User user;

  AuthProvider() {
    token = '';
    // user = User(
    //     1,
    //     'Test User',
    //     'https://images2.minutemediacdn.com/image/upload/c_crop,h_1193,w_2121,x_0,y_64/f_auto,q_auto,w_1100/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg',
    //     'test@gmail.com');
  }

  Future handleRegister(String email, String name, String password) async {
    Response response =
        await signUp(name.trim(), email.trim(), password.trim());
    print(response);
    return response;
  }

  handleLogin(String email, String password, context) async {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    Response response = await login(email.trim(), password.trim());
    if (response?.data != null && response?.data['token'] != null) {
      token = response.data['token'];
      user = User(
          1,
          response.data['name'],
          'https://images2.minutemediacdn.com/image/upload/c_crop,h_1193,w_2121,x_0,y_64/f_auto,q_auto,w_1100/v1565279671/shape/mentalfloss/578211-gettyimages-542930526.jpg',
          response.data['email']);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Incorrect email or password'),
            content: Text("Please enter again",
                style: TextStyle(color: Colors.grey[600])),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * rpx, vertical: 10 * hrpx),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok', style: TextStyle(fontSize: 16))))
            ],
          );
        },
      );
    }
    notifyListeners();
  }

  handleLogout() {
    token = '';
    notifyListeners();
  }
}
