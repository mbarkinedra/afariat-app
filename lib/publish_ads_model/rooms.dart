import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Rooms extends GetView<TapPublishViewController> {
  // @override
  // void initState() {
  //   _publishAPIs.roomsnumber().then((value) {
  //     rooms = value.data;
  //     setState(() {});
  //     print(value.data);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
    Row(
      children: [Text("Nombre de pièces",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),SizedBox(width: 8,)
       , Expanded(flex: 1,
          child: GetBuilder<TapPublishViewController>(builder: (logic)
          {
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.orange,),borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                //leading: Text("Nombre de pièces"),
                title: DropdownButton<String>(
                  value: logic.pieces,isExpanded: true,

                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(

                  ),
                  onChanged: logic.updateNombredepieces,
                  items: logic.Nombredepieces.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                ),
              ),
            );
          }),
        ),
      ],
    ),
SizedBox(height: 8,),

    Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(
    "Surface",
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    Flexible(
    flex: 1,

    child: CustomTextFiled(padding: 0,

    color: Colors.orange,
    textEditingController: controller.price,
    keyboardType: TextInputType.number,
    ),
    ),

    Container(    height: 50,width: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange),color: Colors.grey[100]),
      child: Center(
        child: Text(
        "m²",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    )
    ],
    ),
    //   buildTitleFormField(),
    ],
    );
  }

// buildTitleFormField() {
//   return TextFormField(
//     decoration: InputDecoration(
//       labelText: "Title",
//       hintText: "Enter your Title",
//     ),
//   );
// }
}
