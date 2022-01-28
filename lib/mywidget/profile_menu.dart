import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final VoidCallback press;
  final bool isnotfication;
  final bool hasnotfication;
  final IconData iconProfile;

  const ProfileMenu(
      {Key key,
      this.text,
      this.icon,
      this.press,
      this.iconProfile,
      this.hasnotfication = false,
      this.isnotfication = false})
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
                // SvgPicture.asset(
                //   icon,
                //   color: buttonColor,
                //   width: 22,
                // ),
                Icon(iconProfile),
                SizedBox(width: 20),
                Expanded(child: Text(text)),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
        if (isnotfication && hasnotfication)
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              height: 20,
              width: 20,
            ),
          )
      ],
    );
  }
}
