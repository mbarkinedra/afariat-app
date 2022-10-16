import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInItem extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  final String hint;
  final bool obscureText;

  final IconData icon;
  final Function validator;
  final Function onChanged;
  final IconButton suffixIcon;
  RxBool showSuffixIcon = true.obs;
  bool dynamicSuffixIcon = false;

  LogInItem(
      {Key key,
      bool clearText = false,
      this.label,
      this.textEditingController,
      this.hint,
      this.obscureText = false,
      this.icon,
      this.validator,
      this.suffixIcon,
      this.onChanged})
      : super(key: key) {
    dynamicSuffixIcon = clearText;
    _setSuffixIcon();
  }

  _setSuffixIcon() {
    if (dynamicSuffixIcon == true) {
      if (textEditingController.text.isEmpty) {
        showSuffixIcon.value = false;
      } else {
        showSuffixIcon.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: textEditingController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorMaxLines: 3,
          icon: Icon(icon),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          suffixIcon: Obx(() => showSuffixIcon.value == true
              ? (suffixIcon ?? SizedBox())
              : const SizedBox()),
        ),
        onChanged: (val) {
          _setSuffixIcon();
          onChanged;
        },
      ),
    );
  }
}
