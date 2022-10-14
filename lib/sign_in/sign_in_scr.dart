import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_config.dart';
import '../networking/json/simple_json_resource.dart';
import '../persistent_tab_manager.dart';
import 'forgotPassword/forgot_Password_scr.dart';

class SignInScr extends GetWidget<SignInViewController> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    controller.signInFormKey = globalKey;
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true, body: _buildFormScreen(context)),
    );
  }

  _buildFormScreen(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var appConfig = AppConfig.of(context);
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
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
                              "assets/images/" +
                                  appConfig.appName +
                                  "/logo.png",
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
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: Form(
                    key: controller.signInFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: _size.height * .05,
                        ),
                        Obx(() => controller.error.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 25),
                                child: Text(
                                  controller.error.value,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox()),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: LogInItem(
                            label: "Email",
                            hint: "Votre e-mail",
                            icon: Icons.email,
                            textEditingController: controller.email,
                            validator: controller.validator.validateEmail,
                            onChanged: (text) {
                              controller.error.value = '';
                            },
                          ),
                        ),
                        SizedBox(
                          height: _size.height * .05,
                        ),
                        GetBuilder<SignInViewController>(builder: (logic) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: LogInItem(
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
                            ),
                          );
                        }),
                        SizedBox(
                          height: _size.height * .05,
                        ),
                        Obx(
                          () => controller.isLoading.isTrue
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton1(
                                  height: 50,
                                  width: _size.width,
                                  btcolor: buttonColor,
                                  icon: Icons.login,
                                  iconcolor: Colors.white,
                                  label: "Se connecter",
                                  labcolor: textbuttonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  function: () async {
                                    controller.validator.validationType = false;
                                    if (!controller.signInFormKey.currentState
                                        .validate()) {
                                      //if client validations fails
                                      //show a snackbar to fix the client errors.
                                      Get.snackbar("Oups !",
                                          "Merci de corriger les erreurs ci-dessous.");
                                    } else {
                                      controller.validator.validationType =
                                          true;
                                      //send data to server and get errors
                                      SimpleJsonResource jsonResource =
                                          await controller.login();
                                    }
                                  },
                                ),
                        ),
                        SizedBox(
                          height: _size.height * .05,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScr()),
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
                                          fontWeight: FontWeight.bold,
                                          color: framColor))
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
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text(
                            "Mot de passe oublié ? ",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _size.height * .25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
