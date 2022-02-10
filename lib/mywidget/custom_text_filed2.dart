import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';

class CustomTextFiled2 extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color color;
  final double width;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  Function onchange;
  Function validator;
  double padding;
  int maxLines;

  CustomTextFiled2(
      {@required this.textEditingController,
      @required this.hintText,
      this.onchange,
      @required this.color,
      this.padding = 4.0,
      @required this.width,
      this.validator,
      this.icon,
      this.maxLines,
      this.obscureText = false,
      @required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: width, //height: 50,

          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextFormField(
                  onChanged: onchange,
                  maxLines: maxLines,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  validator: validator,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(icon),
                    hintText: hintText,
                  ),
                ),
              ),
              Text(
                "DT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                width: 4,
              )
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
