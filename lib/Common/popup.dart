import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../persistent_tab_manager.dart';

class Popup {
  static showAccessDenied(BuildContext context, String message) {
    Get.defaultDialog(
      title: 'Connexion requise',
      titleStyle: const TextStyle(color: Colors.black54),
      content: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 40),
        child: DecoratedBox(
          decoration: BoxDecoration(color: Colors.grey.shade100),
          child: SizedBox(
            height: 80,
            width: 250,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                message,
                style: TextStyle(color: Colors.grey.shade800),
              ),
            ),
          ),
        ),
      ),
      radius: 5,
      textConfirm: '  Je me connecte  ',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(closeOverlays: true);
        PersistentTabManager.gotToHome(context);
        PersistentTabManager.changePage(4);
      },
    );
  }
}
