import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_constant.dart';
import '../base/api_response.dart';
import '../model/register_request.dart';
import '../remote/dio/dio_client.dart';
import '../remote/exception/api_error_handler.dart';

class AuthRepo {
  final DioClient dioClient;

  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> login({String email, String password}) async {
    await sharedPreferences.setString(AppConstants.TOKEN, '');
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_API,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
        data: {"email": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> register(SignUpModel signUpModel) async {
    await sharedPreferences.setString(AppConstants.TOKEN, '');
    try {
      Response response = await dioClient.post(
        AppConstants.REGISTER_API,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
        data: signUpModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserData(
      String name, String phone, String email, bool is_admin) async {
    try {
      await sharedPreferences.setString(AppConstants.NAME, name);
      await sharedPreferences.setString(AppConstants.PHONE, phone);
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setBool(AppConstants.IS_ADMIN, is_admin);
    } catch (e) {
      throw e;
    }
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool userIsAdmin() {
    return sharedPreferences.getBool(AppConstants.IS_ADMIN) ?? "";
  }

  bool userIsDriver() {
    return sharedPreferences.getBool(AppConstants.IS_DRIVER) ?? "";
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.NAME) ?? "";
  }

  String getUserPhone() {
    return sharedPreferences.getString(AppConstants.PHONE) ?? "";
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.EMAIL) ?? "";
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.PHONE);
    await sharedPreferences.remove(AppConstants.NAME);
    await sharedPreferences.remove(AppConstants.EMAIL);
    await sharedPreferences.remove(AppConstants.IS_ADMIN);
    return true;
  }
}
