import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/app_mailer_selector.dart';
import 'forgotpassword_view_controller.dart';

class ForgotPassword extends GetWidget<ForgotPasswordViewController> {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.success.value = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mot de passe oublié",
          style: TextStyle(color: colorText),
        ),
        backgroundColor: Colors.white,
        foregroundColor: framColor,
      ),
      body: Obx(
        () => controller.success.isFalse
            ? Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Saisissez votre email pour rénitialisez votre mot de passe",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFiled(
                    color: framColor,
                    width: size.width * .9,
                    hintText: 'Ex: bob@gmail.com',
                    textEditingController: controller.usernameController,
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_outlined),
                        onPressed: () {
                          controller.clearUsernameField();
                        }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Obx(
                    () => controller.isSending.isTrue
                        ? const CircularProgressIndicator()
                        : CustomButtonWithoutIcon(
                            height: 50,
                            label: "Envoyer",
                            labColor: Colors.white,
                            width: size.width * .5,
                            btColor: buttonColor,
                            function: () {
                              controller.forgotPassword();
                            },
                          ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(5)),
                      child: SizedBox(
                        height: 180,
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Un email de réinitialisation vous a été envoyé.\n',
                                style: TextStyle(
                                    color: Color.fromRGBO(7, 47, 95, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Veuillez cliquer sur le lien reçu dans l\'email pour réinitialiser votre mot de passe.',
                                style: TextStyle(
                                    color: Color.fromRGBO(7, 47, 95, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Notez bien: En cas de non réception de l\'email, veuillez vérifier vos spams.',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  CustomButtonWithoutIcon(
                    height: 50,
                    label: "Ouvrir dans Email",
                    labColor: Colors.white,
                    width: size.width * .5,
                    btColor: buttonColor,
                    icon: Icons.outbound_outlined,
                    iconColor: Colors.white,
                    function: () async {
                      await AppMailerSelector.open(context);
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
