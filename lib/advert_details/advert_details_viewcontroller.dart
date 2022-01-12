import 'package:afariat/networking/api/advert_details_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertDetailsViewcontroller extends GetxController {
  AdvertDetails advert;

  bool loading = true;
  AdvertDetailsApi _advertDetailsApi = AdvertDetailsApi();

  getAdvertDetails(int id) {
    _advertDetailsApi.advertTypeId = id;
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

  showd(context) {
    // Get.defaultDialog(
    //     title: "Contacter l'annonceur par e_mail", confirm: confirmBtn(),cancel: cancelBtn(),
    //
    //     backgroundColor: Colors.white,
    //     titleStyle: TextStyle(color: Colors.orange),
    //     middleTextStyle: TextStyle(color: Colors.orange),
    //     textConfirm: "Confirm",
    //     textCancel: "Cancel",
    //     cancelTextColor: Colors.white,
    //     confirmTextColor: Colors.white,
    //     buttonColor: Colors.orange,
    //   //  barrierDismissible: false,
    //     radius: 10,
    //     content:SingleChildScrollView (
    //       child: Container(
    //         child: Column(
    //           children: [//Text("Contacter l'annonceur par e_mail"),
    //            TextField(  maxLines: 4, ),
    //           ],
    //         ),
    //       ),
    //     )
    // );
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            width: double.infinity,
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  color: Colors.orange,
                  padding: EdgeInsets.all(8),
                  child: Text("Contacter l'annonceur par e_mail",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          content: Container(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextField(
                    maxLines: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back),
                              Text('Back'),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('conform')
                                ],
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget confirmBtn() {
    return ElevatedButton(onPressed: () {}, child: Text("Confirm"));
  }

  Widget cancelBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Cancel"));
  }
}
