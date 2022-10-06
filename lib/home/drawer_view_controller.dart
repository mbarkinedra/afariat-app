import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerViewController extends GetxController {
  launchURL(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(
      _url,
    )) {
      throw 'Could not launch $url';
    }
  }
}
