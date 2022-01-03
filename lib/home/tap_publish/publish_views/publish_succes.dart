import 'package:afariat/config/utilitie.dart';

import 'package:afariat/mywidget/custmbutton.dart';
import 'package:flutter/material.dart';

class PublishSucces extends StatefulWidget {





  @override
  _PublishSuccesState createState() => _PublishSuccesState();
}

class _PublishSuccesState extends State<PublishSucces> {




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
            "Votre annonce a été  publiée avec succés . ",
            style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
                fontWeight: FontWeight.bold),
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