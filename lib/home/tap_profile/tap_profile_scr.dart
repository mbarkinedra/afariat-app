

import 'package:afariat/config/storage.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_view_controller.dart';
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
                // Navigator.of(context).push(MaterialPageRoute(
                // builder: (
                // context,
                // ) =>
                //     SignForm())),
              },
            ),
            ProfileMenu(
              text: "Settings",
              //icon: "assets/icons/Settings.svg",
              press: () {},
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
                Get.find<SecureStorage>().deleteSecureData(Get.find<SecureStorage>().key_wsse);
                Get.find<HomeViwController>().changeSelectedValue(0);

              },
            ),
          ],
        ),
      ),
    );
  }
}
