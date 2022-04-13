import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/model/filter.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/count_notification_api.dart';
import 'package:afariat/networking/api/delete_notification_api.dart';
import 'package:afariat/networking/api/notification_api.dart';
import 'package:afariat/networking/api/put_notification_api.dart';
import 'package:afariat/networking/json/notification_json.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';

class NotificationViewController extends GetxController {
  NotificationApi _notificationApi = NotificationApi();
  DeleteNotificationApi deleteNotificationApi = DeleteNotificationApi();
  CountNotificationApi _countNotificationApi = CountNotificationApi();
  material.ScrollController scrollController = material.ScrollController();
  List<Notification> notifications = [];
  RxBool hasNotification = false.obs;
  RxInt notifCount = 0.obs;
  int page = 0;
  bool loadMoreData = true;

  ///Function for delete notifications
  onDeleteNotifications({index, int id}) {
    notifications.remove(index);

    deleteNotificationApi.id = id.toString();
    deleteNotificationApi.deleteData().then((value) {
      update();
    });
    Get.snackbar("", "Votre notification est supprimé");
  }

  /// Function for refrech a new notifications
  Future<void> onRefreshNotification() async {
    getAllNotification();
  }

  /// Function for read a new notifictions
  readNotification(int id) {
    PutNotificationApi putNotificationApi = PutNotificationApi();
    putNotificationApi.id = id.toString();
    putNotificationApi.putData(dataToPost: Filter.data).then((value) {
      notifications.clear();
      getAllNotification();
    });
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.find<NetWorkController>().connectionStatus.value) {
      if (Get.find<AccountInfoStorage>().readUserId() != null) {
        getAllNotification();
      }
    } else {}
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent) {
          onSwipeUp();
        } else if (scrollController.offset >=
            scrollController.position.minScrollExtent) {
          onSwipeDown();
        }
      }
    });
  }

  getAllNotification() {
    _notificationApi.secureGet().then((value) {
      NotificationJson notificationJson = NotificationJson.fromJson(value.data);
      List<Notification> notification = notificationJson.eEmbedded.notification;
      if (notification.length < 20) {
        loadMoreData = false;
      }
      notifications.addAll(notification);
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

  void onSwipeUp() {
    page++;
    _notificationApi.page = page;
    getAllNotification();
  }

  void onSwipeDown() {
    page = 0;
    _notificationApi.page = page;
    getAllNotification();
  }
}
