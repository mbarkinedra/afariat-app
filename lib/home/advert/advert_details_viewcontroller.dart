import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../networking/api/advert_details_api.dart';
import '../../networking/api/conversations_api.dart';
import '../../networking/json/advert_details_json.dart';

class AdvertDetailsViewController extends GetxController {
  final AdvertDetailsApi _api = AdvertDetailsApi();
  final ConversationsApi _conversationApi = ConversationsApi();
  PhotoViewController photoViewController;
  RxBool loading = true.obs;
  RxBool isSendingMsg = false.obs;
  AdvertDetailsJson advert;
  String advertId;

  final messageController = TextEditingController(
      text: 'Bonjour, \nVotre bien m\'intéresse, est-il toujours disponible ?');

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<AdvertDetailsJson> fetchAdvert() async {
    await _api.getAdvert(advertId).then((value) {
      advert = value;
    });
    loading.value = false;
    return advert;
  }

  @override
  void dispose() {
    photoViewController.dispose();
    //messageController.dispose();
    super.dispose();
  }

  Future<void> makeCallOrSms(String phoneNumber, String scheme) async {
    // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
    // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
    // such as spaces in the input, which would cause `launch` to fail on some
    // platforms.
    final Uri launchUri = Uri(
      scheme: scheme,
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<bool> sendMessage() async {
    bool success = false;
    isSendingMsg.value = true;
    await _conversationApi.securePost(dataToPost: {
      'message': messageController.text,
      'advert': advert.id,
    }).then((value) {
      success = value.statusCode == 201;
    });
    isSendingMsg.value = false;
    return success;
  }
}
