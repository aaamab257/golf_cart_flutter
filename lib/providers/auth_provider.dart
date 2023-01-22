import 'package:flutter/cupertino.dart';

import '../base/api_response.dart';
import '../base/error_response.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../model/register_request.dart';
import '../repo/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  String _api_token;
  String _message = '';
  int _code = 0;

  String get api_token => _api_token;

  int get code => _code;
  String get message => _message;

  AuthProvider({@required this.authRepo});

  Future<LoginModel> login(String email, String pass) async {
    notifyListeners();

    ApiResponse apiResponse =
        await authRepo.login(email: email, password: pass);
    LoginModel loginModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      if (apiResponse.response.data['code'] == 200) {
        loginModel = LoginModel.fromJson(apiResponse.response.data);
        _code = loginModel.code;
        String token = loginModel.token.access;
        authRepo.saveUserToken(token);
        authRepo.saveUserData(loginModel.user.name, loginModel.user.phone,
            loginModel.user.email, loginModel.user.is_admin);
      } else {
        _code = 404;
        String errorMessage;
        if (apiResponse.error is String) {
          errorMessage = apiResponse.error.toString();
        } else {
          errorMessage = apiResponse.error.errors[0].message;
        }
        print(errorMessage);
        _message = errorMessage;
      }
    } else {
      _code = 404;
    }
  }

  Future<RegisterModel> register(SignUpModel signUpModel) async {
    print('Request Data ==== ${signUpModel.toJson()}');
    notifyListeners();
    ApiResponse apiResponse = await authRepo.register(signUpModel);
    RegisterModel registerModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 201) {
      print('response not null');
      registerModel = RegisterModel.fromJson(apiResponse.response.data);
      _code = apiResponse.response.statusCode;
      String token = registerModel.token.access;
      authRepo.saveUserToken(token);
      authRepo.saveUserData(registerModel.user.name, registerModel.user.phone,
          registerModel.user.email, false);
    } else {
      _code = 400;
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
      _message = errorMessage;
      print('response != 200');
      if (apiResponse.error is String) {
        print(
            'Response Errors =============== ${apiResponse.error.toString()}');
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(
            'Response Errors =============== ${errorResponse.errors[0].message}');
      }
    }
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  String getUserCode() {
    return authRepo.getUserEmail();
  }

  String getUserName() {
    return authRepo.getUserName();
  }

  String getUserPhone() {
    return authRepo.getUserPhone();
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }
}
