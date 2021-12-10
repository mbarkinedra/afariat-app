import 'package:afariat/config/utilitie.dart';

import 'package:afariat/mywidget/custmbutton.dart';
import 'package:flutter/material.dart';

class SignUpSucces extends StatefulWidget {
  @override
  _SignUpSuccesState createState() => _SignUpSuccesState();
}

class _SignUpSuccesState extends State<SignUpSucces> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(flex: 1, child: SizedBox()),
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
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                  ),
                  height: size.height * .1,
                  width: size.height * .1,
                ),
                Container(
                  color: Colors.orange[100],
                  height: size.height * .05,
                  width: size.height * .05,
                ),
                Icon(
                  Icons.check,
                  color: Colors.white,
                )
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Registration Successfully",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "you have successfully registred,create converting ads",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: CustomButton(
              btcolor: buttonColor,
              function: () {
                int count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });
              },
              height: 50,
              width: size.width * .7,
              label: "Continuer",
            )),
          ),
        ],
      ),
    ));
  }
}
