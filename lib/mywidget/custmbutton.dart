import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color btcolor;
  final Color labcolor;
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
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: labcolor, fontSize: fontSize, fontWeight: fontWeight),
                ),SizedBox(width: 50,),
                if(icon!=null)Icon(icon,color: Colors.white,)

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

  CustomButton(
      {@required this.btcolor,this.icon,
        @required this.function,
        @required this.labcolor,
        @required this.label,
        @required this.height,
        @required this.width,
        this.fontSize = 16,
        this.fontWeight = FontWeight.normal});
}
