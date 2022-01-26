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
            CircleAvatar(
              maxRadius: 50,
              backgroundImage: NetworkImage(
                  "https://www.sleeptasticsolutions.com/wp-content/uploads/2018/05/happy-kids-1.jpg"),
            ),
          //  ProfilePic(controller.pic),
            SizedBox(height: 20),
            ProfileMenu(
              text: "Mon compte",
              // icon: "assets/icons/User Icon.svg",
              press: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Account())),
              },
            ),
            ProfileMenu(
              text: "Paramètres",
              //icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (
                  context,
                ) =>
                        Setting()));
              },
            ),
            ProfileMenu(
              text: "Centre d'aide",
              //  icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            Obx(() {
              return ProfileMenu(
                text: "Notifications",
                hasnotfication: Get.find<NotificationViewController>()
                    .hasnotification
                    .value,
                isnotfication: true,
                //  icon: "assets/icons/Question mark.svg",
                press: () {
                  Get.find<NotificationViewController>().hasnotification.value =
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
              text: "Déconnexion",
              //  icon: "assets/icons/Log out.svg",
              press: () {
                Get.find<AccountInfoStorage>().removeHashedPassword();
                Get.find<HomeViwController>().changeSelectedValue(0);
                Get.find<AccountInfoStorage>().logout();
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (
                //         context,
                //         ) =>
                //         SignInScr()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
