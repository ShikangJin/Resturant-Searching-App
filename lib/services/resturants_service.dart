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

Future getComment(auth, String id) async {
  print('http://10.0.2.2:8080/comment/$id');
  var result = await Dio()
      .get('http://10.0.2.2:8080/comment/$id',
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

Future getResturantDetail(auth, String id) async {
  print('http://10.0.2.2:8080/business/detail/$id');
  var result = await Dio()
      .get('http://10.0.2.2:8080/business/detail/$id',
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

Future setFavorite(auth, String id) async {
  print('http://10.0.2.2:8080/business/favorite');
  var result = await Dio()
      .post('http://10.0.2.2:8080/business/favorite',
          data: {
            "id": id,
          },
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

Future cancelFavorite(auth, String id) async {
  print('http://10.0.2.2:8080/business/favorite');
  var result = await Dio()
      .delete('http://10.0.2.2:8080/business/favorite',
          data: {
            "id": id,
          },
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

Future getFavorite(auth) async {
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

Future sendComment(auth, String id, String text, double rating) async {
  print('http://10.0.2.2:8080/comment/send');
  var result = await Dio()
      .post('http://10.0.2.2:8080/comment/send',
          data: {"id": id, "text": text, "rating": rating},
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
