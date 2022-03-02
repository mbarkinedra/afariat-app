import 'package:afariat/config/filter.dart';
import 'package:afariat/home/tap_chat/chat_user/chat_user_scr.dart';
import 'package:afariat/home/tap_chat/chat_user/chat_user_viewcontroller.dart';
import 'package:afariat/networking/api/advert_details_api.dart';
import 'package:afariat/networking/api/conversations_api.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertDetailsViewcontroller extends GetxController {
  AdvertDetailsJson advert;
  TextEditingController textEditingController = TextEditingController();
  bool loading = true;
  AdvertDetailsApi _advertDetailsApi = AdvertDetailsApi();
  PhotoViewController photoViewController;
  ConvertionsApi _convertionsApi = ConvertionsApi();

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
    photoViewController = PhotoViewController();
  }

  havePhoneNumber() {
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

  Future<void> makeSms(String phoneNumber) async {
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

  showDialogue(context) {
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
                  color: Colors.deepOrange,
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text("Contacter l'annonceur par messagerie",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
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
                    controller: textEditingController,
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
                              Text('retour'),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Filter.data.clear();
                                print("advert.userId   ${advert.userId}");
                                Filter.data["message"] =
                                    textEditingController.text;
                                Filter.data["advert"] = advert.id;
                                _convertionsApi
                                    .securePost(dataToPost: Filter.data)
                                    .then((value) {
                                  Headers responseHeaders = value.headers;
                                  print(responseHeaders.map);
                                  String v = responseHeaders['location'][0];
                                  Get.find<ChatUserViewController>().name =
                                      advert.username;
                                  Get.find<ChatUserViewController>().id =
                                      v.split("/").last;
                                  Get.find<ChatUserViewController>()
                                      .getMessage();
                                  textEditingController.clear();
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatUserScr()));
                                });
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Envoyer')
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
    return ElevatedButton(onPressed: () {}, child: Text("Confirmer"));
  }

// Agrandir photo avec annimation
  displayDialogue(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Center(
                  child: Container(
                      child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        controller: photoViewController,
                        imageProvider: NetworkImage(
                          advert.photos[index].path,
                        ),
                        maxScale: PhotoViewComputedScale.covered * 2,
                        minScale: PhotoViewComputedScale.contained * .8,
                        heroAttributes: PhotoViewHeroAttributes(
                            tag: advert.photos[index].path),
                      );
                    },
                    itemCount: advert.photos.length,
                    loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes,
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          color: Colors.grey[100],
                          child: Icon(
                            Icons.close,
                            color: Colors.deepOrange,
                            size: 30,
                          ))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget cancelBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text("Annuler"));
  }
}
