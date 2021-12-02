
class SettingsApp {
  static const String baseUrl = 'https://afariat.com';
  static const String baseApiUrl = '$baseUrl/api/v1';

  static const String loginUrl = baseApiUrl + '/users/login';
  static const String registerUrl = baseApiUrl + '/users';
  static const String forgotPasswordUrl = baseApiUrl + '/users/reset-password';
  static const apiKey =
      '850f2303a496c53746d52ba751efcdbe8ce9636d27eb805455ad5e0c02cb5750';
  static const String advertUrl = baseApiUrl + '/adverts';
  static const String cityUrl = baseApiUrl + '/simple/cities';

  static const String townUrl = baseApiUrl + '/simple/town';
  static const String grouppedCategoriesUrl = baseApiUrl + '/simple/categories-groupped';
  static const String priceUrl = baseApiUrl + '/simple/prices';


}
