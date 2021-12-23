
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view_controller.dart';



class Home extends GetWidget<HomeViwController>  {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return WillPopScope(onWillPop: ()async{
      final isFirstRouteInCurrentTab =
      !await controller.navigatorKeys[controller.currentPage].currentState.maybePop();
      //   print(isFirstRouteInCurrentTab);
      if (isFirstRouteInCurrentTab) {
        if (controller.currentPage != "Page1") {
          controller.changeSelectedValue(  0 );

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
          }), //init: HomeViwController(),
          bottomNavigationBar:

          GetBuilder<HomeViwController>(builder: (logic) {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),

                  label: 'MyHome',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.photo_size_select_large_outlined),

                  label: 'Publish',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_rounded),

                  label: 'Ads',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.article_rounded),

                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),

                  label: 'Account',
                )
              ],
              onTap:controller.changeSelectedValue,

              currentIndex: controller.navigatorValue,
              iconSize: 35,
              showSelectedLabels: false,
              showUnselectedLabels: false,

              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.orange,
              elevation: 5,
            );
          }),
        ),
      ),
    );
  }
}


