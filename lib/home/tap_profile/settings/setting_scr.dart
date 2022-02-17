import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/log_in_item.dart';
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
          "Paramètres ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Changement de mot de passe:",
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GetBuilder<SettingViewController>(builder: (logic) {
            return LogInItem(
              label: "",

              hint: "Nouveau mot de passe",
             // icon: Icons.lock_outline,
              //Ajouter
              obscureText: logic.isVisiblePassword,
              textEditingController: controller.oldPassword,
              validator: (value) {
                return controller.validateServer.validator(value, 'password');
              },
              suffixIcon: IconButton(
                onPressed: controller.showHidePassword,
                icon: Icon(logic.isVisiblePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            );
          }),
          // CustomTextFiled(
          //   color: framColor,
          //   width: size.width * .8,
          //   hintText: "Nouveau mot de passe",
          //   textEditingController: controller.oldPassword,
          // ),
          SizedBox(
            height: 12,
          ),
          GetBuilder<SettingViewController>(builder: (logic) {
            return LogInItem(
              label: "",
              hint: "Nouveau mot de passe",
             // icon: Icons.lock_outline,
              //Ajouter
              obscureText: logic.isVisiblePassword,
              textEditingController: controller.newPassword,
              validator: (value) {
                return controller.validateServer.validator(value, 'password');
              },
              suffixIcon: IconButton(
                onPressed: controller.showHidePassword,
                icon: Icon(logic.isVisiblePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            );
          }),
          // CustomTextFiled(
          //   color: framColor,
          //   width: size.width * .8,
          //   hintText: "Ancien mot de passe",
          //   textEditingController: controller.newPassword,
          // ),
          SizedBox(
            height: 12,
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
          SizedBox(
            height: 130,
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
                    "Annuler",
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
