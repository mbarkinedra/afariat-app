import 'package:dio/dio.dart';

class SettingApp {
  static const String baseUrl = 'https://afariat.com/api/v1';

  static const String login = baseUrl + '/users/login';
  static const String register = baseUrl + '/users';
  static const String forgotPassword = baseUrl + '/users/reset-password';
  static const apiKey =
      '850f2303a496c53746d52ba751efcdbe8ce9636d27eb805455ad5e0c02cb5750';
  static const String Advert = baseUrl + 'adverts';
  static const String cities = baseUrl + '/simple/cities';

  static const String town = baseUrl + '/simple/town';
  static const String categories = baseUrl + '/simple/categories-groupped';
  static BaseOptions options = BaseOptions(
      baseUrl: "https://afariat.com/api/v1" );

}
