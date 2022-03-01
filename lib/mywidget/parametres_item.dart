import 'package:flutter/material.dart';

class ParametresItem extends StatelessWidget {
 final String label;
 final TextEditingController textEditingController;
 final String hint;
 final bool obscureText;
 final IconData icon;
 final Function validator;
 final IconButton suffixIcon;
  final Color iconcolor;
  ParametresItem(
      {this.label,
        this.textEditingController,
        this.hint,
        this.obscureText = false,
        this.icon,
        this.validator,
        this.suffixIcon,this.iconcolor});

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
                iconColor: Colors.deepOrange,
                hintText: hint,
                suffixIcon: suffixIcon),
          ),
        ),
      ],
    );
  }
}
