import 'package:afariat/networking/api/notification_api.dart';
import 'package:afariat/networking/json/notification_json.dart';
import 'package:get/get.dart';

class NotificationViewController extends GetxController {
  NotificationApi _notificationApi = NotificationApi();
List<Notification>notification=[];
 RxBool hasnotification=false.obs;
  @override
  void onInit() {
    super.onInit();

    _notificationApi.secureGet().then((value) {
      NotificationJson notificationJson=NotificationJson.fromJson(value.data);
      notification=notificationJson.eEmbedded.notification;
     notification.forEach((element) {
       if(!element.read){
         hasnotification.value=true;
       }
     });
      update();

    });
  }
}
