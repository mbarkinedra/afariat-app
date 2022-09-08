import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
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
          "Mot de passe oublié",
        ),
        backgroundColor:framColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Indiquez votre email pour rénitialisez votre mot de passe",
                style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black45),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextFiled(
            color: framColor,
            width: size.width * .8,
            hintText: 'Saisissez votre email',
            textEditingController: controller.password,
          ),
          SizedBox(height: 50,),
          CustomButtonWithoutIcon(
            height: 50,
            label: "Envoyer",
            labColor: Colors.white,
            width: size.width * .5,
            btColor: buttonColor,
            function: () {
              controller.forgotPassword();
            },
          ),
        ],
      ),
    );
  }
}
