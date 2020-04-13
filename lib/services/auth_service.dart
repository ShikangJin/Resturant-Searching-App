import 'package:dio/dio.dart';

Future login(String email, String password) async {
  print('http://10.0.2.2:8080/auth/login');
  print(email);
  print(password);
  var result = await Dio().post("http://10.0.2.2:8080/auth/login",
      data: {"email": email, "password": password}).catchError((error) {
    print(error);
  });
  print(result);
  return result;
}

Future signUp(String name, String email, String password) async {
  print('http://10.0.2.2:8080/auth/signup');
  print(name);
  print(email);
  print(password);
  var result = await Dio().post("http://10.0.2.2:8080/auth/signup", data: {
    "email": email,
    "password": password,
    "name": name
  }).catchError((error) {
    print(error);
  });
  print(result);
  return result;
}
