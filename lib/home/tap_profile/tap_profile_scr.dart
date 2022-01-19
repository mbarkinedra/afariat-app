

import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:afariat/sign_in/sign_in_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_view_controller.dart';
import 'account/account_scr.dart';
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
            ProfilePic(controller.pic),
            SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
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
              text: "Settings",
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
              text: "Help Center",
            //  icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
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
