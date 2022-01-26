import 'package:afariat/config/storage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';
import 'tap_profile/settings/setting_view_controller.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends GetWidget<HomeViwController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await controller
            .navigatorKeys[controller.currentPage].currentState
            .maybePop();
        //   print(isFirstRouteInCurrentTab);
        if (isFirstRouteInCurrentTab) {
          if (controller.currentPage != "Page1") {
            controller.changeSelectedValue(0);

            return false;
          }
        }
        print(isFirstRouteInCurrentTab);
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: SafeArea(
        child: Scaffold(
          body: GetBuilder<HomeViwController>(builder: (logic) {
            return logic.currentScreen;
          }),
          //init: HomeViwController(),
          bottomNavigationBar: GetBuilder<HomeViwController>(builder: (logic) {
            return   ConvexAppBar(
              items: [
                TabItem(icon: Icons.home, title: 'Accueil'),
                TabItem(icon: Icons.photo_size_select_large_outlined, title: 'My ads'),
                TabItem(icon: Icons.add_box_rounded, title: 'Déposer'),
                TabItem(icon: Icons.article_rounded, title: 'Messages'),
                TabItem(icon: Icons.person, title: 'Profil'),
              ],
              initialActiveIndex:controller.navigatorValue,//optional, default as 0
              onTap: controller.changeSelectedValue,
        backgroundColor:  Colors.deepOrange, color: Colors.white, );



            //
            //   BottomNavigationBar(
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'MyHome',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.photo_size_select_large_outlined),
            //       label: 'Publish',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(
            //         Icons.add_box_rounded,
            //         color: Colors.transparent,
            //       ),
            //       label: 'Ads',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.article_rounded),
            //       label: 'Notification',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.person),
            //       label: 'Account',
            //     )
            //   ],
            //   onTap: controller.changeSelectedValue,
            //   currentIndex: controller.navigatorValue,
            //   iconSize: 35,
            //   showSelectedLabels: false,
            //   showUnselectedLabels: false,
            //   type: BottomNavigationBarType.fixed,
            //   unselectedItemColor: Colors.grey,
            //   selectedItemColor: Colors.deepOrangeAccent,
            //   elevation: 5,
            // );
          }),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     print("88888");
          //     controller.changeSelectedValue(2);
          //   },
          //   child: Icon(
          //     Icons.add,
          //   ),
          //   backgroundColor: Colors.deepOrangeAccent,
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
