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
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.00),
                    child: Text(" Suppression définitive du compte ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 1.0, bottom: 2.0, right: 8.0),
                              child: RichText(
                                text: const TextSpan(children: [
                                  TextSpan(
                                      text: "Important",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black)),
                                  TextSpan(
                                      text:
                                          ": La supression de compte est irreversible. Tous vos données ci-dessous seront perdues à jamais.",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black)),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" Toutes vos annonces",
                                  style: TextStyle(
                                      //  fontWeight:  FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" Toutes vos données",
                                  style: TextStyle(
                                      //fontWeight:  FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(" Tous vos messages",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black)),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Padding(
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
                                  okFunction: Get.find<SettingViewController>()
                                      .deleteUser,
                                );
                              });
                        },
                      ),
                    ),
                  ),
                ]))));
  }
}
