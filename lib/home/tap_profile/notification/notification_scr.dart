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
                  itemCount: logic.notification.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        color: logic.notification[pos].read
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
                                    logic.notification[pos].createdAt
                                        .substring(11, 16),
                                    style: TextStyle(
                                        fontWeight: logic.notification[pos].read
                                            ? FontWeight.normal
                                            : FontWeight.bold),
                                  ),
                                  Text(
                                    logic.notification[pos].createdAt
                                        .substring(0, 10),
                                    style: TextStyle(
                                        fontWeight: logic.notification[pos].read
                                            ? FontWeight.normal
                                            : FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  logic.notification[pos].message,
                                  style: TextStyle(
                                      fontWeight: logic.notification[pos].read
                                          ? FontWeight.normal
                                          : FontWeight.bold),
                                ),
                              ),
                            ],
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
