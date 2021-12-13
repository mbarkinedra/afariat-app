import 'package:afariat/networking/api/advert_details_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AdvertDetailsViewcontroller extends GetxController {
  AdvertDetails advert;

  bool loading = true;
  AdvertDetailsApi _advertDetailsApi = AdvertDetailsApi();

  getAdvertDetails() {
    _advertDetailsApi.getList().then((value) {
      advert = value;

      loading = false;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}
