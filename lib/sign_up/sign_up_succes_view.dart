import 'package:afariat/config/utility.dart';

import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/sign_up/signup_success_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Common/app_mailer_selector.dart';
import '../mywidget/custom_button_without_icon.dart';
import '../persistent_tab_manager.dart';

class SignupSuccessView extends GetWidget<SignupSuccessViewController> {
  const SignupSuccessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.message = Get.parameters['message'];
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(flex: 1, child: SizedBox()),
          Center(
              child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: size.height * .1,
            width: size.height * .1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  height: size.height * .1,
                  width: size.height * .1,
                ),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Compte crée",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                height: 250,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.message,
                        style: const TextStyle(
                          color: Color.fromRGBO(2, 48, 2, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Notez bien: En cas de non réception de l\'email, veuillez vérifier vos spams.',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomButton1(
            height: 50,
            label: "Ouvrir dans Email",
            btcolor: Colors.teal,
            labcolor: Colors.white,
            iconcolor: Colors.white,
            width: size.width * .7,
            fontWeight: FontWeight.bold,
            icon: Icons.outbound_outlined,
            function: () async {
              await AppMailerSelector.open(context);
            },
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomButton1(
                btcolor: Colors.grey,
                labcolor: Colors.black,
                fontWeight: FontWeight.bold,
                icon: Icons.arrow_back,
                iconcolor: Colors.black,
                function: () {
                  PersistentTabManager.goToHome(context);
                  PersistentTabManager.changePage(4);
                },
                height: 50,
                width: size.width * .7,
                label: "Aller à la page de connexion",
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
