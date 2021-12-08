import 'package:afariat/config/utilitie.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/sign_up/sign_up_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScr extends GetWidget<SignUpViewController>  {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
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
                            "Registrer",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: _size.height * .02,
                          ),
                          Text("Create converting ads!"),
                          SizedBox(
                            height: _size.height * .1,
                          ),


                           LogInItem(textEditingController: controller.name,
                            label: "Full Name",
                            hint: "Username",
                            icon: Icons.account_circle,
                          ),
                          SizedBox(height: _size.height*.05,),
                          LogInItem(textEditingController: controller.phone,
                            label: "Phone Number",
                            hint: "Pone Number",
                            icon: Icons.add_call,
                          ),
                          SizedBox(height: _size.height*.05,),
                          GetBuilder<LocController>(builder: (logic) {
                            return Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                 // decoration: BoxDecoration(border: Border.all(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<RefJson>(

                                    hint: Text("City"),

                                    isExpanded: true,
                                    value: logic.citie,

                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: logic.updatecitie,
                                    items: logic.cities
                                        .map<DropdownMenuItem<RefJson>>((RefJson value) {
                                      return DropdownMenuItem<RefJson>(
                                        value: value,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                       ],
                            );
                          }),
                          SizedBox(height: _size.height*.05,),
                          LogInItem(textEditingController: controller.email,
                            label: "Username or mail",
                            hint: "Username",
                            icon: Icons.email,
                          ),
                          SizedBox(height: _size.height*.05,),
                          LogInItem(label: "Password",hint:"**********" ,icon: Icons.lock_outline,obscureText: true,textEditingController: controller.password,),



                          SizedBox(height: _size.height*.05,),
                          Center(child: CustomButton(height: 50,width: _size.width*.8,btcolor: buttonColor,icon: Icons.login,label: "REGISTER",labcolor: textbuttonColor,fontWeight: FontWeight.bold,fontSize: 20,function: (){
                            controller.post();
                          },))

                          ,SizedBox(height: _size.height*.05,),Center(
                            child: InkWell(onTap: (){
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  SignUpScr()),
                              // );
                              Navigator.pop(context);
                            },
                              child: RichText(
                                text: TextSpan(
                                  text: " Have an account? ",
                                  style: DefaultTextStyle.of(context).style,
                                  children: const <TextSpan>[
                                    TextSpan(text: 'Log in', style: TextStyle(fontWeight: FontWeight.bold))

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
