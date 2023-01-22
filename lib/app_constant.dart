import 'package:intl/intl.dart';

class AppConstants {
  static const String BASE_URL = 'http://gf-cart.herokuapp.com/';

  static const String LOGIN_API = 'auth/login';
  static const String REGISTER_API = 'auth/register';

  //shared
  static const String TOKEN = 'token';
  static const String NAME = 'name';
  static const String PHONE = 'phone';
  static const String EMAIL = 'email';
  static const String IS_ADMIN = 'is_admin';
  static const String IS_DRIVER = 'is_driver';

  static String convertDate(String date) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    String dateConverter = DateFormat("yyyy-MM-dd").format(tempDate);
    return dateConverter;
  }
}
