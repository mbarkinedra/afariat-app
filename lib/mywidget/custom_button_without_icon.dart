import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';

class CustomButtonWithoutIcon extends StatelessWidget {
  final Color btColor;
  final Color labColor;
  final String label;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final Function function;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                      color: labColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                ),
              ],
            ),
          ),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: framColor, width: 2),
            color: btColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomButtonWithoutIcon(
      {@required this.btColor,
      @required this.function,
      @required this.labColor,
      @required this.label,
      @required this.height,
      this.icon,
      this.iconColor = Colors.white,
      @required this.width,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal});
}
