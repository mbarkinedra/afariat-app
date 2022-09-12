import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/notification/notification_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuEntry extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback press;

  const MenuEntry({
    Key key,
    this.text,
    this.icon,
    this.press,
  }) : super(key: key);

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
                  icon,
                  color: colorText,
                ),
                SizedBox(width: 20),
                Expanded(
                    child: Text(
                  text,
                  style:
                      TextStyle(color: colorGrey, fontWeight: FontWeight.bold),
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colorText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
