class SettingsApp {
  static const apiKey =
      '850f2303a496c53746d52ba751efcdbe8ce9636d27eb805455ad5e0c02cb5750';
  static const moneySymbol = 'DT';

  static const String baseUrl = 'https://afariat.com';
  static const String baseApiUrl = '$baseUrl/api/v1';

  static const String loginUrl = baseApiUrl + '/users/login';
  static const String registerUrl = baseApiUrl + '/users';
  static const String forgotPasswordUrl = baseApiUrl + '/users/reset-password';
  static const String getSaltUrl = baseApiUrl + '/users/get-salt';
  static const String advertUrl = baseApiUrl + '/adverts';
  static const String advertPageUrl = baseApiUrl + '/adverts.json';
  static const String publishURL = baseApiUrl + '/adverts';
  static const String SearchUrl = baseApiUrl + '/adverts';
  static const String advertDeatilsUrl = baseApiUrl + '/adverts';
  static const String myAdsUrl = baseApiUrl + '/adverts?user=';

  static const String cityUrl = baseApiUrl + '/simple/cities';
  static const String townUrl = baseApiUrl + '/simple/towns';
  static const String grouppedCategoriesUrl =
      baseApiUrl + '/simple/categories-groupped';
  static const String priceUrl = baseApiUrl + '/simple/prices';
  static const String vehicleBrandsUrl = baseApiUrl + '/simple/vehicle-brands';
  static const String vehiculeModelUrl = baseApiUrl + '/simple/vehicle-models';
  static const String motoBrandsUrl = baseApiUrl + '/simple/moto-brands';
  static const String mileagesUrl = baseApiUrl + '/simple/mileages';
  static const String yearsModelsUrl = baseApiUrl + '/simple/year-models';
  static const String roomsNumberUrl = baseApiUrl + '/simple/rooms-number';
  static const String advertTypesUrl =
      baseApiUrl + '/simple/category/advert-types/';
  static const String deleteAds = baseApiUrl + '/adverts/';
  static const String modifAds = baseApiUrl + '/adverts/';
  static const String userUrl = baseApiUrl + '/users/';
}
