import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../networking/api/advert_details_api.dart';
import '../../networking/json/advert_details_json.dart';

class AdvertDetailsViewController extends GetxController {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final AdvertDetailsApi _api = AdvertDetailsApi();
  PhotoViewController photoViewController;
  RxBool loading = false.obs;
  AdvertDetailsJson advert;

  @override
  void onInit() async {
    String id = Get.parameters['id'];
    if (id != null) {
      fetchData(id);
    }

    super.onInit();
  }

  fetchData(String id) async {
    loading.value = true;
    _api.advertTypeId = id;
    await _api.getResource().then((value) {
      advert = value;
    });
    loading.value = false;
  }
}
