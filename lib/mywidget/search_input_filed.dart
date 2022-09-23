import 'package:flutter/material.dart';

import '../config/utility.dart';

class SearchInputFiled extends StatelessWidget {
  final TextEditingController textEditingController;
  final Color color;
  final double width;
  final bool obscureText;
  final String hintText;
  final Function onchange;
  final Function validator;
  final double padding;
  final int maxLines = 1;
  final int maxLength;

  const SearchInputFiled({
    @required this.textEditingController,
    @required this.hintText,
    this.onchange,
    @required this.color,
    this.padding = 4.0,
    @required this.width,
    this.validator,
    this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: colorGrey,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: TextFormField(
            onChanged: onchange,
            maxLines: maxLines,
            keyboardType: TextInputType.text,
            obscureText: obscureText,
            validator: validator,
            controller: textEditingController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: InputBorder.none,
              hintText: hintText,
            ),
            maxLength: maxLength,
          ),
        ));
  }
}
