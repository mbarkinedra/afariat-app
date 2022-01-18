import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/ads_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_view_controller.dart';
import 'tap_myads_viewcontroller.dart';

class TapMyadsScr extends GetWidget<TapMyadsViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.ads();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mes annonces",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Column(
          children: [
            Expanded(
              child: GetBuilder<TapMyadsViewController>(builder: (logic) {
                return ListView.builder(
                    itemCount: logic.adverts.length,
                    itemBuilder: (context, pos) {
                      return AdsItem(
                        size: _size,
                        adverts: logic.adverts[pos],
                        deleteAds: () {
                          print(logic.adverts[pos].id);
                          controller.deleteAds(logic.adverts[pos].id);
                        },
                        EditAds: () {
                          Get.find<TapPublishViewController>().dataAdverts = true;
                          print(logic.adverts[pos].id);
                          Get.find<TapPublishViewController>()
                              .getEditId(logic.adverts[pos].id);
                          Get.find<HomeViwController>().changeSelectedValue(2);
                        },
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
