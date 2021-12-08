
import 'package:flutter/material.dart';

class LogInItem extends StatelessWidget {
  String label;
  TextEditingController textEditingController;
String hint;
 bool obscureText ;

IconData icon;
  LogInItem({this.label, this.textEditingController, this.hint,
    this.obscureText=false,this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: textEditingController,
          obscureText:obscureText , decoration: InputDecoration(icon: Icon(icon),
    border: InputBorder.none,
    hintText: hint,
    ),
    ),

      ],
    );
  }
}
