import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'setting_view_controller.dart';

class Setting extends GetWidget<SettingViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings ",
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Modifier mon mot de passe:",
              style: TextStyle(fontSize: 15),
            ),
          ),

          // CircleAvatar(maxRadius: 50,
          //   backgroundImage: NetworkImage(
          //       "https://www.sleeptasticsolutions.com/wp-content/uploads/2018/05/happy-kids-1.jpg"),
          // ),

          SizedBox(
            height: 20,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: "Nouveau mot de passe",
            textEditingController: controller.password1,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: "Ancien mot de passe",
            textEditingController: controller.password2,
          ),
          CustomButtonWithoutIcon(
            height: 50,
            label: "send",
            width: size.width * .8,
            btcolor: framColor,
            function: () {
              controller.changePassword();
            },
          ),
          CustomButtonWithoutIcon(
            height: 50,
            label: "Supprimer mon compte",
            width: size.width * .8,
            btcolor: framColor,
            function: () {
              Get.defaultDialog(
                cancel: GestureDetector(
                  child: Text(
                    "cancel",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                title: "Confiramtion",
                titlePadding: EdgeInsets.all(8),
                content: Container(
                  height: 100,
                  child: Center(
                      child: Text(
                    " Êtes-vous sûr de supprimer votre compte?",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                confirm: GestureDetector(
                  child: Text(
                    "ok",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  onTap: () {
                    //  controller.deleteuser();
                  },
                ),
                titleStyle: TextStyle(color: Colors.deepOrange),
                middleTextStyle: TextStyle(color: Colors.deepOrange),
              );
            },
          ),
        ],
      ),
    );
  }
}
