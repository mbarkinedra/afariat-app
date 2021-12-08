import 'package:afariat/config/utilitie.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/sign_in/sign_in_viewcontroller.dart';
import 'package:afariat/sign_up/sign_up_scr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScr extends GetWidget<SignInViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size=MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "let'S Sign You in",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ), SizedBox(height: _size.height*.05,),
                  Text("Welcome back, you've been missed!"),
                  SizedBox(height: _size.height*.1,)
                ,LogInItem(label: "Username or mail",hint:"Username" ,icon: Icons.email, textEditingController: controller.name, )
                  ,
                SizedBox(height: _size.height*.05,),
                   LogInItem(label: "Password",hint:"**********" ,icon: Icons.lock_outline, textEditingController: controller.password, obscureText: true,)
                  ,
                SizedBox(height: _size.height*.05,),Text("Forget password",style: TextStyle(color: Colors.blue),)

                  ,
                  SizedBox(height: _size.height*.05,),

                  Center(child: CustomButton(height: 50,width: _size.width*.8,btcolor: buttonColor,icon: Icons.login,label: "Log  In",labcolor: textbuttonColor,fontWeight: FontWeight.bold,fontSize: 20,function: (){controller.getwss();},))

                ,SizedBox(height: _size.height*.05,),Center(
                  child: InkWell(onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  SignUpScr()),
                    );
                  },
                    child: RichText(
                        text: TextSpan(
                          text: " Don't Have an account? ",
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                       TextSpan(text: 'Register', style: TextStyle(fontWeight: FontWeight.bold))

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
