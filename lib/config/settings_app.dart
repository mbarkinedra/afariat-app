import 'package:afariat/config/Environment.dart';

class SettingsApp {
  static String get baseUrl => Environment.baseUrl;

  static String get apiPrefix => '/api/v1';

  static String get baseApiUrl => baseUrl + apiPrefix;

  static String get loginUrl => baseApiUrl + '/users/login';
  static String get logoutUrl => baseApiUrl + '/users/logout';

  static String get registerUrl => baseApiUrl + '/users';

  static String get resetPasswordUrl => baseApiUrl + '/users/reset-password';

  static String get changePasswordUrl => baseApiUrl + '/users/change-password';

  static String get getSaltUrl => baseApiUrl + '/users/get-salt';

  static String get advertUrl => baseApiUrl + '/adverts';

  static String get publishURL => baseApiUrl + '/adverts';

  static String get searchUrl => baseApiUrl + '/adverts';

  static String get advertDeatilsUrl => baseApiUrl + '/adverts';

  static String get myAdsUrl => baseApiUrl + '/adverts?user=';

  static String get cityUrl => baseApiUrl + '/simple/cities';

  static String get townUrl => baseApiUrl + '/simple/towns';

  static String get roomsNumberUrl => baseApiUrl + '/simple/rooms-number';

  static String get grouppedCategoriesUrl =>
      baseApiUrl + '/simple/categories-groupped';

  static String get priceUrl => baseApiUrl + '/simple/prices';

  static String get vehicleBrandsUrl => baseApiUrl + '/simple/vehicle-brands';

  static String get vehiculeModelUrl => baseApiUrl + '/simple/vehicle-models';

  static String get motoBrandsUrl => baseApiUrl + '/simple/moto-brands';

  static String get energiesUrl => baseApiUrl + '/simple/energies';

  static String get mileagesUrl => baseApiUrl + '/simple/mileages';

  static String get yearsModelsUrl => baseApiUrl + '/simple/year-models';

  static String get advertTypesUrl =>
      baseApiUrl + '/simple/category/advert-types/';

  static String get deleteAds => baseApiUrl + '/adverts';

  static String get modifAds => baseApiUrl + '/adverts';

  static String get userUrl => baseApiUrl + '/users';

  static String get notificationUrl => baseApiUrl + '/notifications';

  static String get putNotificationUrl => baseApiUrl + '/notifications';

  static String get deleteNotificationUrl => baseApiUrl + '/notifications';

  static String get notificationCountUrl =>
      baseApiUrl + '/notifications/unread/count';

  static String get conversations => baseApiUrl + '/conversations';

  static String get getConversation => baseApiUrl + '/conversation';

  static String get conversationReply => baseApiUrl + '/conversations/reply';

  static String get favorite => baseApiUrl + '/favorites';

  static String get deleteFavoriteByAdvert =>
      baseApiUrl + '/favorites-by-advert';

  static String get preference => baseApiUrl + '/preference';

  static String get autocompleteLocalization => baseApiUrl + '/autocomplete/localization';

  static String get autocompleteSearchSuggestion => baseApiUrl + '/autocomplete/search-suggestions';
}
