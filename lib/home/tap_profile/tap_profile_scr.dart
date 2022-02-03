import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/home/tap_profile/notification/notification_scr.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:afariat/sign_in/sign_in_scr.dart';
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
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/images/Splash_1.png",
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
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
                hasnotfication: Get.find<NotificationViewController>()
                    .hasNotification
                    .value,
                isnotfication: true,
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
              iconProfile: Icons.help_center,
              text: "Centre d'aide",
              press: () {
                controller.launchURL("https://afariat.com/aide.html");
              },
            ),
            ProfileMenu(
              iconProfile: Icons.logout,
              text: "Déconnexion",
              press: () {
                Get.find<AccountInfoStorage>().removeHashedPassword();
                Get.find<HomeViwController>().changeSelectedValue(0);
                Get.find<AccountInfoStorage>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
