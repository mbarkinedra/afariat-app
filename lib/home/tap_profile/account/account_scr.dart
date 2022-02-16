import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_view_controller.dart';

class Account extends GetWidget<AccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      child: SingleChildScrollView(
        child: GetBuilder<AccountViewController>(builder: (logic) {
          return Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/Splash_2.png",
                  width: 120,
                  height: 120,
                ),
              ),
              CustomTextFiled(
                color: framColor,
                width: size.width * .8,
                hintText: 'name',
                textEditingController: logic.name,
              ),
              CustomTextFiled(
                color: framColor,
                textEditingController: controller.email,
                width: size.width * .8,
                hintText: 'email',
                validator: (value) {
                  return controller.validateServer.validator(value, 'email');
                },
              ),
              CustomTextFiled(
                  color: framColor,
                  textEditingController: controller.phone,
                  width: size.width * .8,
                  hintText: 'phone',
                  validator: (value) {
                    return controller.validateServer.validator(value, 'phone');
                  }),
              GetBuilder<LocController>(builder: (logic) {
                return Column(
                  children: [
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<RefJson>(
                        underline: SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("City"),
                        ),
                        isExpanded: true,
                        value: logic.city,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: logic.updateCity,
                        items: logic.cities
                            .map<DropdownMenuItem<RefJson>>((RefJson value) {
                          return DropdownMenuItem<RefJson>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              }),
              GetBuilder<AccountViewController>(builder: (logic) {
                return logic.updateData
                    ? CircularProgressIndicator()
                    : CustomButton(
                        height: 50,
                        label: "Mettre à jour",
                        icon: Icons.refresh_outlined,
                        iconcolor: Colors.white,
                        labcolor: Colors.white,
                        width: size.width * .8,
                        btcolor: framColor,
                        function: () {
                          controller.updateUserData();
                        },
                      );
              }),
              CustomButton(
                height: 50,
                label: "Annuler",
                icon: Icons.arrow_back_rounded,
                labcolor: Colors.white,
                iconcolor: Colors.white,
                width: size.width * .8,
                btcolor: framColor,
                function: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
