import 'package:cmpe277_project/entity/Resturant.dart';
import 'package:flutter/material.dart';

class ResturantProvider with ChangeNotifier {
  List<Resturant> feedList;
  List<Resturant> recommendationList;
  List<Resturant> searchResult;
  List<Resturant> favoriteList;

  ResturantProvider() {
    feedList = new List();
    searchResult = new List();
    recommendationList = new List();
    favoriteList = new List();
    for (var i = 0; i < 4; i++)
      feedList.add(Resturant(
          12,
          'Auto Feed',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$\$',
          ['Desserts, Chinese'],
          '50 Skyport Dr, Ste 20, North San Jose'));
    for (var i = 0; i < 4; i++)
      recommendationList.add(Resturant(
          12,
          'Recommendation',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$\$',
          ['Desserts, Chinese'],
          '50 Skyport Dr, Ste 20, North San Jose'));
    for (var i = 0; i < 10; i++) {
      searchResult.add(Resturant(
          12,
          'Search Result',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$',
          ['Ramen, Japenese'],
          '50 Skyport Dr, Ste 20, North San Jose'));
    }
    for (var i = 0; i < 10; i++) {
      favoriteList.add(Resturant(
          13,
          'Favorite Resturant',
          'https://cdn.pixabay.com/photo/2019/02/22/19/54/restaurant-4014286_960_720.jpg',
          4.0,
          '\$',
          ['Ramen, Japenese'],
          '50 Skyport Dr, Ste 20, North San Jose'));
    }
  }
}
