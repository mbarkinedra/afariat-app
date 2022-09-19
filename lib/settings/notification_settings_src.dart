import 'package:afariat/config/utility.dart';
import 'package:afariat/networking/json/preference_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_settings_controller.dart';

class NotificationSettingsView
    extends GetWidget<NotificationSettingsViewController> {
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
              child: FutureBuilder<NotificationSettingsViewController>(
                  future: controller.fetchData(),
                  builder: (context,
                      AsyncSnapshot<NotificationSettingsViewController>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: _size.height * .40,
                                width: _size.width,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  children: <Widget>[
                                    const Text(
                                      'Vos abonnements',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 22,
                                          color: Colors.grey),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'M\'inscrire aux newsletters',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value: controller.optinLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(1, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Notifications aux messages',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value: controller.messageLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(2, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Statistiques une fois par semaine',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value:
                                              controller.statisticsLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(3, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Vie de l\'annonce',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value: controller
                                              .advertStatusLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(4, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Alertes pour les nouvelles annonces',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                            () => CupertinoSwitch(
                                          value: controller
                                              .alertLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(10, value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: _size.height * .4,
                                width: _size.width,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  children: <Widget>[
                                    const Text(
                                      'Canaux de diffusion',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 22,
                                          color: Colors.grey),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'SMS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value: controller.canalSmsLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(5, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value:
                                              controller.canalEmailLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(7, value);
                                          },
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        'Application',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      trailing: Obx(
                                        () => CupertinoSwitch(
                                          value: controller.canalAppLight.value,
                                          activeColor: framColor,
                                          onChanged: (bool value) {
                                            controller.updateData(8, value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
