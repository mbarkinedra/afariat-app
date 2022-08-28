import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_config.dart';
import 'account_view_controller.dart';

class Account extends GetWidget<AccountViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appConfig = AppConfig.of(context);

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
                  "assets/images/"+appConfig.appName+"/logo.png",
                  width: 200,
                  height: 120,
                ),
              ),
              CustomTextFiled(
                color: framColor,
                width: size.width * .8,
                hintText: 'Nom',
                textEditingController: logic.name,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFiled(
                color: framColor,
                textEditingController: controller.email,
                width: size.width * .8,
                hintText: 'e_mail',
                validator: (value) {
                  return controller.validateServer.validate(value, 'email');
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFiled(
                  color: framColor,
                  textEditingController: controller.phone,
                  width: size.width * .8,
                  hintText: 'Numéro de tel',
                  validator: (value) {
                    return controller.validateServer.validate(value, 'phone');
                  }),
              SizedBox(
                height: 10,
              ),
              GetBuilder<LocController>(builder: (logic) {
                return Column(
                  children: [
                    Container(
                      width: size.width * .8,
                      decoration: BoxDecoration(
                          border: Border.all(color: framColor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<RefJson>(
                        underline: SizedBox(),
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Ville"),
                        ),
                        isExpanded: true,
                        value: logic.city,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: logic.updateCity,
                        items: logic.cities
                            .where((element) => element.name != "")
                            .map<DropdownMenuItem<RefJson>>((RefJson value) {
                          return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, right: 8),
                                child: Text(value.name),
                              ));
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
                    : CustomButton1(
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 40, right: 8, left: 8),
                child: CustomButton1(
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
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
