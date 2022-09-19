import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_home/favorite/parametre_viewcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mywidget/menu_entry.dart';
import '../../../settings/notification_settings_src.dart';
import '../../../storage/AccountInfoStorage.dart';

class ParametreScr extends GetView<ParametreViewContoller> {
  const ParametreScr({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (
                    context,
                  ) =>
                          const NotificationSettingsView())),
                }
            },
          ),
        ]),
      ),
    );
  }
}
