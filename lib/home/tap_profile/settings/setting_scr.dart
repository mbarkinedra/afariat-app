import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:afariat/mywidget/parametres_item.dart';
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
          "Changer mot de passe ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: framColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Changement de mot de passe:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<SettingViewController>(builder: (logic) {
              return ParametresItem(
                label: "",
                hint: "Ancien mot de passe",
                obscureText: logic.isVisiblePassword1,
                textEditingController: controller.oldPassword,
                validator: (value) {
                  return controller.validateServer.validate(value, 'password');
                },
                suffixIcon: IconButton(
                  onPressed: controller.showHidePassword1,
                  icon: Icon(
                    logic.isVisiblePassword1
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              );
            }),
            SizedBox(
              height: 12,
            ),
            GetBuilder<SettingViewController>(builder: (logic) {
              return ParametresItem(
                label: "",
                hint: "Nouveau mot de passe",
                obscureText: logic.isVisiblePassword2,
                textEditingController: controller.newPassword,
                validator: (value) {
                  return controller.validateServer.validate(value, 'password');
                },
                suffixIcon: IconButton(
                  onPressed: controller.showHidePassword2,
                  icon: Icon(
                    logic.isVisiblePassword2
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              );
            }),
            SizedBox(
              height: 25,
            ),
            GetBuilder<SettingViewController>(builder: (logic) {
              return CustomButton1(
                height: 50,
                label: "Mettre à jour",
                icon: Icons.refresh_outlined,
                iconcolor:
                    logic.updatePasseword ? backmenubackground : framColor,
                width: size.width * .5,
                btcolor: logic.updatePasseword ? framColor : backmenubackground,
                labcolor:
                    logic.updatePasseword ? backmenubackground : framColor,
                function: () {
                  controller.changePassword();
                },
              );
            }),
            SizedBox(
              height: 130,
            ),
            /* Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 40, right: 8, left: 8),
              child: CustomButton1(
                width: MediaQuery.of(context).size.width * .6,
                height: 50,
                label: "Supprimer mon compte",
                icon: Icons.delete_outline_sharp,
                iconcolor: Colors.white,
                btcolor: framColor,
                labcolor: Colors.white,
                function: () async {
                  await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return CustomDialogueDelete(
                          text2: " ",
                          title: "Confirmation",
                          function: () {
                            Navigator.of(context).pop(true);
                          },
                          buttonText2: "Annuler",
                          description:
                              "Êtes-vous sûr de  vouloir supprimer votre compte ?",
                          buttonText: "Ok",
                          phone: false,
                          okFunction: controller.deleteUser,
                        );
                      });
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
