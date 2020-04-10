import 'package:cmpe277_project/pages/register.dart';
import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 30 * hrpx),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Restuarant Finder",
                      style: TextStyle(
                          fontSize: 30, color: Color(theme.primaryColor)),
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 80 * rpx),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          // if (value.isEmpty) {
                          //   return 'Username';
                          // }
                          // return null;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        onSaved: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          // if (value.isEmpty) {
                          //   return 'Username';
                          // }
                          // return null;
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 12 * hrpx),
                          child: MaterialButton(
                            minWidth:
                                double.maxFinite, // set minWidth to maxFinite
                            color: Color(theme.primaryColor),
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.
                                // Scaffold.of(context).showSnackBar(
                                //     SnackBar(content: Text('Processing Data')));
                                print("login");
                                auth.handleLogin();
                              }
                            },
                            child: Text("Log in",
                                style:
                                    TextStyle(color: Color(theme.thirdColor))),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 12 * hrpx),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Don\'t have an account yet?',
                                style: TextStyle(fontSize: 16)),
                            GestureDetector(
                              onTap: () {
                                print('sign up page');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage(theme: theme)),
                                );
                              },
                              child: Text(' Sign up',
                                  style: TextStyle(
                                      color: Color(theme.thirdColor),
                                      fontSize: 16)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
