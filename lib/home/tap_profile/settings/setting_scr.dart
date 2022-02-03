import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custmbutton.dart';
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
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
          SizedBox(
            height: 20,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: "Nouveau mot de passe",
            textEditingController: controller.oldPassword,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: "Ancien mot de passe",
            textEditingController: controller.newPassword,
          ),
          CustomButton(
            height: 50,
            label: "Mettre à jour",
            icon: Icons.refresh_outlined,
            iconcolor: Colors.white,
            width: size.width * .8,
            btcolor: framColor,
            labcolor: Colors.white,
            function: () {
              controller.changePassword();
            },
          ),
          CustomButton(
            height: 50,
            label: "Supprimer mon compte",
            icon: Icons.delete,
            iconcolor: Colors.white,
            width: size.width * .8,
            btcolor: framColor,
            labcolor: Colors.white,
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
