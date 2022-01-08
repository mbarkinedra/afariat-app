


import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/home/tap_chat/tap_chat_scr.dart';
import 'package:afariat/home/tap_home/tap_home_scr.dart';
import 'package:afariat/sign_in/sign_in_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tap_myads/tap_myads_scr.dart';
import 'tap_profile/tap_profile_scr.dart';
import 'tap_publish/tap_publish_scr.dart';




class HomeViwController extends GetxController {
  // int _selectedIndex = 0;
  // getselectedIndex()=>_selectedIndex;
  // setSelectIndex(int index){
  //   _selectedIndex=index;
  //   update();
  // }

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

  Widget currentScreen=TapHomeScr();

  @override
  void onInit() {
    super.onInit();
    currentScreen = PageToView(
      naigatorKey: _navigatorKeys[_pageKeys[0]] ,
      tabItem: _pageKeys[0],
    ); //=HomeView();
  }

  changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    _currentPage = _pageKeys[selectedValue];
    _navigatorKey = _navigatorKeys[_currentPage];

    currentScreen = PageToView(
      naigatorKey: _navigatorKey,
      tabItem: _currentPage,
    );

    update();
  }

  Widget buildoffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: PageToView(
        naigatorKey: _navigatorKeys[tabItem] ,
        tabItem: tabItem,
      ),
    );
  }

  gotomun() {
    // Get.to(() => MenuView());
  }
}

class PageToView extends StatelessWidget {
  final GlobalKey<NavigatorState> naigatorKey;
  final String tabItem;

  const PageToView({  this.naigatorKey,   this.tabItem});

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

         currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()    ? TapMyadsScr():SignInScr();

          break;
        }
      case 'Page3':
        {

          currentScreen =     currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()? TapPublishScr():SignInScr();
          break;
        }
      case 'Page4':
        {

          currentScreen =      currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()?TapChatScr():SignInScr();
          break;
        }
      case 'Page5':
        {




         // currentScreen = AccountInfoStorage.isLoggedIn()?SignInScr(): TapProfileScr();
   currentScreen =    currentScreen = Get.find<AccountInfoStorage>().isLoggedIn()? TapProfileScr():SignInScr();

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

