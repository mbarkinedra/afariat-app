import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/settings/setting_view_controller.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'delete_account_viewcontroller.dart';

class DeleteAccountScr extends GetWidget<DeleteAccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    // controller.getAllAds();
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Suppression du compte",
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.00),
                    child: Text(" Suppression définitive de votre compte ?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[100],
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
                                  "La supression de votre compte est irreversible. Toutes vos données ci-dessous seront perdues à jamais.",
                                  style: TextStyle(
                                      //  fontWeight:  FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("\u2022 Toutes vos annonces",
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
                              child: Text("\u2022 Toutes vos données",
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
                              child: Text("\u2022 Tous vos messages",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
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
                        fontWeight: FontWeight.bold,
                        icon: Icons.delete_outline_sharp,
                        iconcolor: Colors.white,
                        btcolor: Colors.red,
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
