import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
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
          title: const Text(
            "Changement de mot de passe",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          backgroundColor: framColor,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.registerFormKey,
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
                      "Saisissez votre ancien mot de passe puis choisissez un nouveau:",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                      return controller.validator.validatorServer
                          .validate(value, 'currentPassword');
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
                      return controller.validator.validatorServer
                          .validate(value, 'plainPassword');
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
                  return logic.updateData
                      ? const CircularProgressIndicator()
                      : CustomButton1(
                          height: 50,
                          label: "Mettre à jour",
                          icon: Icons.refresh_outlined,
                          iconcolor: Colors.white,
                          labcolor: Colors.white,
                          width: size.width * .5,
                          btcolor: framColor,
                          function: () async {
                            await controller.changePassword();
                          },
                        );
                }),
                SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
        ));
  }
}
