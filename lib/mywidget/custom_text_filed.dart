import 'package:afariat/config/utilitie.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color color;
  final double width;
  final IconData  icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  Function onchange;
  double padding;
  CustomTextFiled(
      {@required this.textEditingController,@required this.hintText,this.onchange,
        @   required this.color,this.padding=4.0,
        @   required this.width,
        this.icon,
        this.obscureText = false,
        @  required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:   EdgeInsets.all(padding),
        child: Container(
          width: width,height: 50,

          child: TextField( onChanged: onchange,
            obscureText: obscureText,keyboardType: keyboardType,
            controller: textEditingController,
            decoration: InputDecoration(border: InputBorder.none,
                icon: Icon(icon),hintText: hintText,
            ),
          ),
          decoration: BoxDecoration(border: Border.all(color: color),borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
