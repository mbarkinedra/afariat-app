

import 'package:afariat/config/storage.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/account_profile/account_scr.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/profile_menu.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_view_controller.dart';
import 'tap_profile_viewcontroller.dart';
import 'package:afariat/config/AccountInfoStorage.dart';

class TapProfileScr extends GetWidget<TapProfileViewController> {


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ProfilePic(controller.pic),
            SizedBox(height: 20),
            // // ProfileMenu(
            //   text: "My Account",
            //  // icon: "assets/icons/User Icon.svg",
            //   press: () => {
            //     Navigator.of(context).push(MaterialPageRoute(
            //     builder: (
            //     context,
            //     ) =>
            //         AcountScr())),
            //   },
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  maxRadius: 50, backgroundColor: Colors.orange,
                  //backgroundImage: NetworkImage(userAvatarUrl),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: _size.width * .5,
                      child: TextField(controller: controller.name,onSubmitted: controller.updatname  ,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                        ),
                      ),
                    ),
                    Container(
                      width: _size.width * .5,
                      child: TextField(controller: controller.phone,onSubmitted: controller.updatphone ,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.edit),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            // CustomButton(
            //   height: 50,
            //   width: _size.width * .7,
            //   label: "change password",
            //   labcolor: buttonColor,
            //   btcolor: Colors.grey[200],function: (){},icon: Icons.lock_outline,iconcolor: framColor,
            // ),
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
              text: "notification",
              //  icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              //  icon: "assets/icons/Log out.svg",
              press: () {
                AccountInfoStorage.removeHashedPassword();
                Get.find<HomeViwController>().changeSelectedValue(0);

              },
            ),
          ],
        ),
      ),
    );
  }
}