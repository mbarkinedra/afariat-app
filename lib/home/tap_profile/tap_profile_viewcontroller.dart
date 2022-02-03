import 'package:afariat/networking/api/notification_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class TapProfileViewController extends GetxController {
  launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
