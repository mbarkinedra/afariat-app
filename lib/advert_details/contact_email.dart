import 'package:afariat/config/utilitie.dart';

import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:flutter/material.dart';

class ContactEmail extends StatefulWidget {
  @override
  _ContactEmailState createState() => _ContactEmailState();
}

class _ContactEmailState extends State<ContactEmail> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogInItem(
                  label: "votre nom",
                ),
                SizedBox(
                  height: _size.height * .05,
                ),
                LogInItem(
                  label: "votre Email",
                ),
                LogInItem(
                  label: "Message",

                  //   textEditingController: controller.password,
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
                  label: "Envoyer",
                  labcolor: textbuttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  function: () {
                    //controller.getwsse();
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
