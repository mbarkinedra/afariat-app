import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_profile/account_profile/account_viewcontroller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AcountScr extends GetWidget<AcountViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                maxRadius: 50, backgroundColor: Colors.orange,
                //backgroundImage: NetworkImage(userAvatarUrl),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: _size.width * .5,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                  Container(
                    width: _size.width * .5,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          CustomButton(
            height: 50,
            width: _size.width * .7,
            label: "Modifier votre mot de passe",
            labcolor: buttonColor,
            btcolor: Colors.grey[200],function: (){},icon: Icons.lock_outline,
          )
          ,  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "PREFER",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),  ],
      ),
    );
  }
}