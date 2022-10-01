import 'package:afariat/settings/settings_view_controller.dart';
import 'package:afariat/home/tap_home/search_viewcontroller.dart';
import 'package:afariat/settings/notification_settings_controller.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/storage/storage.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/main_view_controller.dart';
import 'package:afariat/home/tap_chat/chat_user/chat_user_viewcontroller.dart';
import 'package:afariat/home/tap_chat/tap_chat_viewcontroller.dart';
import 'package:afariat/home/tap_myads/tap_myads_viewcontroller.dart';
import 'package:afariat/home/tap_profile/account/account_view_controller.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:afariat/home/tap_profile/settings/setting_view_controller.dart';
import 'package:afariat/home/tap_profile/tap_profile_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/sign_in/forgotPassword/forgotpassword_view_controller.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_viewcontroller.dart';
import 'package:get/get.dart';

import '../home/drawer_view_controller.dart';
import '../home/home_view_controller.dart';
import '../home/tap_home/advert_details_viewcontroller.dart';
import '../home/tap_home/category_group_viewcontroller.dart';
import '../home/tap_home/filter_app_bar_viewcontroller.dart';
import '../home/tap_home/filter_viewcontroller.dart';
import '../home/tap_home/localization_viewcontroller.dart';
import '../home/tap_home/search_app_bar_viewcontroller.dart';
import '../home/tap_profile/favorite/favorite_view_controller.dart';
import '../remote_widget/city_dropdown_viewcontroller.dart';
import '../remote_widget/price_range_slider_viewcontroller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SecureStorage());
    Get.lazyPut(() => AccountInfoStorage());

    Get.lazyPut(() => AccountViewController());
    Get.lazyPut(() => MainViewController(), fenix: true);
    Get.lazyPut(() => HomeViewController(), fenix: true);
    Get.lazyPut(() => DrawerViewController(), fenix: true);
    Get.lazyPut(() => SearchViewController(), fenix: true);
    Get.lazyPut(() => FilterViewController(), fenix: true);
    Get.lazyPut(() => SearchAppBarViewController(), fenix: true);
    Get.lazyPut(() => FilterAppBarViewController(), fenix: true);
    Get.lazyPut(() => LocalizationViewController(), fenix: true);
    Get.lazyPut(() => CategoryGroupViewController(), fenix: true);
    Get.lazyPut(() => AdvertDetailsViewController(), fenix: true);

    Get.lazyPut(
      () => NetWorkController(),
    );
    Get.lazyPut(() => SettingsViewController(), fenix: true);
    Get.lazyPut(() => FavoriteViewController(), fenix: true);
    Get.lazyPut(() => NotificationSettingsViewController(), fenix: true);
    Get.put(TapPublishViewController());
    Get.put(CategoryAndSubcategory());
    Get.put(LocController());
    Get.lazyPut(() => SignUpViewController());
    Get.lazyPut(() => SignInViewController());
    Get.lazyPut(() => TapMyAdsViewController(), fenix: true);
    Get.lazyPut(() => TapProfileViewController());
    Get.lazyPut(() => AdvertDetailsViewController());
    Get.lazyPut(() => TapPublishViewController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordViewController());
    Get.lazyPut(() => SettingViewController());
    Get.lazyPut(() => NotificationViewController(), fenix: true);
    Get.lazyPut(() => ChatUserViewController());
    Get.lazyPut(() => CityDropdownViewController());
    Get.lazyPut(() => TapChatViewController());
    Get.lazyPut(() => PriceRangeSliderViewController());
  }
}
