import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/utility.dart';
import '../mywidget/custom_button_1.dart';
import '../persistent_tab_manager.dart';
import 'login_success_view_controller.dart';

class LoginSuccessView extends GetWidget<LoginSuccessViewController> {
  const LoginSuccessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuccessScreen(context),
    );
  }

  _buildSuccessScreen(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
        ),
        CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Icon(
            Icons.check,
            color: Color.fromARGB(255, 46, 226, 177),
            size: 128,
          ),
          minRadius: 96,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Bon retour !',
          style: TextStyle(
              fontSize: 60, color: Color.fromARGB(255, 102, 111, 149)),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Vous êtes bien connecté',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
        ),
        SizedBox(
          height: 100,
        ),
        CustomButton1(
          height: 50,
          width: _size.width * 0.7,
          btcolor: Color.fromARGB(255, 46, 226, 177),
          icon: Icons.home,
          iconcolor: Colors.white,
          label: "Aller à la page d'acceuil",
          labcolor: textbuttonColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          function: () async {
            PersistentTabManager.goToHome(context);
            //PersistentTabManager.updateScreens();
            PersistentTabManager.changePage(0);
          },
        ),
      ],
    );
  }
}
