import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationMenu extends StatelessWidget {
  final String icon;
  final VoidCallback press;
  final bool isNotification;
  final bool hasNotification;
  final IconData iconProfile;
final int size;
  const NotificationMenu(
      {Key key,
        this.icon,
        this.size,
        this.press,
        this.iconProfile,
        this.hasNotification = false,
        this.isNotification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: press,
          child: Row(
            children: [
              Icon(
                iconProfile,
                size: 30,
                color:ColorGrey
              ),
              SizedBox(width: 10),

            ],
          ),
        ),
        if (isNotification && hasNotification)
          Positioned(
            left: 30,
            top: 5,
            child: Container(
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Center(
                  child: Obx(() => Text(
                    Get.find<NotificationViewController>().notifCount.value >
                        0
                        ? Get.find<NotificationViewController>()
                        .notifCount
                        .value
                        .toString()
                        : " ",style: TextStyle(color: Colors.white,fontSize: 12),))),
              height: 15,
              width: 15,
            ),
          )
      ],
    );
  }
}
