import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/ads_item.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_dialogue_delete.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_routing.dart';
import '../../persistent_tab_manager.dart';
import '../main_view_controller.dart';
import 'myads_view_controller.dart';

class MyAdsView extends GetWidget<MyAdsViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.getAllAds();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Mes annonces",
            style: TextStyle(
                color: colorGrey, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: const Icon(
                //
                Icons.arrow_back_ios,
                color: framColor,
              ),
              onPressed: () {
                PersistentTabManager.changePage(0);
              }),
        ),
        body: Obx(
          () => Column(
            children: [
              Get.find<NetWorkController>().connectionStatus.value == false
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                      height: 50,
                      width: 50,
                    )
                  : const SizedBox(),
              Get.find<NetWorkController>().connectionStatus.value
                  ? Expanded(
                      child: GetBuilder<MyAdsViewController>(builder: (logic) {
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
                                        const Align(
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
                                            function: () =>
                                                Get.toNamed(AppRouting.newAd),
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
                                    child: RefreshIndicator(
                                      onRefresh: controller.onRefreshAds,
                                      child: ListView.builder(
                                          controller:
                                              controller.scrollController,
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
                                                                  .adverts[
                                                                      position]
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
                                                    .getAllData(logic
                                                        .adverts[position].id);
                                                /* Get.find<MainViewController>()
                                                    .changeItemFilter(2);*/
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
                                fontWeight: FontWeight.bold, color: colorText),
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
