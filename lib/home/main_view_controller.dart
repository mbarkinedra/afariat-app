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
  //List<Widget> screens;
 // PersistentTabController tabController;

  @override
  void onInit() {
    PersistentTabManager.buildScreens();
    super.onInit();
   // tabController = PersistentTabController(initialIndex: 0);
  }

  //var currentIndex = 0.obs;

 /* final pages = <String>[
    AppRouting.home,
    AppRouting.myAds,
    AppRouting.newAd,
    AppRouting.messages,
    AppRouting.profile
  ];*/

 /* updateScreens(){
    screens = buidScreens();
  }*/

  /*List<Widget> buidScreens() => [
        HomeView(),
        Get.find<AccountInfoStorage>().isLoggedIn() ? MyAdsView() : SignInScr(),
        Get.find<AccountInfoStorage>().isLoggedIn()
            ? TapPublishScr()
            : SignInScr(),
        Get.find<AccountInfoStorage>().isLoggedIn()
            ? TapChatScr()
            : SignInScr(),
        Get.find<AccountInfoStorage>().isLoggedIn()
            ? TapProfileScr()
            : SignInScr()
      ];*/

  /*void changePage(int index) {
    currentIndex.value = index;
    tabController.index = index;
    tabController.jumpToTab(index);
    Get.routing.current = pages[index];
    update();
    print(Get.currentRoute);
    print(currentIndex.value);
    //Get.toNamed(pages[index]);
    //tabController.jumpToTab(index);
  }*/

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

/*
  int newPublish = 0;
  final int _navigatorValue = 0;
  final String _currentPage = 'Page1';
  var _navigatorKey;
  int loadOrScrollHome = 0;
  int loadOrScrollAds = 0;
  final AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

  final List<String> _pageKeys = ['Page1', 'Page2', 'Page3', 'Page4', 'Page5'];

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

  Widget currentScreen = HomeView();

  List<Widget> buildScreens = [
    HomeView(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapMyAdsScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapPublishScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapChatScr() : SignInScr(),
    Get.find<AccountInfoStorage>().isLoggedIn() ? TapProfileScr() : SignInScr()
  ];

// Start introduction une seule fois
  startIntro1() {
    intro.start(context);
    if (accountInfoStorage.readIntro() == null) {

    }
  }

  Intro intro;

  @override
  void onInit() {
    controller = PersistentTabController(initialIndex: 0);

    controller.addListener(() {});
    super.onInit();

    currentScreen = PageToView(
      naigatorKey: _navigatorKeys[_pageKeys[0]],
      tabItem: _pageKeys[0],
    );
    //Get.find<TapHomeViewController>()        .setUserName(Get.find<AccountInfoStorage>().readName() ?? "");
    intro = Intro(
      /// You can set it true to disable animation
      noAnimation: false,

      /// The total number of guide pages, must be passed
      stepCount: 4,

      /// Click on whether the mask is allowed to be closed.
      maskClosable: true,

      /// When highlight widget is tapped.
      onHighlightWidgetTap: (introStatus) {},

      /// The padding of the highlighted area and the widget
      padding: const EdgeInsets.all(8),

      /// Border radius of the highlighted area
      borderRadius: const BorderRadius.all(Radius.circular(4)),

      /// Use the default useDefaultTheme provided by the library to quickly build a guide page
      /// Need to customize the style and content of the guide page, implement the widgetBuilder method yourself
      /// * Above version 2.3.0, you can use useAdvancedTheme to have more control over the style of the widget
      /// * Please see https://github.com/tal-tech/flutter_intro/issues/26
      widgetBuilder: StepWidgetBuilder.useDefaultTheme(
        /// Guide page text
        texts: [
          'Gérér vos annonces déjà déposées en appuyant sur le menu "Annonces"',
          'Appuyer sur le bouton "+" pour passer une nouvelle annonce',
          'Consulter vos messages en appuyant sur "Chat"',
          'Gérer votre profil ici',
        ],

        /// Button text
        buttonTextBuilder: (curr, total) {
          return curr < total - 1 ? 'Suivant' : 'Terminer';
        },
      ),
    );
  }

  updateList() {
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
    if (value == 0) {
      //Get.find<TapHomeViewController>().scrollUpHome();
    }
    if (value == 1) {
      Get.find<TapMyAdsViewController>().loadOrScrollUpAds();
    }
    Get.find<TapPublishViewController>().loadTapPublish(value);
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
    Widget currentScreen = HomeView();

    switch (tabItem) {
      case 'Page1':
        {
          currentScreen = HomeView();

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
*/
