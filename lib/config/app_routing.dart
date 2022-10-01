import 'package:afariat/home/home_view.dart';
import 'package:afariat/home/tap_home/advert_details_view.dart';
import 'package:afariat/home/tap_home/filter_view.dart';
import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../home/main_view.dart';
import '../home/tap_chat/tap_chat_scr.dart';
import '../home/tap_home/category_group_view.dart';
import '../home/tap_profile/favorite/favorite_view.dart';
import '../home/tap_home/localization_view.dart';
import '../home/tap_home/search_view.dart';
import '../home/tap_myads/tap_myads_scr.dart';
import '../home/tap_profile/notification/notification_view.dart';
import '../home/tap_profile/tap_profile_scr.dart';
import '../home/tap_publish/tap_publish_scr.dart';
import '../settings/notification_settings_view.dart';
import '../settings/settings_view.dart';

class AppRouting {
  static String main = '/';
  static String home = '/home';
  static String search = '/search';
  static String filter = '/filter';
  static String localization = '/filter/localization';
  static String category = '/filter/category';
  static String adDetails = '/adDetails';
  static String newAd = '/new-ad';
  static String myAds = '/my-ads';
  static String messages = '/account/messages';
  static String profile = '/account/profile';
  static String favorites = '/account/favorites';
  static String preferences = '/account/preferences';
  static String notifications = '/account/notifications';
  static String login = '/login';
  static String signUp = '/sign-up';
  static String passwordForgot = '/password-forgot';

  static String settings = '/settings';

  static Map<String, dynamic> routes = {'/': (context) => const MainView()};
  static List<GetPage> pages = [
    GetPage(name: main, page: () => const MainView(), binding: AllBindings()),
    GetPage(name: home, page: () => HomeView(), binding: AllBindings()),
    GetPage(
        name: search, page: () => const SearchView(), binding: AllBindings()),
    GetPage(
        name: filter, page: () => const FilterView(), binding: AllBindings()),
    GetPage(
        name: localization,
        page: () => const LocalizationView(),
        binding: AllBindings()),
    GetPage(
        name: category,
        page: () => const CategoryGroupView(),
        binding: AllBindings()),
    GetPage(
        name: adDetails,
        page: () => AdvertDetailsView(),
        binding: AllBindings()),
    GetPage(name: myAds, page: () => TapMyAdsScr(), binding: AllBindings()),
    GetPage(name: newAd, page: () => TapPublishScr(), binding: AllBindings()),
    GetPage(
        name: favorites, page: () => FavoriteView(), binding: AllBindings()),
    GetPage(name: profile, page: () => TapProfileScr(), binding: AllBindings()),
    GetPage(name: settings, page: () => SettingsView(), binding: AllBindings()),
    GetPage(name: messages, page: () => TapChatScr(), binding: AllBindings()),
    GetPage(name: notifications, page: () => NotificationView(), binding: AllBindings()),
    GetPage(
        name: preferences,
        page: () => NotificationSettingsView(),
        binding: AllBindings()),
  ];

  static GetPage getPageByName(String name) {
    return pages.firstWhere((p) => p.name == name);
  }
}
