import 'package:cmpe277_project/pages/home.dart';
import 'package:cmpe277_project/pages/login.dart';
import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Container(
      child: auth.token != '' ? Home() : Login(),
    );
  }
}
