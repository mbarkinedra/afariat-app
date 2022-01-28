import 'package:afariat/networking/api/notification_api.dart';
import 'package:afariat/networking/json/notification_json.dart';
import 'package:get/get.dart';

class NotificationViewController extends GetxController {
  NotificationApi _notificationApi = NotificationApi();
List<Notification>notifications=[];
 RxBool hasnotification=false.obs;

  onDeleteNotifications(int index ){


   // update( );
    Get.snackbar("","Votre notification est supprimé" );

  }
  @override
  void onInit() {
    super.onInit();

    _notificationApi.secureGet().then((value) {
      NotificationJson notificationJson=NotificationJson.fromJson(value.data);
      notifications=notificationJson.eEmbedded.notification;
     notifications.forEach((element) {
       if(!element.read){
         hasnotification.value=true;
       }
     });
      update();

    });
  }
}
