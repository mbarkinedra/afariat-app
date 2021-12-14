import 'package:afariat/networking/api/advert_details_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool havephonenumber() {
    // bool vall=false;
    // if(!loading&&advert!=null) {
    //   if(advert.mobilePhoneNumber!=null){
    //     print(advert.mobilePhoneNumber);
    //     vall=true;
    //   }
    //
    //
    // }
    //bool vall=false;
    if (!loading && advert != null) {
      return advert.showPhoneNumber;
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  Future<void> makesms(String phoneNumber) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
