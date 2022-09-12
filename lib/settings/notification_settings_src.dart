import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_settings_controller.dart';

class NotificationSettingsView extends GetWidget<NotificationSettingsViewController> {
  const NotificationSettingsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Paramètres de notifications",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: framColor,
        ),
        body: Row(
          children: [
            Flexible(
              flex: 1,
              child: GetBuilder<NotificationSettingsViewController>(builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                      'Activer les notifications',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: colorGrey),
                    ),
                    trailing: CupertinoSwitch(
                      value: logic.lights,
                      activeColor: framColor,
                      onChanged: logic.updateLight,
                    ),
                    onTap: () {
                      logic.lights = !logic.lights;
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
