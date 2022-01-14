import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_view_controller.dart';

class Account extends GetWidget<AccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: GetBuilder<AccountViewController>(builder: (logic) {
        return Column(
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
              textEditingController: logic.name,
            ),
            CustomTextFiled(
              color: framColor,
              width: size.width * .8,
              hintText: 'email',
              textEditingController: logic.email,
            ),
            CustomTextFiled(
              color: framColor,
              width: size.width * .8,
              hintText: 'phone',
              textEditingController: logic.phone,
            ),
            GetBuilder<LocController>(builder: (logic) {
              return Column(
                children: [
                  Container(
                    width: size.width * .8,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepOrangeAccent),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<RefJson>(
                      hint: Text("City"),
                      isExpanded: true,
                      value: logic.citie,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updatecitie,
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
            CustomButtonWithoutIcon(
              height: 50,
              label: "send",
              width: size.width * .8,
              btcolor: framColor,
              function: () {
                controller.updateUserData();
              },
            )
         ,  CustomButtonWithoutIcon(
              height: 50,
              label: "back",
              width: size.width * .8,
              btcolor: framColor,
              function: () {
                Navigator.pop(context);
              },
            ) ],
        );
      }),
    );
  }
}
