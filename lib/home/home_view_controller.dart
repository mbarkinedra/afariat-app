import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';

import 'package:afariat/home/tap_chat/tap_chat_scr.dart';
import 'package:afariat/home/tap_home/tap_home_scr.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';

import 'package:afariat/sign_in/sign_in_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'tap_home/tap_home_viewcontroller.dart';
import 'tap_myads/tap_myads_scr.dart';
import 'tap_profile/tap_profile_scr.dart';
import 'tap_publish/tap_publish_scr.dart';

class HomeViwController extends GetxController {
  PersistentTabController controller;
  int newPublish = 0;
  int _navigatorValue = 0;
  String _currentPage = 'Page1';
  var _navigatorKey;

  List<String> _pageKeys = ['Page1', 'Page2', 'Page3', 'Page4', 'Page5'];

  get navigatorValue => _navigatorValue;

  get currentPage => _currentPage;

  get navigatorKey => _navigatorKey;

  get navigatorKeys => _navigatorKeys;

  get pageKeys => _pageKeys;
  static final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    'Page1': GlobalKey<NavigatorState>(),
    'Page2': GlobalKey<NavigatorState>(),
    'Page3': GlobalKey<NavigatorState>(),
    'Page4': GlobalKey<NavigatorState>(),
    'Page5': GlobalKey<NavigatorState>(),
  };

  Widget currentScreen = TapHomeScr();

  List<Widget> buildScreens = [
    TapHomeScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapMyAdsScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapPublishScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapChatScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapProfileScr() : SignInScr()
  ];

  @override
  void onInit() {
    controller = PersistentTabController(initialIndex: 0);
    controller.addListener(() {});
    super.onInit();
    currentScreen = PageToView(
      naigatorKey: _navigatorKeys[_pageKeys[0]],
      tabItem: _pageKeys[0],
    );
  }

  @override
  void onReady() {
    super.onReady();

    Get.find<TapHomeViewController>().setUserName(Get.find<AccountInfoStorage>().readName()??"" );
  }


  updatelist() {
    if (Get.find<AccountInfoStorage>().isLoggedIn()) {
      buildScreens[1] = TapMyAdsScr();
      buildScreens[2] = TapPublishScr();
      buildScreens[3] = TapChatScr();
      buildScreens[4] = TapProfileScr();
    } else {
      buildScreens[1] = SignInScr();
      buildScreens[2] = SignInScr();
      buildScreens[3] = SignInScr();
      buildScreens[4] = SignInScr();
    }
  }

  changeItemFilter(value) {
    Get.find<TapHomeViewController>().clearData();

    TapPublishViewController tapPublishViewController =
        Get.find<TapPublishViewController>();
    if (value != 2 || newPublish >= 2) {
      newPublish = 1;

      tapPublishViewController.clearAllData();

    } else if (!tapPublishViewController.modifAds.value) {
      newPublish = 1;
      tapPublishViewController.clearAllData();
    } else {
      newPublish++;

    }
    controller.index = value;
    update();
  }

  Widget buildOffStageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: PageToView(
        naigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

class PageToView extends StatelessWidget {
  final GlobalKey<NavigatorState> naigatorKey;
  final String tabItem;

  const PageToView({this.naigatorKey, this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = TapHomeScr();

    switch (tabItem) {
      case 'Page1':
        {
          currentScreen = TapHomeScr();

          break;
        }
      case 'Page2':
        {
          currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()
              ? TapMyAdsScr()
              : SignInScr();

          break;
        }
      case 'Page3':
        {
          currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()
              ? TapPublishScr()
              : SignInScr();
          break;
        }
      case 'Page4':
        {
          currentScreen = currentScreen =
              Get.find<AccountInfoStorage>().isLoggedIn()
                  ? TapChatScr()
                  : SignInScr();
          break;
        }
      case 'Page5':
        {
          currentScreen = currentScreen =
              Get.find<AccountInfoStorage>().isLoggedIn()
                  ? TapProfileScr()
                  : SignInScr();

          break;
        }
    }

    return Navigator(
      key: naigatorKey,
      onGenerateRoute: (routeStings) {
        return MaterialPageRoute(builder: (context) => currentScreen);
      },
    );
  }
}
