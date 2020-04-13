import 'package:cmpe277_project/entity/Comment.dart';
import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:cmpe277_project/services/resturants_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResturantProvider with ChangeNotifier {
  List<Resturant> feedList;
  List<Resturant> recommendationList;
  List<Resturant> searchResult;
  List<Resturant> favoriteList;
  List<Comment> commentList;
  List<String> photoList;

  ResturantProvider() {
    feedList = new List();
    searchResult = new List();
    recommendationList = new List();
    favoriteList = new List();

    for (var i = 0; i < 4; i++)
      recommendationList.add(Resturant(
          '12',
          'Recommendation',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$\$',
          ['Desserts, Chinese'],
          '50 Skyport Dr, Ste 20, North San Jose',
          0,
          0));
    for (var i = 0; i < 10; i++) {
      favoriteList.add(Resturant(
          '13',
          'Favorite Resturant',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$',
          ['Ramen, Japenese'],
          '50 Skyport Dr, Ste 20, North San Jose',
          0,
          0));
    }
  }

  addResturant(curRes, list) {
    List<String> types = List();
    for (var j = 0; j < curRes['categories'].length; j++) {
      types.add(curRes['categories'][j]['title']);
    }

    String address1 = curRes['location']['address1'];
    String address2 = curRes['location']['address2'];
    String address3 = curRes['location']['address3'];
    String city = curRes['location']['city'];
    List<String> address = new List();
    if (address1 != null && address1 != '') address.add(address1);
    if (address2 != null && address2 != '') address.add(address2);
    if (address3 != null && address3 != '') address.add(address3);
    if (city != null && city != '') address.add(city);
    double lat = curRes['coordinates']['latitude'];
    double lng = curRes['coordinates']['longitude'];
    list.add(Resturant(
        curRes['id'],
        curRes['name'],
        curRes['image_url'],
        curRes['rating'].toDouble(),
        curRes['price'] == null ? '' : curRes['price'],
        types,
        address.join(', '),
        lat,
        lng));
  }

  searchResturants(auth, {String term, String price, String sort}) async {
    Response response =
        await getResturants(auth, term: term, price: price, sort: sort);
    searchResult = new List();
    if (response?.data != null && response.data['message'] == 'success') {
      for (var i = 0; i < response.data['businesses'].length; i++) {
        final curRes = response.data['businesses'][i];
        addResturant(curRes, searchResult);
      }
    }
    print(searchResult.length);
    return searchResult;
  }

  Future getResturantFeed(auth, {String price, String sort}) async {
    Response response = await getResturants(auth, price: price, sort: sort);
    feedList = new List();
    if (response?.data != null && response.data['message'] == 'success') {
      for (var i = 0; i < response.data['businesses'].length; i++) {
        final curRes = response.data['businesses'][i];
        addResturant(curRes, feedList);
      }
    }
    notifyListeners();
  }

  Future getRecommendationFeed(auth) async {
    Response response = await getRecommendations(auth);
    recommendationList = new List();
    if (response?.data != null && response.data['message'] == 'success') {
      for (var i = 0; i < response.data['businesses'].length; i++) {
        final curRes = response.data['businesses'][i];
        addResturant(curRes, recommendationList);
      }
    }
    notifyListeners();
  }

  Future getCommentByResturant(auth, String id) async {
    print('get comment');
    Response response = await getComment(auth, id);
    commentList = new List();
    if (response?.data != null && response.data['message'] == 'success') {
      for (var i = 0; i < response.data['comments'].length; i++) {
        final curCmt = response.data['comments'][i];
        commentList.add(Comment(
          curCmt['name'],
          curCmt['text'],
          curCmt['rating'].toDouble(),
        ));
      }
    }
    notifyListeners();
  }

  Future getDetail(auth, String id) async {
    print('get detail');
    Response response = await getResturantDetail(auth, id);
    List<String> photoList = new List();
    if (response?.data != null && response.data['message'] == 'success') {
      print(response);
      var photos = response.data['business']['photos'];
      for (var i = 0; i < photos.length; i++) {
        if (i != 0) {
          var photo = photos[i];
          photoList.add(photo.toString());
        }
      }
    }
    return photoList;
    // notifyListeners();
  }
}
