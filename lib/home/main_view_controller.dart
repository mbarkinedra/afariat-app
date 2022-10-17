import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/home/tap_chat/tap_chat_scr.dart';
import 'package:afariat/sign_in/sign_in_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../config/app_routing.dart';
import '../persistent_tab_manager.dart';
import 'home_view.dart';
import 'tap_myads/myads_view.dart';
import 'tap_profile/tap_profile_scr.dart';
import 'tap_publish/tap_publish_scr.dart';
import 'package:flutter_intro/flutter_intro.dart';

class MainViewController extends GetxController {
  BuildContext context;


  @override
  void onInit() {
    //Get.offAllNamed(AppRouting.home);
    PersistentTabManager.buildScreens();
    super.onInit();
    Get.routing.current = '/home';
  }

  RouteAndNavigatorSettings routeAndNavigatorSettings() {
    return RouteAndNavigatorSettings(
      onGenerateRoute: (RouteSettings settings) {
        GetPage p = AppRouting.getPageByName(settings.name);
        return p != null
            ? GetPageRoute(
                settings: settings,
                page: p.page,
                binding: p.binding,
              )
            : null;
      },
      initialRoute: AppRouting.home,
    );
  }
}
