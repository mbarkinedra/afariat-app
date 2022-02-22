import 'package:flutter/material.dart';

class LogInItem extends StatelessWidget {
  String label;
  TextEditingController textEditingController;
  String hint;
  bool obscureText;
  IconData icon;
  Function validator;
  IconButton suffixIcon;

  LogInItem(
      {this.label,
      this.textEditingController,
      this.hint,
      this.obscureText = false,
      this.icon,
      this.validator,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label),
        Container( width: MediaQuery.of(context).size.width*.7, decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange, width: 2),
            borderRadius: BorderRadius.circular(15)),
          child: TextFormField(
            controller: textEditingController,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
                icon: Icon(icon),
                border: InputBorder.none,
                hintText: hint,
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    );
  }
}
