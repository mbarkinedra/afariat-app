import 'package:afariat/config/utility.dart';

import 'package:afariat/mywidget/custmbutton.dart';
import 'package:flutter/material.dart';

class SignUpSucces extends StatefulWidget {
  String message;


  SignUpSucces(this.message);

  @override
  _SignUpSuccesState createState() => _SignUpSuccesState(this.message);
}

class _SignUpSuccesState extends State<SignUpSucces> {
  String message;

  _SignUpSuccesState(this.message);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Expanded(flex: 1, child: SizedBox()),
        Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)),
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

                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40.0,
                  ),


                ],

              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Compte crée",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
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
                  labcolor: Colors.white,
                  fontWeight: FontWeight.bold,
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
    ),)
    );
  }
}
