import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/my_ads_api.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapMyAdsViewController extends GetxController {
 MyAdsApi _myAdsApi = MyAdsApi();
  List<Adverts> adverts = [];
  bool deleteData = false;
  bool getAdsFromServer = false;
  ScrollController scrollController = ScrollController();
  int loadOrScrollAds = 0;

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
      _myAdsApi.id = Get.find<AccountInfoStorage>().readUserId();
      getAdsFromServer = true;
      _myAdsApi.getResource().then((value) {
        MyAdsJson myAdsJson = MyAdsJson();
        myAdsJson = value;
        adverts = myAdsJson.eEmbedded.adverts;

        getAdsFromServer = false;
        update();
      });
    }
  }
  /// Delete Ads From List
  Future deleteAds(int id) async {
    deleteData = true;
    update();
   // _advertApii.id = i;

    await _myAdsApi.deleteResource(id.toString()).then((value) {
      getAllAds();
      deleteData = false;

      update();
    });
    update();
  }

  Future<void> onSwipeUp() async {}

  /// Scroll Up List Of Ads
  loadOrScrollUpAds() {
    //  if (value == 1) {
    loadOrScrollAds++;
    if (loadOrScrollAds == 1) {
      scrollUpAds();
    } else {
      if (scrollController.hasClients) {
        if (scrollController.offset != 1) {
          scrollUpAds();
          loadOrScrollAds = 1;
        } else {
          loadOrScrollAds = 0;
        }
      }
    }
    /*} else {
      loadOrScrollAds = 0;
    }*/
  }
}
