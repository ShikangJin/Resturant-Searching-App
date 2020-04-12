import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Me extends StatefulWidget {
  Me({Key key}) : super(key: key);

  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(theme.primaryColor),
            title: Text(auth.user.name, style: TextStyle(color: Colors.white))),
        body: Container(
          child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 * rpx, vertical: 10 * hrpx),
                      child: Row(
                        children: <Widget>[
                          Container(
                              // margin: EdgeInsets.only(top: 12 * hrpx),
                              width: 200 * rpx,
                              height: 100 * hrpx,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(auth.user.avatarUrl),
                                  ))),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24 * rpx),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8 * hrpx),
                                    child: Text(auth.user.name,
                                        style: TextStyle(fontSize: 20))),
                                Text(auth.user.email,
                                    style: TextStyle(fontSize: 16))
                              ],
                            ),
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 30 * hrpx),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20 * rpx, vertical: 10 * hrpx),
                      child: MaterialButton(
                        minWidth: double.maxFinite, // set minWidth to maxFinite
                        color: Color(theme.primaryColor),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          auth.handleLogout();
                        },
                        child: Text("Log out",
                            style: TextStyle(color: Colors.white)),
                      )),
                ],
              )),
        ));
  }
}
