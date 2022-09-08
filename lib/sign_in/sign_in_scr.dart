import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'forgotPassword/forgot_Password_scr.dart';

class SignInScr extends GetWidget<SignInViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    controller.signInFormKey = globalKey;
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: controller.signInFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Connectez-vous",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: _size.height * .05,
              ),
              Text("Bon retour, Tu nous as manqué!"),
              SizedBox(
                height: _size.height * .05,
              ),
              LogInItem(
                  label: "Email",
                  hint: "Votre E-mail",
                  icon: Icons.email,
                  textEditingController: controller.email,
                  validator: controller.validator.validateEmail),
              SizedBox(
                height: _size.height * .05,
              ),
              GetBuilder<SignInViewController>(builder: (logic) {
                return LogInItem(
                  label: "Mot de passe",
                  hint: "Mot de passe",
                  icon: Icons.lock_outline,
                  //Ajouter
                  obscureText: logic.isVisiblePassword,
                  textEditingController: controller.password,
                  validator: controller.validator.validatePassword,
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
              GetBuilder<SignInViewController>(builder: (logic) {
                return logic.buttonLogin
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton1(
                        height: 50,
                        width: _size.width * .8,
                        btcolor: buttonColor,
                        icon: Icons.login,
                        iconcolor: Colors.white,
                        label: "Se connecter",
                        labcolor: textbuttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        function: () {
                          controller.validator.validationType = false;
                          if (!controller.signInFormKey.currentState
                              .validate()) {
                            //if client validations fails
                            //show a snackbar to fix the client errors.
                            Get.snackbar("Oups !",
                                "Merci de corriger les erreurs ci-dessous.");
                          } else {
                            controller.validator.validationType = true;
                            //send data to server and get errors
                            controller.login();
                          }
                        },
                      );
              }),
              SizedBox(
                height: _size.height * .05,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScr()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Vous n'avez pas de compte ?  ",
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Créer un compte',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: framColor))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _size.height * .05,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: Text(
                  "Mot de passe oublié ? ",
                  style: TextStyle(
                      color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )));
  }
}
