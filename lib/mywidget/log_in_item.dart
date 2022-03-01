import 'package:flutter/material.dart';

class LogInItem extends StatelessWidget {
  final String label;
 final TextEditingController textEditingController;
 final String hint;
 final bool obscureText;
 final IconData icon;
 final Function validator;
 final IconButton suffixIcon;

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
        Container( decoration: BoxDecoration(

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
