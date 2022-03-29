import 'package:afariat/config/AccountInfoStorage.dart';
import 'package:afariat/config/filter.dart';
import 'package:afariat/controllers/network_controller.dart';
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

  onDeleteNotifications({index, int id}) {
    notifications.remove(index);

    deleteNotificationApi.id = id.toString();
    deleteNotificationApi.deleteData().then((value) {
      update();
    });
    Get.snackbar("", "Votre notification est supprimé");
  }

  readNotification(int id) {
    PutNotificationApi putNotificationApi = PutNotificationApi();
    putNotificationApi.id = id.toString();
    putNotificationApi.putData(dataToPost: Filter.data).then((value) {
      getAllNotification();
    });
  }

  @override
  void onInit() {
    super.onInit();
    if(Get.find<NetWorkController>().connectionStatus.value){
    if (Get.find<AccountInfoStorage>().readUserId() != null) {
      getAllNotification();
    }}else{
      
    }
  }

  getAllNotification() {
    _notificationApi.secureGet().then((value) {
      NotificationJson notificationJson = NotificationJson.fromJson(value.data);
      notifications = notificationJson.eEmbedded.notification;
      notifications.forEach((element) {
        if (!element.read) {
          hasNotification.value = true;
        }
      });
      update();
    });

    _countNotificationApi.getData(Filter.data).then((value) {
      notifCount.value = value.data["totalUnread"];

    });
  }
}
