import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'forgotpassword_view_controller.dart';

class ForgotPassword extends GetWidget<ForgotPasswordViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password ",
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Indiquez votre email pour rénitialisez votre mot de passe.",
              style: TextStyle(fontSize: 15),
            ),
          ),

          // CircleAvatar(maxRadius: 50,
          //   backgroundImage: NetworkImage(
          //       "https://www.sleeptasticsolutions.com/wp-content/uploads/2018/05/happy-kids-1.jpg"),
          // ),

          SizedBox(
            height: 20,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'email',
            textEditingController: controller.password,
          ),
          CustomButtonWithoutIcon(
            height: 50,
            label: "send",
            width: size.width * .8,
            btcolor: framColor,
            function: () {
              controller.restpassword();
            },
          ),

        ],
      ),
    );
  }
}
