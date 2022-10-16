import 'package:afariat/sign_in/sign_in_scr.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'config/app_routing.dart';
import 'home/home_view.dart';
import 'home/main_view.dart';
import 'home/tap_chat/tap_chat_scr.dart';
import 'home/tap_myads/myads_view.dart';
import 'home/tap_profile/tap_profile_scr.dart';
import 'home/tap_publish/tap_publish_scr.dart';

class PersistentTabManager {
  static PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  static List<Widget> screens;

  static RxInt currentIndex = 0.obs;

  static final pages = <String>[
    AppRouting.home,
    AppRouting.myAds,
    AppRouting.newAd,
    AppRouting.messages,
    AppRouting.profile
  ];

  static void changePage(int index) {
    currentIndex.value = index;
    tabController.index = index;
    tabController.jumpToTab(index);
    Get.routing.current = pages[index];
    //Get.toNamed(pages[index]);
    //tabController.jumpToTab(index);
  }

  static void initScreens() => screens = buildScreens();

  static void updateScreens() => PersistentTabManager.screens = buildScreens();

  static List<Widget> buildScreens() {
    bool isLoggedIn = Get.find<AccountInfoStorage>().isLoggedIn();
    return [
      HomeView(),
      isLoggedIn ? MyAdsView() : SignInScr(),
      isLoggedIn ? TapPublishScr() : SignInScr(),
      isLoggedIn ? TapChatScr() : SignInScr(),
      isLoggedIn ? TapProfileScr() : SignInScr()
    ];
  }

  /// a custom fucntion to remove evrything and go to home
  static goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainView(),
        ),
        (route) => false);
  }

  static goToLoginPage(BuildContext context){
    goToHome(context);
    changePage(4);
  }
}
