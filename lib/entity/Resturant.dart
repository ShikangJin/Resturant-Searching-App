import 'package:cmpe277_project/pages/resturant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Resturant {
  final int id;
  final String name;
  final String imageUrl;
  final double rate;
  final String price;
  final List<String> type;
  final String address;

  Resturant(this.id, this.name, this.imageUrl, this.rate, this.price, this.type,
      this.address);

  static getTags(type, {double size}) {
    final List fixedList = Iterable<int>.generate(type.length).toList();

    return fixedList.map((idx) {
      String tag = type[idx];
      if (idx == type.length - 1) {
        return Text('$tag',
            style: TextStyle(fontSize: size != null ? size : 14));
      }
      return Text('$tag, ',
          style: TextStyle(fontSize: size != null ? size : 14));
    });
  }

  static Widget createItem(Resturant resturant, var theme, double hrpx,
      double rpx, context, resturants) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResturantPage(
                        theme: theme,
                        resturants: resturants,
                        curResturant: resturant,
                      )));
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 24 * hrpx),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Color(theme.thirdColor)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(resturant.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
                RatingBar(
                  ignoreGestures: true,
                  initialRating: resturant.rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.only(right: 4.0, top: 4),
                  itemBuilder: (context, _) =>
                      Icon(Icons.stars, color: Color(theme.primaryColor)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 12 * hrpx),
                  child: Row(
                    children: <Widget>[
                      Text('${resturant.price} '),
                      ...getTags(resturant.type == null ? [] : resturant.type)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12 * hrpx),
                  child: Text(resturant.address,
                      style: TextStyle(color: Colors.grey[600])),
                ),
                Container(
                    margin: EdgeInsets.only(top: 12 * hrpx),
                    width: 700 * rpx,
                    height: 200 * hrpx,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(resturant.imageUrl),
                        )))
                // Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: NetworkImage(resturant.imageUrl))),
                // )
              ],
            )));
  }
}
