import 'package:flutter/material.dart';

class LogInItem extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String hint;
  final bool obscureText;
  final IconData icon;
  final Function validator;
  final Function onChanged;
  final IconButton suffixIcon;

  const LogInItem(
      {Key key, this.label,
      this.textEditingController,
      this.hint,
      this.obscureText = false,
      this.icon,
      this.validator,
      this.suffixIcon,
      this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          suffixIcon: suffixIcon,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
