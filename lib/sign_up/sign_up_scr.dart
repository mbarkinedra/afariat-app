import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/sign_up/sign_up_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScr extends GetWidget<SignUpViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            right: 16.0, left: 16.0, top: 16.0, bottom: 50),
        child: Form(
          key: controller.registerFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Création de compte",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _size.height * .02,
                ),
                Text(
                    "Toutes vos annonces et vos favoris à un seul endroit, c'est gratuit !"),
                SizedBox(
                  height: _size.height * .03,
                ),
                LogInItem(
                    key: Key('name'),
                    textEditingController: controller.name,
                    label: "Nom & prénom",
                    hint: "Nom et prénom ou nom de société",
                    icon: Icons.account_circle,
                    validator: controller.validator.validateName),
                SizedBox(
                  height: _size.height * .02,
                ),
                LogInItem(
                    key: Key('phone'),
                    textEditingController: controller.phone,
                    label: "Phone Number",
                    hint: "Pone Number",
                    icon: Icons.add_call,
                    validator: controller.validator.validatePhone),
                SizedBox(
                  height: _size.height * .02,
                ),
                GetBuilder<SignUpViewController>(builder: (logic) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: DropdownButton<TypeRegister>(
                          key: Key('type'),
                          hint: Text("Type"),
                          isExpanded: true,
                          value: logic.type,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateTypeRegister,
                          items: logic.typeList
                              .map<DropdownMenuItem<TypeRegister>>(
                                  (TypeRegister value) {
                            return DropdownMenuItem<TypeRegister>(
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
                SizedBox(
                  height: _size.height * .02,
                ),
                GetBuilder<LocController>(builder: (logic) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: DropdownButtonFormField<RefJson>(
                          key: Key('city'),
                          hint: Text("City"),
                          validator: (RefJson) {
                            return controller.validator.validateCity(RefJson);
                          },
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
                SizedBox(
                  height: _size.height * .02,
                ),
                LogInItem(
                    key: Key('email'),
                    textEditingController: controller.email,
                    label: "Email",
                    hint: "Email",
                    icon: Icons.email,
                    validator: controller.validator.validateEmail),
                SizedBox(
                  height: _size.height * .02,
                ),
                GetBuilder<SignUpViewController>(builder: (logic) {
                  return LogInItem(
                    validator: controller.validator.validatePassword,
                    label: "Password",
                    hint: "**********",
                    icon: Icons.lock_outline,
                    //Ajouter
                    obscureText: logic.isVisiblePassword,
                    textEditingController: controller.password,
                    suffixIcon: IconButton(
                      onPressed: controller.showHidePassword,
                      icon: Icon(logic.isVisiblePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  );
                }),
                SizedBox(
                  height: _size.height * .05,
                ),
                Center(
                    child: CustomButton1(
                  height: 50,
                  width: _size.width * .8,
                  btcolor: buttonColor,
                  icon: Icons.login,
                  label: "Créer mon compte",
                  labcolor: textbuttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  function: () {
                    controller.validator.validationType = false;
                    if (!controller.registerFormKey.currentState.validate()) {
                      //if client validations fails
                      //show a snackbar to fix the client errors.
                      Get.snackbar("Oups !",
                          "Merci de corriger les erreurs ci-dessous.");
                      return;
                    }
                    controller.validator.validationType = true;
                    //send data to server and get errors
                    controller.postRegister(context);
                  },
                )),
                SizedBox(
                  height: _size.height * .05,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Vous avez déjà un compte ? ",
                        style: TextStyle(color: framColor, fontSize: 15),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: framColor,
                                  fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
