import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_profile/notification/notification_scr.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_view_controller.dart';
import 'account/account_scr.dart';
import 'notification/notification_view_controller.dart';
import 'settings/setting_scr.dart';
import 'tap_profile_viewcontroller.dart';

class TapProfileScr extends GetWidget<TapProfileViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/images/Splash_10.png",
                width: 120,
                height: 120,
              ),
            ),
            SizedBox(height: 5),
            ProfileMenu(
              iconProfile: Icons.person,
              text: "Mon compte",
              press: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Account())),
              },
            ),
            Obx(() {
              return ProfileMenu(
                iconProfile: Icons.notifications_outlined,
                text: "Notifications",
                hasNotification: Get.find<NotificationViewController>()
                    .hasNotification
                    .value,
                isNotification: true,
                press: () {
                  Get.find<NotificationViewController>().hasNotification.value =
                      false;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (
                    context,
                  ) =>
                          NotificationSrc()));
                },
              );
            }),
            ProfileMenu(
              iconProfile: Icons.settings,
              text: "Paramètres",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Setting()));
              },
            ),
            ProfileMenu(
              iconProfile: Icons.logout,
              text: "Déconnexion",
              press: () {
                Get.find<AccountInfoStorage>().logout();
               // Get.find<HomeViewController>().updateList();
                Get.find<NotificationViewController>().hasNotification.value =
                    false;
                Get.find<TapHomeViewController>().deleteAllFavoritesList();
                Get.find<NotificationViewController>().clearList();
                Get.find<HomeViewController>().changeItemFilter(0);
                Get.find<TapHomeViewController>().setUserName("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
