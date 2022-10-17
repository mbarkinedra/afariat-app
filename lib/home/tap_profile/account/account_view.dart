import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_config.dart';
import '../../../mywidget/information_widget.dart';
import '../../../remote_widget/city_dropdown_src.dart';
import 'account_view_controller.dart';

class AccountView extends GetWidget<AccountViewController> {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var appConfig = AppConfig.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              elevation: 0,
              toolbarHeight: 150,
              backgroundColor: Colors.white,
              foregroundColor: framColor,
              flexibleSpace: Container(
                width: _size.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Color(0xFFFFCCBC),
                      Colors.white,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000),
                        side: const BorderSide(width: 3, color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000.0),
                          child: Image.asset(
                            "assets/images/" + appConfig.appName + "/logo.png",
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: controller.registerFormKey,
                  child: GetBuilder<AccountViewController>(builder: (logic) {
                    return Column(
                      children: [
                        Obx(
                          () => controller.success.isTrue
                              ? InformationWidget(
                                  message:
                                      'Votre profil a été mis à jour avec succès',
                                  backgroundColor: Colors.teal,
                                  iconData: Icons.check_circle,
                                )
                              : const SizedBox(),
                        ),
                        Obx(
                          () => controller.error.isNotEmpty
                              ? InformationWidget(
                                  message: controller.error.value,
                                  foregroundColor: Colors.redAccent,
                                  iconData: Icons.error,
                                )
                              : const SizedBox(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFiled(
                          color: framColor,
                          hintText: 'Prénom ou nom de votre société',
                          textEditingController: controller.firstName,
                          icon: Icons.account_circle,
                          validator: (value) {
                            return controller.validator
                                .validateFirstName(value.toString());
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFiled(
                          color: framColor,
                          hintText: 'Nom',
                          textEditingController: controller.lastName,
                          icon: Icons.account_circle,
                          validator: (value) {
                            return controller.validator
                                .validateLastName(value.toString());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFiled(
                          color: framColor,
                          textEditingController: controller.email,
                          hintText: 'e-mail',
                          icon: Icons.alternate_email,
                          validator: (value) {
                            return controller.validator
                                .validateEmail(value.toString());
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFiled(
                            color: framColor,
                            textEditingController: controller.phone,
                            hintText: 'Numéro de tel',
                            icon: Icons.phone,
                            validator: (value) {
                              return controller.validator
                                  .validatePhone(value.toString());
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: framColor, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: CityDropdown(
                                  controller.cityDropdownViewController),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          title: const Text(
                            'Compte PRO',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: Obx(
                            () => CupertinoSwitch(
                              value: controller.isPro.value,
                              activeColor: framColor,
                              onChanged: (v) {
                                controller.isPro.value = v;
                              },
                            ),
                          ),
                        ),
                        Obx(
                          () => controller.isLoading.isTrue
                              ? const CircularProgressIndicator()
                              : CustomButton1(
                                  height: 50,
                                  label: "Mettre à jour",
                                  icon: Icons.refresh_outlined,
                                  iconcolor: Colors.white,
                                  labcolor: Colors.white,
                                  btcolor: framColor,
                                  function: () async {
                                    controller.validator.validationType = false;
                                    if (!controller.registerFormKey.currentState
                                        .validate()) {
                                      return;
                                    }
                                    controller.validator.validationType = true;
                                    await controller.save();
                                  },
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 40, right: 8, left: 8),
                          child: CustomButton1(
                            height: 50,
                            label: "Annuler",
                            icon: Icons.arrow_back_rounded,
                            labcolor: Colors.black,
                            iconcolor: Colors.black,
                            btcolor: Colors.grey[200],
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
