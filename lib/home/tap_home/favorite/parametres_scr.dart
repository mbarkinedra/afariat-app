import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_home/favorite/parametre_viewcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParametreScr extends GetView<ParametreViewContoller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Paramètres",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: framColor,
        leading: IconButton(
            icon: Icon(
              //
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Row(
        children: [
          Flexible(
            flex: 1,
            child: GetBuilder<ParametreViewContoller>(builder: (logic) {
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
    );
  }
}
