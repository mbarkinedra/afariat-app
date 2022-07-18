import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/settings/setting_view_controller.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'delete_account_viewcontroller.dart';

class DeleteAccountScr extends GetWidget<DeleteAccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // controller.getAllAds();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Supprimer compte",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              backgroundColor: framColor,
            ),
            body: Column(children: [
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SizedBox(
                      height: 175,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text("Êtes-vous sûr de vouloir supprimer votre compte ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey)),
                    )
                  ])
              ,

              )
              ,SizedBox(
                height: 80,
              ),
              Padding(
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
                            okFunction: Get.find<SettingViewController>().deleteUser,
                          );
                        });
                  },
                ),
              ),
            ])));
  }
}
