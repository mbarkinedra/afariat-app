import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification_view_controller.dart';

class NotificationSrc extends GetWidget<NotificationViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: framColor,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<NotificationViewController>(builder: (logic) {
        return RefreshIndicator(
          onRefresh: controller.onRefreshNotification,
          child: logic.notifications.isEmpty
              ? Container(
                  child: Center(
                    child: Text(" Pas des notifications",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              : ListView.builder(
                  controller: controller.scrollController,
                  itemCount: logic.notifications.length + 1,
                  itemBuilder: (context, pos) {
                    //

                    if (logic.notifications.length - 1 < pos) {
                      return controller.loadMoreData
                          ? Container(
                              height: 50,
                              width: 50,
                              child: Center(child: CircularProgressIndicator()))
                          : SizedBox();
                    } else {
                      final item = logic.notifications[pos];
                      return GestureDetector(
                        onTap: () {
                          logic.readNotification(logic.notifications[pos].id);
                        },
                        child: Dismissible(
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          key: Key(item.id.toString()),
                          onDismissed: (direction) {
                            logic.onDeleteNotifications(
                                id: item.id, index: item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          logic.notifications[pos].createdAt
                                              .substring(11, 16),
                                          style: TextStyle(
                                              fontWeight:
                                                  logic.notifications[pos].read
                                                      ? FontWeight.normal
                                                      : FontWeight.bold),
                                        ),
                                        Text(
                                          logic.notifications[pos].createdAt
                                              .substring(0, 10),
                                          style: TextStyle(
                                              fontWeight:
                                                  logic.notifications[pos].read
                                                      ? FontWeight.normal
                                                      : FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        logic.notifications[pos].message,
                                        style: TextStyle(
                                            fontWeight:
                                                logic.notifications[pos].read
                                                    ? FontWeight.normal
                                                    : FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
        );
      }),
    );
  }
}
