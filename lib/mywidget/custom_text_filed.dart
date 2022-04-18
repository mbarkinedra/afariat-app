import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color color;
  final double width;
  final bool obscureText;
  final String hintText;
  final Function onchange;
  final Function validator;
  final double padding;
  final int maxLines;
  final int maxLength;

  CustomTextFiled({
    @required this.textEditingController,
    @required this.hintText,
    this.onchange,
    @required this.color,
    this.padding = 4.0,
    @required this.width,
    this.validator,
    this.maxLines,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: onchange,
          maxLines: maxLines,
          obscureText: obscureText,
          validator: validator,
          controller: textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          maxLength: maxLength,
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
