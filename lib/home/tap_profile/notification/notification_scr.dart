import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notification_view_controller.dart';

class NotificationSrc extends GetWidget<NotificationViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<NotificationViewController>(builder: (logic) {
              return ListView.builder(
                  itemCount: logic.notifications.length,
                  itemBuilder: (context, pos) {
                    final item = logic.notifications[pos];
                    return Dismissible(
                      background: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      key: Key(item.id.toString()),
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        // if (direction == DismissDirection.endToStart) {
                        //   print(direction == DismissDirection.endToStart);
                        logic.onDeleteNotifications(pos);
                        //     }

                        // Then show a snackbar.
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          color: logic.notifications[pos].read
                              ? Colors.white
                              : Colors.green,
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
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
