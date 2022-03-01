import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/ads_item.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_view_controller.dart';
import 'tap_myads_viewcontroller.dart';

class TapMyAdsScr extends GetWidget<TapMyadsViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.ads();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mes annonces",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.deepOrange,
        ),
        body: GetBuilder<TapMyadsViewController>(builder: (logic) {
          return logic.adverts.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 175,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text("Vous n'avez déposé aucune annonce",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey)),
                      ),
                      SizedBox(
                        height: _size.height * .20,
                      ),
                      CustomButtonWithoutIcon(
                        function: () {
                          Get.find<HomeViwController>().changeSelectedValue(2);
                        },
                        labColor: Colors.white,
                        height: 50,
                        width: 300,
                        label: "Déposer une annonce maintenant",
                        btColor: Colors.deepOrange,
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ListView.builder(
                      itemCount: logic.adverts.length,
                      itemBuilder: (context, pos) {
                        return AdsItem(
                          size: _size,
                          adverts: logic.adverts[pos],
                          deleteAds: () {
                            print(logic.adverts[pos].id);
                            controller.deleteAds(logic.adverts[pos].id);
                          },
                          editAds: () {
                            Get.find<TapPublishViewController>().dataAdverts =
                                true;
                            print(logic.adverts[pos].id);
                            Get.find<TapPublishViewController>()
                                .getModifAds(logic.adverts[pos].id);
                            Get.find<HomeViwController>()
                                .changeSelectedValue(2);
                          },
                        );
                      }),
                );
        }),
      ),
    );
  }
}
