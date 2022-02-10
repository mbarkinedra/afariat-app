import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/networking/api/delete_ads.dart';
import 'package:afariat/networking/api/my_ads_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TapMyadsViewController extends GetxController {
  MyAdsApi _myAdsApi = MyAdsApi();
  DeleteAds _deleteAds = DeleteAds();
  final storge = Get.find<SecureStorage>();
  List<Adverts> adverts = [];
  bool deleteData = false;

  @override
  void onInit() {
    super.onInit();
    ads();
  }

  List<AdvertListJson> ads() {
    print("_myAdsApi get add");
    _myAdsApi.userId = Get.find<AccountInfoStorage>().readUserId();
    print("_myAdsApi.userId ${_myAdsApi.userId}");
    _myAdsApi.getList().then((value) {
      MyAdsJson myAdsJson = MyAdsJson();
      myAdsJson = value;
      adverts = myAdsJson.eEmbedded.adverts;

      update();
    });
  }

  deleteAds(int i) {
    deleteData = true;
    update();
    _deleteAds.id = i;
    print(_deleteAds.apiUrl());
    _deleteAds.delPost().then((value) {
      ads();
      deleteData = false;
      update();
    });

    update();
  }
}
