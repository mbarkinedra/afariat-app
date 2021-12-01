import 'package:dio/dio.dart';

class SettingsApp {
  static const String baseUrl = 'https://afariat.com';
  static const String baseApiUrl = '$baseUrl/api/v1';

  static const String login = baseApiUrl + '/users/login';
  static const String register = baseApiUrl + '/users';
  static const String forgotPassword = baseApiUrl + '/users/reset-password';
  static const apiKey =
      '850f2303a496c53746d52ba751efcdbe8ce9636d27eb805455ad5e0c02cb5750';
  static const String Advert = baseApiUrl + '/adverts';
  static const String cities = baseApiUrl + '/simple/cities';

  static const String town = baseApiUrl + '/simple/town';
  static const String categories = baseApiUrl + '/simple/categories-groupped';
  static BaseOptions options = BaseOptions(baseUrl: baseApiUrl);
}
