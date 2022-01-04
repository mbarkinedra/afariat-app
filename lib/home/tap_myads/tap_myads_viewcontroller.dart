import 'package:afariat/config/filter.dart';
import 'package:afariat/config/storage.dart';
import 'package:afariat/networking/api/my_ads_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afariat/config/AccountInfoStorage.dart';

class TapMyadsViewController extends GetxController {
  MyAdsApi _myAdsApi = MyAdsApi();
  List<Adverts> adverts = [];

  @override
  void onInit() {
    super.onInit();
    ads();
  }

  Future ads() async {
    Filter.Id = await AccountInfoStorage.readUserId();
    print(Filter.Id);
    _myAdsApi.getList().then((value) {
      MyAdsJson myAdsJson = MyAdsJson();
      myAdsJson = value;
      adverts = myAdsJson.eEmbedded.adverts;
      Filter.Id = null;
      update();
    });
  }
}
