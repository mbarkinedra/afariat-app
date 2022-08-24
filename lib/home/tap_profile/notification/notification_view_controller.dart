import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/networking/api/notification_api.dart';
import 'package:afariat/networking/json/notification_json.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';

class NotificationViewController extends GetxController {
  NotificationApi _notificationApi = NotificationApi();
  material.ScrollController scrollController = material.ScrollController();
  List<Notification> notifications = [];
  RxBool hasNotification = false.obs;
  RxInt notifCount = 0.obs;
  int page = 0;
  bool loadMoreData = true;

  ///Function for delete notifications
  onDeleteNotifications({index, int id}) {
    _notificationApi.deleteResource(id.toString()).then((value) {
      notifications.remove(index);
      update();
    });
    Get.snackbar("", "Notification supprimée avec succès");
  }

  /// Function for refrech a new notifications
  Future<void> onRefreshNotification() async {
    getAllNotification();
  }

  /// Function for read a new notifictions
  readNotification(int id) {
    _notificationApi.id = id.toString();
    _notificationApi.putResource(dataToPost: {"id": id}).then((value) {
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
    } else {
      //do nothing, user is not logged in
    }
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
      if (value == null) {
        return null;
      }
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

    _notificationApi.getUnread().then((value) {
      if(value != null){
        notifCount.value = value.data["totalUnread"];
      }
    });
  }

  void clearList() {
    notifications.clear();
    update();
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
