import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, @required this.theme}) : super(key: key);
  final theme;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

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
            backgroundColor: Colors.white,
            title: Text('Register'),
            leading: GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            // margin: EdgeInsets.symmetric(horizontal: 12 * rpx),
            // alignment: Alignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80 * rpx),
                    margin: EdgeInsets.only(top: 100 * hrpx, bottom: 20 * hrpx),
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
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'Username';
                            // }
                            // return null;
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
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'Username';
                            // }
                            // return null;
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
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'Username';
                            // }
                            // return null;
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
                          validator: (value) {
                            // if (value.isEmpty) {
                            //   return 'Username';
                            // }
                            // return null;
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
                    }
                  },
                  child: Text("Submit",
                      style: TextStyle(color: Color(widget.theme?.thirdColor))),
                ),
              )
            ],
          )),
    );
  }
}
