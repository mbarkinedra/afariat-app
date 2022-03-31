import 'package:afariat/config/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';

import 'tap_profile/notification/notification_view_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'tap_publish/tap_publish_viewcontroller.dart';

class Home extends GetWidget<HomeViwController> {
  @override
  Widget build(BuildContext context) {
    return  PersistentTabView(
      context, onItemSelected: controller.changeItemFilter,
      controller: controller.controller,
      screens: controller.buildScreens,
      items: _navBarsItems(),
      selectedTabScreenContext: (BuildContext context) {
         Get.find<TapPublishViewController>().context = context;

      },
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: false,
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
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(seconds: 1),
        curve: Curves.easeInCubic,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
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
        icon: Icon(CupertinoIcons.home),
        title: ("Acceuil"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.photo_size_select_large_outlined),
        title: ("Annonces"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        title: ("Publier"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.article_rounded),
        title: ("Chat"),
        activeColorPrimary:framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            Icon(
              Icons.person,
            ),
            Obx(() =>
                Get.find<NotificationViewController>().hasNotification.value
                    ? Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        height: 10,
                        width: 10,
                      )
                    : SizedBox())
          ],
        ),
        title: ("Profile"),
        activeColorPrimary: framColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
