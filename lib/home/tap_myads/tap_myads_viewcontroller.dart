import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/storage/storage.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/delete_ads.dart';
import 'package:afariat/networking/api/my_ads_api.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapMyadsViewController extends GetxController {
  MyAdsApi _myAdsApi = MyAdsApi();
  DeleteAds _deleteAds = DeleteAds();
  final storge = Get.find<SecureStorage>();
  List<Adverts> adverts = [];
  bool deleteData = false;
  bool getAdsFromServer = false;
  ScrollController scrollController = ScrollController();

  Future<void> onRefreshAds() async {
    getAllAds();
  }

  @override
  void onInit() {
    super.onInit();
    getAllAds();
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          onSwipeUp();
        }
      }
    });
  }

  scrollUpAds() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        1,
        curve: Curves.bounceOut,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  getAllAds() {
    if (Get.find<NetWorkController>().connectionStatus.value &&
        Get.find<AccountInfoStorage>().readUserId() != null) {
      _myAdsApi.userId = Get.find<AccountInfoStorage>().readUserId();
      getAdsFromServer = true;
      _myAdsApi.getList().then((value) {

        MyAdsJson myAdsJson = MyAdsJson();
        myAdsJson = value;
        adverts = myAdsJson.eEmbedded.adverts;

        getAdsFromServer = false;
        update();
      });
    }
  }

  Future deleteAds(int i) async {
    deleteData = true;
    update();
    _deleteAds.id = i;

    await _deleteAds.deleteAdverts().then((value) {
      getAllAds();
      deleteData = false;

      update();
    });
    update();
  }

  Future<void> onSwipeUp() async {}
}
