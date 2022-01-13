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
  MyAdsApi  _myAdsApi=MyAdsApi();
  DeleteAds _delAds=DeleteAds();

  final storge=Get.find<SecureStorage>();
List<Adverts>adverts=[];
  @override
  void onInit() {
super.onInit();
ads();




  }
  List<AdvertListJson>  ads() {
    _myAdsApi.userId=   Get.find<AccountInfoStorage>().readUserId();
print("_myAdsApi.userId ${_myAdsApi.userId}");
   _myAdsApi.getList(filters: Filter.data).then((value){
     MyAdsJson myAdsJson=MyAdsJson();
     myAdsJson=value;
     adverts=myAdsJson.eEmbedded.adverts;

update();
  });
 }
delads(int i){
  _delAds.id=i;
    _delAds.delPost( ).then((value) {
      print(value);
    });
    update();
}
}