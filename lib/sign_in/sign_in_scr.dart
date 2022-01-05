import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScr extends GetWidget<SignInViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var _isLoading = false;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              ),
              SizedBox(
                height: _size.height * .05,
              ),
              LogInItem(
                label: "Mot de passe",
                hint: "**********",
                icon: Icons.lock_outline,
                textEditingController: controller.password,
                obscureText: true,
              ),
              SizedBox(
                height: _size.height * .05,
              ),
              Text(
                "Mot de passe oublié ?",
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                height: _size.height * .05,
              ),
              Center(
                  child: CustomButton(
                height: 50,
                width: _size.width * .8,
                btcolor: buttonColor,
                icon: Icons.login,
                label: "Log  In",
                labcolor: textbuttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                function: () {
                  controller.login();
                },
              )),
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
                      text: "Vous n'avez pas de compte ?",
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Créer un compte',
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
    ));
  }
}
