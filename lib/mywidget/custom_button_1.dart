import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final Color btcolor;
  final Color labcolor;
  final Color iconcolor;
  final String label;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final Function function;
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
                if (icon != null)
                  Icon(
                    icon,
                    color: iconcolor,
                  ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  label,
                  style: TextStyle(
                      color: labcolor,
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
            color: btcolor,
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

  CustomButton1(
      {@required this.btcolor,
      this.icon,
      this.iconcolor,
      @required this.function,
      @required this.labcolor,
      @required this.label,
      @required this.height,
      @required this.width,
      this.fontSize = 16,
      this.fontWeight = FontWeight.normal});
}
