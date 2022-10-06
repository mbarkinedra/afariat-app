import 'package:afariat/home/tap_profile/delete_account/delete_account_scr.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_config.dart';
import '../../persistent_tab_manager.dart';
import '../main_view_controller.dart';
import 'account/account_scr.dart';
import 'notification/notification_view_controller.dart';
import 'settings/setting_scr.dart';
import 'tap_profile_viewcontroller.dart';

class TapProfileScr extends GetWidget<TapProfileViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var appConfig = AppConfig.of(context);
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 40),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/images/"+appConfig.appName+"/logo.png",
                width: 200,
                height: 120,
              ),
            ),
            SizedBox(height: 2),
            ProfileMenu(
              iconProfile: Icons.person,
              text: "Mes informations personnelles",
              press: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Account())),
              },
            ),
            // Obx(() {
            //   return ProfileMenu(
            //     iconProfile: Icons.notifications_outlined,
            //     text: "Notifications",
            //     hasNotification: Get.find<NotificationViewController>()
            //         .hasNotification
            //         .value,
            //     isNotification: true,
            //     press: () {
            //       Get.find<NotificationViewController>().hasNotification.value =
            //           false;
            //       Navigator.of(context).push(MaterialPageRoute(
            //           builder: (
            //         context,
            //       ) =>
            //               NotificationSrc()));
            //     },
            //   );
            // }),
            ProfileMenu(
              iconProfile: Icons.lock_rounded,
              text: "Changer votre mot de passe",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Setting()));
              },
            ),
            ProfileMenu(
              iconProfile: Icons.delete_outline_sharp,
              text: "Supprimer le compte",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                        context,
                        ) =>
                        DeleteAccountScr()));
              },
            ),
            ProfileMenu(
              iconProfile: Icons.logout,
              text: "Déconnexion",
              press: () {
                Get.find<AccountInfoStorage>().logout();
                Get.find<NotificationViewController>().hasNotification.value =
                    false;
                Get.find<NotificationViewController>().clearList();

              //  Get.find<TapHomeViewController>().setUserName("");
              },
            ),
          ],
        ),
      ),
    );
  }
}
