import 'dart:developer';
import 'dart:ffi';

import 'package:afariat/advert_details/advert_details_viewcontroller.dart';
import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/home_view_controller.dart';
import 'package:afariat/home/tap_chat/chat_user/chat_user_viewcontroller.dart';
import 'package:afariat/home/tap_chat/tap_chat_viewcontroller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_myads/tap_myads_viewcontroller.dart';
import 'package:afariat/home/tap_profile/account/account_view_controller.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:afariat/home/tap_profile/settings/setting_view_controller.dart';
import 'package:afariat/home/tap_profile/tap_profile_viewcontroller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_image/publish_image_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/sign_in/forgotPassword/forgotpassword_view_controller.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_viewcontroller.dart';
import 'package:get/get.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => AccountViewController());
    Get.lazyPut(() => TapHomeViewController(), fenix: true);
    Get.lazyPut(() => HomeViwController(), fenix: true);
    Get.put(SecureStorage());
    Get.put(AccountInfoStorage());
    Get.put(TapPublishViewController());
    Get.put(CategoryAndSubcategory());
    Get.put(LocController());
    Get.lazyPut(() => SignUpViewController());
    Get.lazyPut(() => SignInViewController());
    Get.lazyPut(() => TapMyadsViewController(), fenix: true);
    Get.lazyPut(() => TapProfileViewController());
    Get.lazyPut(() => AdvertDetailsViewcontroller());
    Get.lazyPut(() => TapPublishViewController(), fenix: true);
    Get.lazyPut(() => PublishImageViewController(), fenix: true);
    Get.lazyPut(() => ForgotPasswordViewController());
    Get.lazyPut(() => SettingViewController());
    Get.lazyPut(() => NotificationViewController(),fenix: true);
    Get.lazyPut(() => ChatUserViewController());
    Get.lazyPut(() => TapChatViewController());
  }
}
