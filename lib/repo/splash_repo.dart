import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../remote/dio/dio_client.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences, @required this.dioClient});

  // Future<bool> initSharedData() {
  //   if(!sharedPreferences.containsKey(AppConstants.THEME)) {
  //     return sharedPreferences.setBool(AppConstants.THEME, false);
  //   }

  //   return Future.value(true);
  // }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
