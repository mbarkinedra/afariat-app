import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rooms extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 2,
              child: Text(
                "Nombre de pièces",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              flex:4,
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: DropdownButton<String>(
                      value: logic.pieces,
                      isExpanded: true,
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(),
                      onChanged: logic.updateNombredepieces,
                      items: logic.nombrePieces.map<DropdownMenuItem<String>>(
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


        Row(

          children: [
            Expanded(flex: 2,
              child: Text(
                "Surface",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(            decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      color: Colors.grey[100]),
                child: Row(
                  children: [
                    Expanded(flex: 1,
                      child: CustomTextFiled(
                        padding: 0,
                        color: Colors.deepOrange,
                        textEditingController: controller.surface,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Text(
                      "m²",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ) ],
                ),
              ),
            ),
            // Container(
            //   height: 50,
            //
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       border: Border.all(color: Colors.deepOrange, width: 2),
            //       color: Colors.grey[100]),
            //   child: Center(
            //     child: Text(
            //       "m²",
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //     ),
            //   ),
            // )
          ],
        ),
        //   buildTitleFormField(),
      ],
    );
  }
}
