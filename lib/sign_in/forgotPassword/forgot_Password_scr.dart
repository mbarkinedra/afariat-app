import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/app_mailer_selector.dart';
import '../../config/app_config.dart';
import 'forgotpassword_view_controller.dart';

class ForgotPassword extends GetWidget<ForgotPasswordViewController> {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var appConfig = AppConfig.of(context);
    controller.success.value = false;
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          color: Colors.white,
          child: Obx(
            () => controller.success.isFalse
                ? Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Récupération du mot de passe",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20, left: 5, right: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Saisissez votre email pour rénitialisez votre mot de passe",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => controller.error.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.warning_rounded,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      controller.error.value,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ),
                      SizedBox(
                        height: _size.height * .02,
                      ),
                      CustomTextFiled(
                        color: framColor,
                        width: _size.width * .9,
                        hintText: 'Ex: bob@gmail.com',
                        textEditingController: controller.usernameController,
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear_outlined),
                            onPressed: () {
                              controller.clearUsernameField();
                              controller.error.value = '';
                            }),
                        onchange: (value) {
                          controller.error.value = '';
                        },
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
                                width: _size.width * .5,
                                btColor: buttonColor,
                                icon: Icons.check_circle,
                                fontWeight: FontWeight.bold,
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
                        padding: const EdgeInsets.all(5),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(5)),
                          child: SizedBox(
                            height: 250,
                            width: _size.width,
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
                                    'Notez bien: En cas de non réception de l\'email, veuillez vérifier le dossier des SPAMS.',
                                    style: TextStyle(
                                      //fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                      fontSize: 16
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
                        width: _size.width * .5,
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
        ),
      ),
    );
  }
}
