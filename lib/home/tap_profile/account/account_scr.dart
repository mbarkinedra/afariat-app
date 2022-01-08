import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_view_controller.dart';

class Account extends GetWidget<AccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            maxRadius: 50,
            backgroundImage: NetworkImage(
                "https://www.sleeptasticsolutions.com/wp-content/uploads/2018/05/happy-kids-1.jpg"),
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'name',
            textEditingController: controller.name,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'email',
            textEditingController: controller.email,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'phone',
            textEditingController: controller.phone,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'add',
            textEditingController: controller.phone,
          ),
          CustomButtonWithoutIcon(
            height: 50,
            label: "send",
            width: size.width * .8,
            btcolor: framColor,
            function: () {},
          )
        ],
      ),
    );
  }
}
