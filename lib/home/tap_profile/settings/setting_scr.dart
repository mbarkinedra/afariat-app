import 'package:afariat/config/utility.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/profile_pic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'setting_view_controller.dart';

class Setting extends GetWidget<SettingViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        // CircleAvatar(maxRadius: 50,
        //   backgroundImage: NetworkImage(
        //       "https://www.sleeptasticsolutions.com/wp-content/uploads/2018/05/happy-kids-1.jpg"),
        // ),
        CustomTextFiled(
          color: framColor,
          width: size.width * .8,
          hintText: '*********',
          textEditingController: controller.password,
        ),
     CustomButtonWithoutIcon(height: 50,label: "send",width: size.width*.8,btcolor: framColor,function: (){},)
       , Padding(
         padding: const EdgeInsets.only(top: 8.0,bottom: 8,left: 20,right: 20),
         child: Row(
            children: [
              Icon(Icons.dark_mode),
              // Flexible(
              //   flex: 1,
              //   child: GetBuilder<SettingViewController>(builder: (logic) {
              //     return ListTile(
              //       title: const Text('DarkMode'),
              //       trailing: CupertinoSwitch(
              //         value: logic.tham,
              //         activeColor: Colors.orange,
              //        onChanged: logic.changeTheme,
              //       ),
              //     //  onTap: logic.changeTheme,
              //     );
              //   }),
              // ),
            ],
          ),
       ),   ],
    );
  }
}
