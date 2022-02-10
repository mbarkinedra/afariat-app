import 'package:afariat/config/filter.dart';
import 'package:afariat/networking/api/count_notification_api.dart';
import 'package:afariat/networking/api/delete_notification_api.dart';
import 'package:afariat/networking/api/notification_api.dart';
import 'package:afariat/networking/api/put_notification_api.dart';
import 'package:afariat/networking/json/notification_json.dart';
import 'package:get/get.dart';

class NotificationViewController extends GetxController {
  NotificationApi _notificationApi = NotificationApi();
  DeleteNotificationApi deleteNotificationApi = DeleteNotificationApi();
  CountNotificationApi _countNotificationApi = CountNotificationApi();

  List<Notification> notifications = [];
  RxBool hasNotification = false.obs;
  RxInt notifCount = 0.obs;

  onDeleteNotifications({int index, int id}) {
    notifications.removeAt(index);

    deleteNotificationApi.id = id.toString();
    deleteNotificationApi.deleteData().then((value) {
      print("Votre notification est supprimé");
     // update();
    });
    // update( );
    Get.snackbar("", "Votre notification est supprimé");
  }

  readNotification(int id) {
    PutNotificationApi putNotificationApi = PutNotificationApi();
    putNotificationApi.id = id.toString();
    putNotificationApi.putData(dataToPost: Filter.data).then((value) {
      print("uuuuuuuuuuuuuuuuuuuuuu$value");

      getAllNotification();
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAllNotification();
  }

  getAllNotification() {
    _notificationApi.secureGet().then((value) {
      NotificationJson notificationJson = NotificationJson.fromJson(value.data);
      notifications = notificationJson.eEmbedded.notification;
      print("tttttttttttttttttttt${notificationJson.eEmbedded.notification}");

      notifications.forEach((element) {
        if (!element.read) {
          hasNotification.value = true;
        }
      });
      update();
    });

    _countNotificationApi.getdata(Filter.data).then((value) {
      notifCount.value = value.data["totalUnread"];
      print("totalUnread$value");
    });
  }
}
