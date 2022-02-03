import 'package:afariat/config/storage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';
import 'tap_home/tap_home_scr.dart';
import 'tap_myads/tap_myads_scr.dart';
import 'tap_profile/settings/setting_view_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'tap_publish/tap_publish_viewcontroller.dart';

class Home extends GetWidget<HomeViwController> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return WillPopScope(
    //   onWillPop: () async {
    //     final isFirstRouteInCurrentTab = !await controller
    //         .navigatorKeys[controller.currentPage].currentState
    //         .maybePop();
    //     //   print(isFirstRouteInCurrentTab);
    //     if (isFirstRouteInCurrentTab) {
    //       if (controller.currentPage != "Page1") {
    //         controller.changeSelectedValue(0);
    //
    //         return false;
    //       }
    //     }
    //     print(isFirstRouteInCurrentTab);
    //     // let system handle back button if we're on the first route
    //     return isFirstRouteInCurrentTab;
    //   },
    //   child: SafeArea(
    //     child: Scaffold(
    //       body: GetBuilder<HomeViwController>(builder: (logic) {
    //         return logic.currentScreen;
    //       }),
    //       //init: HomeViwController(),
    //       bottomNavigationBar:
    //
    //
    //
    //
    //       GetBuilder<HomeViwController>(builder: (logic) {
    //         return   ConvexAppBar(
    //           items: [
    //             TabItem(icon: Icons.home, title: 'Accueil'),
    //             TabItem(icon: Icons.photo_size_select_large_outlined, title: ' Annonces'),
    //             TabItem(icon: Icons.add_box_rounded, title: 'Déposer'),
    //             TabItem(icon: Icons.article_rounded, title: 'Chat'),
    //             TabItem(icon: Icons.person, title: 'Profil'),
    //           ],
    //           initialActiveIndex:controller.navigatorValue,//optional, default as 0
    //           onTap: controller.changeSelectedValue,
    //     backgroundColor:  Colors.deepOrange, color: Colors.white, );
    //
    //
    //
    //         //
    //         //   BottomNavigationBar(
    //         //   items: const [
    //         //     BottomNavigationBarItem(
    //         //       icon: Icon(Icons.home),
    //         //       label: 'MyHome',
    //         //     ),
    //         //     BottomNavigationBarItem(
    //         //       icon: Icon(Icons.photo_size_select_large_outlined),
    //         //       label: 'Publish',
    //         //     ),
    //         //     BottomNavigationBarItem(
    //         //       icon: Icon(
    //         //         Icons.add_box_rounded,
    //         //         color: Colors.transparent,
    //         //       ),
    //         //       label: 'Ads',
    //         //     ),
    //         //     BottomNavigationBarItem(
    //         //       icon: Icon(Icons.article_rounded),
    //         //       label: 'Notification',
    //         //     ),
    //         //     BottomNavigationBarItem(
    //         //       icon: Icon(Icons.person),
    //         //       label: 'Account',
    //         //     )
    //         //   ],
    //         //   onTap: controller.changeSelectedValue,
    //         //   currentIndex: controller.navigatorValue,
    //         //   iconSize: 35,
    //         //   showSelectedLabels: false,
    //         //   showUnselectedLabels: false,
    //         //   type: BottomNavigationBarType.fixed,
    //         //   unselectedItemColor: Colors.grey,
    //         //   selectedItemColor: Colors.deepOrangeAccent,
    //         //   elevation: 5,
    //         // );
    //       }),
    //
    //
    //
    //
    //       // floatingActionButton: FloatingActionButton(
    //       //   onPressed: () {
    //       //     print("88888");
    //       //     controller.changeSelectedValue(2);
    //       //   },
    //       //   child: Icon(
    //       //     Icons.add,
    //       //   ),
    //       //   backgroundColor: Colors.deepOrangeAccent,
    //       // ),
    //       // floatingActionButtonLocation:
    //       //     FloatingActionButtonLocation.centerDocked,
    //     ),
    //   ),
    // );
   return GetBuilder<HomeViwController>(builder: (logic) {
    return PersistentTabView(
      context,
      controller: logic.controller,
      screens: logic.buildScreens,
      items: _navBarsItems(),selectedTabScreenContext:(BuildContext context){

        Get.find<TapPublishViewController>().context=context;
    } ,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    ); });}




  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Acceuil"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.photo_size_select_large_outlined),
        title: ("Annonces"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon( Icons.add,color: Colors.white,size: 35,),
        title: ("Publier"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon(Icons.article_rounded),
        title: ("Chat"),
        activeColorPrimary:Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ), PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("profil"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

}
