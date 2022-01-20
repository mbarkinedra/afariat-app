import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/mywidget/custmbutton.dart';
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
        padding: const EdgeInsets.all(16.0),
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
                  height: _size.height * .1,
                ),
                LogInItem(
                  textEditingController: controller.name,
                  label: "Nom & prénom",
                  hint: "Nom et prénom ou nom de société",
                  icon: Icons.account_circle,
                  validator: (value) {
                    return controller.validateServer.validator(value, 'name');
                  },
                ),
                SizedBox(
                  height: _size.height * .05,
                ),
                LogInItem(
                    textEditingController: controller.phone,
                    label: "Phone Number",
                    hint: "Pone Number",
                    icon: Icons.add_call,
                    validator: (value) {
                      return controller.validateServer
                          .validator(value, 'phone');
                    }),
                SizedBox(
                  height: _size.height * .05,
                ),
                GetBuilder<SignUpViewController>(builder: (logic) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange),borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<TypeRegister>(
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
                  height: _size.height * .05,
                ),
                GetBuilder<LocController>(builder: (logic) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        // decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange),borderRadius: BorderRadius.circular(10)),
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
                SizedBox(
                  height: _size.height * .05,
                ),
                LogInItem(
                  textEditingController: controller.email,
                  label: "Email",
                  hint: "Email",
                  icon: Icons.email,
                  validator: (value) {
                    return controller.validateServer.validator(value, 'email');
                  },
                ),
                SizedBox(
                  height: _size.height * .05,
                ),
                //Ajouter controller builder
                GetBuilder<SignUpViewController>(builder: (logic) {
                  return LogInItem(
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
                    child: CustomButton(
                  height: 50,
                  width: _size.width * .8,
                  btcolor: buttonColor,
                  icon: Icons.login,
                  label: "Créer mon compte",
                  labcolor: textbuttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  function: () {
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
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Log in',
                              style: TextStyle(fontWeight: FontWeight.bold))
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
