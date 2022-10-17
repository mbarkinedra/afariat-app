import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/settings/change_password_view_controller.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../mywidget/custom_text_filed.dart';
import 'delete_account_view_controller.dart';

class DeleteAccountView extends GetWidget<DeleteAccountViewController> {
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  " Suppression définitive de votre compte",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 1.0, bottom: 2.0, right: 8.0),
                          child: RichText(
                            text: const TextSpan(
                                text: 'Important \n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "La supression de votre compte est irreversible. \n\nToutes vos données ci-dessous seront perdues à jamais.",
                              style: TextStyle(
                                  //  fontWeight:  FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("\u2022 Vos annonces",
                              style: TextStyle(
                                  //  fontWeight:  FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("\u2022 Vos données",
                              style: TextStyle(
                                  //fontWeight:  FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("\u2022 Vos messages",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: CustomButton1(
                    width: MediaQuery.of(context).size.width * .6,
                    height: 50,
                    label: "Supprimer mon compte",
                    fontWeight: FontWeight.bold,
                    icon: Icons.delete_outline_sharp,
                    iconcolor: Colors.white,
                    btcolor: Colors.red,
                    labcolor: Colors.white,
                    function: () async {
                      _showDeleteDialog(context);
                      /* await showDialog<bool>(
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
                             // okFunction:
                                  //Get.find<ChangePasswordViewController>()
                                   //   .deleteUser,
                            );
                          });*/
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDeleteDialog(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    Get.defaultDialog(
      title: 'Authentification',
      titleStyle: const TextStyle(color: Colors.black54),
      content: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 40),
        child: Column(
          children: [
            const Text('Veuillez saisir votre mot de passe'),
            const SizedBox(
              height: 20,
            ),
            Obx(() => controller.error.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 25),
                    child: Text(
                      controller.error.value,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox()),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => CustomTextFiled(
                width: _size.width * .9,
                hintText: "Votre mot de passe",
                maxLines: 1,
                obscureText: controller.isVisiblePassword.isFalse,
                textEditingController: controller.password,
                suffixIcon: IconButton(
                  onPressed: controller.togglePassword,
                  icon: Icon(
                    controller.isVisiblePassword.isFalse
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                color: framColor,
              ),
            ),
          ],
        ),
      ),
      radius: 5,
      confirm: CustomButton1(
        width: _size.width * .3,
        height: 50,
        label: "Valider",
        fontWeight: FontWeight.bold,
        icon: Icons.delete_outline_sharp,
        iconcolor: Colors.white,
        btcolor: Colors.redAccent,
        labcolor: Colors.white,
        function: () async {
          controller.deleteUser(context);
        },
      ),
      cancel: CustomButton1(
        width: _size.width * .3,
        height: 50,
        label: "Annuler",
        fontWeight: FontWeight.bold,
        icon: Icons.arrow_back,
        iconcolor: Colors.black54,
        btcolor: Colors.white,
        labcolor: Colors.black54,
        function: () async {
          Navigator.of(Get.overlayContext, rootNavigator: true).pop();
        },
      ),
    );
  }
}
