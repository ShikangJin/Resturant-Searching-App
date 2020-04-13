import 'dart:io';

import 'package:cmpe277_project/providers/auth_provider.dart';
import 'package:dio/dio.dart';

var dio = Dio();

Future getResturants(auth, {String term, String price, String sort}) async {
  print(
      'http://10.0.2.2:8080/business/search?term=${term == null ? '' : term}${price == null ? '' : '&price=$price'}&sort_by=${sort == 'rating' ? 'rating' : 'best_match'}');
  var result = await Dio()
      .get(
    "http://10.0.2.2:8080/business/search?term=${term == null ? '' : term}${price == null ? '' : '&price=$price'}&sort_by=${sort == 'rating' ? 'rating' : 'best_match'}",
    options: Options(
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + auth.token,
      },
    ),
  )
      .catchError((error) {
    print(error);
  });
  return result;
}

Future getRecommendations(auth) async {
  print('http://10.0.2.2:8080/business/recommendation');
  var result = await Dio()
      .get('http://10.0.2.2:8080/business/recommendation',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + auth.token,
            },
          ))
      .catchError((error) {
    print(error);
  });
  return result;
}

Future getFavoriteList(auth) async {
  print('http://10.0.2.2:8080/business/favorite');
  var result = await Dio()
      .get('http://10.0.2.2:8080/business/favorite',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: "Bearer " + auth.token,
            },
          ))
      .catchError((error) {
    print(error);
  });
  return result;
}
