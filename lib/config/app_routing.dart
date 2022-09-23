import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../home/home_view.dart';
import '../home/tap_home/localization_view.dart';
import '../home/tap_home/search_view.dart';

class AppRouting {
  static String home = '/';
  static String search = '/search';
  static String localization = '/filter/localization';
  static String adDetails = '/ad-details';
  static String newAd = '/new-ad';
  static String myAds = '/my-ads';
  static String messages = '/account/messages';
  static String profile = '/account/profile';
  static String login = '/login';
  static String signUp = '/sign-up';
  static String passwordForgot = '/password-forgot';
  static String favorites = '/account/favorites';
  static String settings = '/settings';

  static Map<String, dynamic> routes = {
    '/': (context) => const HomeView()
  };
  static List<GetPage> pages = [
    GetPage(name: home, page: () => const HomeView(), binding: AllBindings()),
    GetPage(name: search, page: () => const SearchView(), binding: AllBindings()),
    GetPage(name: localization, page: () => const LocalizationView(), binding: AllBindings()),
  ];
}
