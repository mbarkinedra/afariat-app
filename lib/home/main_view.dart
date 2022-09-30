import 'package:afariat/config/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_view_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// ignore: must_be_immutable
class MainView extends GetWidget<MainViewController> {
  const MainView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      controller.context = context;
    });
    return PersistentTabView(
      context, onItemSelected: (int index) => controller.changePage(index),
      controller: controller.tabController,
      screens: controller.buildScreens,
      items: _navBarsItems(),
      selectedTabScreenContext: (BuildContext context) {
        controller.context = context;
        //Get.find<TapPublishViewController>().context = context;
      },
      confineInSafeArea: false,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      //  popAllScreensOnTapOfSelectedTab: true,
      // popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInCubic,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Acceuil"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: controller.routeAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.photo_size_select_large_outlined),
        title: ("Annonces"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: controller.routeAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add, color: Colors.white, size: 35),
        title: ("Publier"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: controller.routeAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.article_rounded),
        title: ("Chat"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings: controller.routeAndNavigatorSettings(),
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: const [
            Icon(
              Icons.person,
            ),
          ],
        ),
        title: ("Profil"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
