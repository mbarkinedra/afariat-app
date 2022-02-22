import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final VoidCallback press;
  final bool isNotification;
  final bool hasNotification;
  final IconData iconProfile;

  const ProfileMenu(
      {Key key,
      this.text,
      this.icon,
      this.press,
      this.iconProfile,
      this.hasNotification = false,
      this.isNotification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: buttonColor,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: press,
            child: Row(
              children: [
                Icon(
                  iconProfile,
                  color: Colors.grey,
                ),
                SizedBox(width: 20),
                Expanded(
                    child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (isNotification && hasNotification)
          Positioned(
            left: 8,
            top: 8,
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
                          : " ",style: TextStyle(color: Colors.white),))),
              height: 20,
              width: 20,
            ),
          )
      ],
    );
  }
}
