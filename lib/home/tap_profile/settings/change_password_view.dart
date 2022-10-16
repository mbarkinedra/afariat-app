import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/parametres_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../mywidget/custom_text_filed.dart';
import '../../../storage/AccountInfoStorage.dart';
import 'change_password_view_controller.dart';

class ChangePasswordView extends GetWidget<ChangePasswordViewController> {
  const ChangePasswordView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var appConfig = AppConfig.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 150,
          backgroundColor: Colors.white,
          foregroundColor: framColor,
          flexibleSpace: Container(
            width: _size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                colors: [
                  Color(0xFFFFCCBC),
                  Colors.white,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                    side: const BorderSide(width: 3, color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10000.0),
                      child: Image.asset(
                        "assets/images/" + appConfig.appName + "/logo.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Form(
                key: controller.changePasswordFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Changement du mot de passe",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Saisissez votre ancien mot de passe puis choisissez un nouveau.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.success.isNotEmpty
                          ? Card(
                              color: Colors.teal,
                              elevation: 1,
                              child: SizedBox(
                                width: _size.width * 0.9,
                                height:
                                    !Get.find<AccountInfoStorage>().isLoggedIn()
                                        ? 90
                                        : 60,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.check_circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            controller.success.value,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      !Get.find<AccountInfoStorage>()
                                              .isLoggedIn()
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5),
                                                    child: Icon(
                                                      Icons.warning_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      'Important: Vous êtes déconnecté automatiquement. Veuillez vous reconnecter.',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.error.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.warning_rounded,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    controller.error.value,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder<ChangePasswordViewController>(builder: (logic) {
                      return CustomTextFiled(
                        width: _size.width * .9,
                        hintText: "Mot de passe actuel",
                        maxLines: 1,
                        obscureText: logic.isVisiblePassword1,
                        textEditingController: controller.currentPassword,
                        validator: (value) {
                          return controller.validator
                              .validateCurrentPassword(value);
                        },
                        suffixIcon: IconButton(
                          onPressed: controller.showHidePassword1,
                          icon: Icon(
                            logic.isVisiblePassword1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        color: framColor,
                      );
                    }),
                    SizedBox(
                      height: 12,
                    ),
                    GetBuilder<ChangePasswordViewController>(builder: (logic) {
                      return CustomTextFiled(
                        width: _size.width * .9,
                        hintText: "Nouveau mot de passe",
                        maxLines: 1,
                        obscureText: logic.isVisiblePassword2,
                        textEditingController: controller.plainPassword,
                        validator: (value) {
                          return controller.validator
                              .validatePlainPassword(value);
                        },
                        suffixIcon: IconButton(
                          onPressed: controller.showHidePassword2,
                          icon: Icon(
                            logic.isVisiblePassword2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        color: framColor,
                      );
                    }),
                    SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => controller.isLoading.isTrue
                          ? const CircularProgressIndicator()
                          : CustomButton1(
                              height: 50,
                              label: "Mettre à jour",
                              icon: Icons.refresh_outlined,
                              iconcolor: Colors.white,
                              labcolor: Colors.white,
                              width: _size.width * .5,
                              btcolor: framColor,
                              function: () async {
                                controller.error.value = '';
                                controller.validator.validationType = false;
                                if (controller
                                    .changePasswordFormKey.currentState
                                    .validate()) {
                                  controller.validator.validationType = true;
                                  await controller.changePassword(context);
                                }
                              },
                            ),
                    ),
                    SizedBox(
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
