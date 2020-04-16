import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentPage extends StatefulWidget {
  CommentPage(
      {Key key,
      @required this.theme,
      @required this.resturants,
      @required this.curResturant,
      @required this.auth})
      : super(key: key);
  final theme;
  final resturants;
  final curResturant;
  final auth;

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  double rate;
  TextEditingController controller;
  bool loading;

  @override
  void initState() {
    super.initState();
    rate = 0;
    controller = TextEditingController();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(widget.theme.primaryColor),
          iconTheme: IconThemeData(color: widget.theme.textColor),
          title: Text('Add Comment',
              style: TextStyle(color: widget.theme.textColor)),
        ),
        body: Builder(
          builder: (context) => Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 20 * hrpx, horizontal: 20 * rpx),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.curResturant.name,
                        style: TextStyle(fontSize: 20)),
                    RatingBar(
                      // ignoreGestures: true,
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemPadding: EdgeInsets.only(right: 4.0, top: 4),
                      itemBuilder: (context, _) => Icon(Icons.stars,
                          color: Color(widget.theme.primaryColor)),
                      onRatingUpdate: (rating) {
                        rate = rating;
                      },
                    ),
                    TextField(
                      controller: controller,
                      maxLines: 10,
                      autofocus: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Please type your comment here'),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 10 * hrpx,
                child: Container(
                    width: 750 * rpx,
                    // margin: EdgeInsets.symmetric(horizontal: 50 * rpx),
                    alignment: Alignment.center,
                    child: MaterialButton(
                      // : EdgeInsets.symmetric(horizontal: 50 * rpx),
                      minWidth: 300 * rpx, // set minWidth to maxFinite
                      color: Color(widget.theme.primaryColor),

                      onPressed: () {
                        if (loading) return;
                        setState(() {
                          loading = true;
                        });
                        widget.resturants
                            .addComment(widget.auth, widget.curResturant.id,
                                controller.text, rate)
                            .then((res) {
                          setState(() {
                            loading = false;
                          });
                          if (res) {
                            Navigator.pop(context);
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Failed to post comment. Please try again later')));
                          }
                        });
                      },
                      child: loading
                          ? SizedBox(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    widget.theme.textColor),
                              ),
                              height: 20.0,
                              width: 20.0,
                            )
                          : Text('Post Comment',
                              style: TextStyle(color: widget.theme.textColor)),
                    )),
              )
            ],
          ),
        ));
  }
}
