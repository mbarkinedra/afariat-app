import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TapProfileViewController extends GetxController {
  launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
