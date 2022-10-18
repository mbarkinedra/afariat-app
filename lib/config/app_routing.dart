import 'package:afariat/home/home_view.dart';
import 'package:afariat/home/advert/advert_details_view.dart';
import 'package:afariat/home/search/filter/filter_view.dart';
import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../home/advert/report_advert_view.dart';
import '../home/advert/report_succes_view.dart';
import '../home/main_view.dart';
import '../home/search/search_form_view.dart';
import '../home/search/similar_adverts_view.dart';
import '../home/tap_chat/tap_chat_scr.dart';
import '../home/search/filter/category_group_view.dart';
import '../home/tap_profile/account/account_view.dart';
import '../home/tap_profile/delete_account/delete_account_view.dart';
import '../home/tap_profile/delete_account/delete_succes_view.dart';
import '../home/tap_profile/favorite/favorite_view.dart';
import '../home/search/components/localization_view.dart';
import '../home/search/search_view.dart';
import '../home/tap_myads/myads_view.dart';
import '../home/tap_profile/notification/notification_view.dart';
import '../home/tap_profile/settings/change_password_view.dart';
import '../home/tap_profile/tap_profile_scr.dart';
import '../home/tap_publish/tap_publish_scr.dart';
import '../settings/notification_settings_view.dart';
import '../settings/settings_view.dart';
import '../sign_in/login_success_view.dart';
import '../sign_up/sign_up_scr.dart';
import '../sign_up/sign_up_succes_view.dart';

class AppRouting {
  static String main = '/';
  static String home = '/home';
  static String search = '/search';
  static String searchForm = '/search/form';
  static String filter = '/filter';
  static String localization = '/filter/localization';
  static String category = '/filter/category';
  static String adDetails = '/adDetails';
  static String adReport = '/report-ad';
  static String adReportSuccess = '/report-ad/success';
  static String similarAds = '/similar-ads';
  static String newAd = '/new-ad';
  static String myAds = '/my-ads';
  static String account = '/account';
  static String profile = '/account/profile';
  static String messages = '/account/messages';
  static String favorites = '/account/favorites';
  static String preferences = '/account/preferences';
  static String notifications = '/account/notifications';
  static String changePassword = '/account/change-password';
  static String deleteAccount = '/account/delete-account';
  static String deleteAccountSuccess = '/account/delete-account/success';
  static String login = '/login';
  static String loginSuccess = '/login/success';
  static String signUp = '/sign-up';
  static String signUpSuccess = '/sign-up/success';
  static String passwordForgot = '/password-forgot';

  static String settings = '/settings';

  static List<GetPage> pages = [
    GetPage(name: main, page: () => const MainView(), binding: AllBindings()),
    GetPage(name: home, page: () => HomeView(), binding: AllBindings()),
    GetPage(
        name: search, page: () => const SearchView(), binding: AllBindings()),
    GetPage(
        name: searchForm, page: () => SearchFormView(), binding: AllBindings()),
    GetPage(
        name: filter, page: () => const FilterView(), binding: AllBindings()),
    GetPage(
        name: localization,
        page: () => const LocalizationView(),
        binding: AllBindings()),
    GetPage(
      name: category,
      page: () => const CategoryGroupView(),
      binding: AllBindings(),
    ),
    GetPage(
      name: adDetails,
      page: () => AdvertDetailsView(),
      binding: AllBindings(),
    ),
    GetPage(
      name: adReport,
      page: () => ReportAdvertView(),
      binding: AllBindings(),
    ),
    GetPage(
      name: adReportSuccess,
      page: () => ReportSuccessView(),
      binding: AllBindings(),
    ),
    GetPage(
      name: similarAds,
      page: () => SimilarAdvertsView(),
      binding: AllBindings(),
    ),
    GetPage(name: myAds, page: () => MyAdsView(), binding: AllBindings()),
    GetPage(name: newAd, page: () => TapPublishScr(), binding: AllBindings()),
    GetPage(
      name: favorites,
      page: () => FavoriteView(),
      binding: AllBindings(),
    ),
    GetPage(name: account, page: () => TapProfileScr(), binding: AllBindings()),
    GetPage(name: profile, page: () => AccountView(), binding: AllBindings()),
    GetPage(name: settings, page: () => SettingsView(), binding: AllBindings()),
    GetPage(
        name: changePassword,
        page: () => ChangePasswordView(),
        binding: AllBindings()),
    GetPage(name: messages, page: () => TapChatScr(), binding: AllBindings()),
    GetPage(
        name: notifications,
        page: () => NotificationView(),
        binding: AllBindings()),
    GetPage(
        name: preferences,
        page: () => NotificationSettingsView(),
        binding: AllBindings()),
    GetPage(
        name: loginSuccess,
        page: () => const LoginSuccessView(),
        binding: AllBindings()),
    GetPage(name: signUp, page: () => SignUpScr(), binding: AllBindings()),
    GetPage(
        name: signUpSuccess,
        page: () => SignupSuccessView(),
        binding: AllBindings()),
    GetPage(
        name: deleteAccount,
        page: () => DeleteAccountView(),
        binding: AllBindings()),
    GetPage(
        name: deleteAccountSuccess,
        page: () => DeleteAccountSuccessView(),
        binding: AllBindings()),
  ];

  static GetPage getPageByName(String name) {
    return pages.firstWhere((p) => p.name == name);
  }

  static List<String> getPageNames() {
    List<String> names = <String>[];

    for (GetPage element in pages) {
      names.add(element.name);
    }

    return names;
  }
}
