import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_text_filed2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rooms extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Nombre de pièces",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
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
                        items: logic.nombrePieces
                            .map<DropdownMenuItem<String>>((String value) {
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
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Surface",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: size.width * .55,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextFiled2(
                                  padding: 0,
                                  color: Colors.deepOrange,
                                  hintText: "Surface",
                                  validator:
                                  controller.validator.validateSurface,
                                  textEditingController: controller.surface,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Text(
                                "m²",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /*    child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomTextFiled2(
                              padding: 0,
                              color: Colors.deepOrange,
                              textEditingController: controller.surface,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Text(
                            "m²",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),*/
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
        ),
        //buildTitleFormField(),
      ],
    );
  }
}
