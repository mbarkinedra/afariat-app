import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../config/Environment.dart';
import '../config/app_config.dart';
import '../config/utility.dart';
import '../storage/AccountInfoStorage.dart';
import 'drawer_view_controller.dart';

class DrawerView extends GetWidget<DrawerViewController> {
  @override
  final DrawerViewController controller;

  const DrawerView({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = context.mediaQuery.size;
    var appConfig = AppConfig.of(context);
    return SizedBox(
      width: _size.width * .8,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/" + appConfig.appName + "/drawer.jpg",
                        ),
                        fit: BoxFit.fill)),
                child: SizedBox(
                  width: _size.width * .8,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*  Padding(
                        padding: const EdgeInsets.only(
                            top: 30, right: 8.0, left: 8),
                        child: GetBuilder<TapHomeViewController>(
                            builder: (logic) {
                              return Text(logic.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold));
                            }),
                      ),*/
                    ],
                  ),
                ),
              ),
              //  Spacer(),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Get.find<AccountInfoStorage>().isLoggedIn()
                      ? Colors.red
                      : Colors.grey,
                ),
                title: const Text(
                  "Mes favoris",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (Get.find<AccountInfoStorage>().isLoggedIn()) {
                    Get.toNamed('/account/favorites');
                    //replace with get/toNamed
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoriteScr()),
                    );*/
                  } else {
                    Get.snackbar("Connexion requise",
                        "Veuillez vous connecter pour accéder à vos favoris",
                        colorText: Colors.white, backgroundColor: buttonColor);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                title: const Text(
                  "Paramètres",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Get.toNamed('/settings');
                },
              ),
              const Divider(
                thickness: 1,
                color: colorText,
              ),
              ListTile(
                leading: const Icon(
                  Icons.help_center,
                  color: colorText,
                ),
                title: const Text(
                  "Centre d'aide",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL(Environment.helpUrl);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.checklist,
                  color: colorText,
                ),
                title: const Text(
                  "Règlement",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL(Environment.rulesUrl);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.https,
                  color: colorText,
                ),
                title: const Text(
                  "Confidentialité ",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL(Environment.privacyUrl);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.gavel,
                  color: colorText,
                ),
                title: const Text(
                  "CGU ",
                  style:
                      TextStyle(color: colorText, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  controller.launchURL(Environment.cguUrl);
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
