import 'package:afariat/config/utility.dart';

import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../persistent_tab_manager.dart';
import 'delete_success_view_controller.dart';

class DeleteAccountSuccessView
    extends GetWidget<DeleteAccountSuccessViewController> {
  const DeleteAccountSuccessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    color: framColor,
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
              "Compte supprimé",
              style: TextStyle(
                  color: framColor, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.deepOrange.shade50,
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
                        'Votre compte a été supprimé définitivement.',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CustomButton1(
                btcolor: Colors.grey[200],
                labcolor: Colors.black,
                fontWeight: FontWeight.bold,
                icon: Icons.arrow_back,
                iconcolor: Colors.black,
                function: () {
                  //PersistentTabManager.goToHome(context);
                  PersistentTabManager.goToLoginPage(context);
                },
                height: 50,
                width: size.width * .7,
                label: "Aller à la page d\'accueil",
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
