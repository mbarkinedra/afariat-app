import 'package:afariat/config/utility.dart';
import 'package:afariat/settings/settings_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_routing.dart';
import '../mywidget/menu_entry.dart';
import 'notification_settings_view.dart';
import '../storage/AccountInfoStorage.dart';

class SettingsView extends GetView<SettingsViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          " Paramètres",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: framColor,
        leading: IconButton(
            icon: const Icon(
              //
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 40),
          MenuEntry(
            icon: Icons.notifications,
            text: "Préférence des notifications",
            press: () => {
              if (!Get.find<AccountInfoStorage>().isLoggedIn())
                {
                  Get.snackbar("Connexion requise",
                      "Veuillez vous connecter pour accéder à vos préférences",
                      colorText: Colors.black)
                }
              else
                {Get.toNamed(AppRouting.preferences)}
            },
          ),
        ]),
      ),
    );
  }
}
