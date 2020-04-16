import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, @required this.theme, @required this.auth})
      : super(key: key);
  final theme;
  final auth;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String password;
  String confirmPassword;
  String email;

  @override
  void initState() {
    super.initState();
    name = '';
    password = '';
    confirmPassword = '';
    email = '';
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(widget.theme.primaryColor),
            title: Text('Register',
                style: TextStyle(color: widget.theme.textColor)),
            iconTheme: IconThemeData(color: widget.theme.textColor),
          ),
          body: Builder(
              builder: (context) => Column(
                    // margin: EdgeInsets.symmetric(horizontal: 12 * rpx),
                    // alignment: Alignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 80 * rpx),
                            margin: EdgeInsets.only(
                                top: 100 * hrpx, bottom: 20 * hrpx),
                            // alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  onChanged: (value) {
                                    name = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter an username';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Confirm Password',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  onChanged: (value) {
                                    confirmPassword = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || value != password) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please enter valid email';
                                    else
                                      return null;
                                  },
                                ),
                              ],
                            )),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.symmetric(horizontal: 40 * rpx),
                        child: MaterialButton(
                          // minWidth:
                          //     double.maxFinite, // set minWidth to maxFinite
                          color: Color(widget.theme?.primaryColor),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text('Processing Data')));
                              print("signup submit");
                              widget.auth
                                  .handleRegister(email, name, password)
                                  .then((response) {
                                email = '';
                                name = '';
                                password = '';
                                confirmPassword = '';
                                // _formKey.currentState.reset();
                                if (response.data != null &&
                                    response.data['message'] ==
                                        'user created') {
                                  // print('pop sign up');
                                  Navigator.pop(context);
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Failed to create user. Please try again later')));
                                }
                              });
                            }
                          },
                          child: Text("Submit",
                              style: TextStyle(color: widget.theme.textColor)),
                        ),
                      )
                    ],
                  )),
        ));
  }
}
