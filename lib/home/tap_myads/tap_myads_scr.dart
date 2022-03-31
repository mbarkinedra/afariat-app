import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/ads_item.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_view_controller.dart';
import 'tap_myads_viewcontroller.dart';

class TapMyAdsScr extends GetWidget<TapMyadsViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.getAllAds();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mes annonces",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: framColor,
        ),
        body: Obx(
          () => Column(
            children: [
              Get.find<NetWorkController>().connectionStatus.value == false
                  ? Container(
                      child: Center(child: CircularProgressIndicator()),
                      height: 50,
                      width: 50,
                    )
                  : SizedBox(),
              Get.find<NetWorkController>().connectionStatus.value
                  ? Expanded(
                      child:
                          GetBuilder<TapMyadsViewController>(builder: (logic) {
                        return controller.getAdsFromServer
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : logic.adverts.length == 0
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 175,
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                              "Vous n'avez déposé aucune annonce",
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
                                              Get.find<HomeViwController>()
                                                  .changeItemFilter(2);
                                            },
                                            labColor: Colors.white,
                                            height: 50,
                                            width: 300,
                                            label:
                                                "Déposer une annonce maintenant",
                                            btColor: buttonColor)
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: RefreshIndicator(onRefresh:controller.onRefreshAds ,
                                      child: ListView.builder(controller: controller.scrollController,
                                          itemCount: logic.adverts.length,
                                          itemBuilder: (context, position) {
                                            return AdsItem(
                                              size: _size,
                                              adverts: logic.adverts[position],
                                              deleteAds: () async {
                                                await showDialog<bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      return CustomDialogueDelete(
                                                        okFunction: () async {
                                                          await controller
                                                              .deleteAds(logic
                                                              .adverts[position]
                                                              .id);
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        text2: " ",
                                                        title: "Confirmation",
                                                        function: () async {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        buttonText2: "Annuler",
                                                        description:
                                                        "Êtes-vous sûr de  vouloir supprimer votre annonce?",
                                                        buttonText: "Ok",
                                                        phone: false,
                                                      );
                                                    });
                                              },
                                              editAds: () {
                                                TapPublishViewController
                                                tapPublishViewController =
                                                Get.find<
                                                    TapPublishViewController>();
                                                tapPublishViewController
                                                    .dataAdverts = true;

                                                tapPublishViewController
                                                    .modifAds.value = true;
                                                tapPublishViewController
                                                    .getAllData(
                                                    logic.adverts[position].id);
                                                Get.find<HomeViwController>()
                                                    .changeItemFilter(2);
                                              },
                                            );
                                            // if(position>logic.adverts.length-1){
                                            //   return Center(child: CircularProgressIndicator());
                                            // }else{
                                            //
                                            // }

                                          }),
                                    ),
                                  );
                      }),
                    )
                  : Expanded(
                      child: Container(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 80,
                            color: framColor,
                          ),
                          Text(
                            "Pas de connexion internet",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorText),
                          ),
                        ],
                      )),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
