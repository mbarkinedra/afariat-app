import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_text_filed2.dart';
import 'package:afariat/networking/json/ref_json.dart';
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
                        border: Border.all(color: framColor, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: DropdownButtonFormField<RefJson>(
                        value: logic.nombrePiece,
                        isExpanded: true,
                        iconSize: 24,
                        elevation: 16,
                        decoration: InputDecoration.collapsed(hintText: ''),
                        style: const TextStyle(color: Colors.black),
                        // underline: Container(),
                        validator: (RefJson) {
                          return controller.validator.validatePieces(RefJson);
                        },
                        onChanged: logic.updateNombrePieces,
                        items: controller.nombrePieces
                            .map<DropdownMenuItem<RefJson>>((RefJson value) {
                          return DropdownMenuItem<RefJson>(
                            value: value,
                            child: Text(value.name),
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
                        decoration: BoxDecoration(
                            border: Border.all(color: framColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextFiled2(
                                    padding: 0,
                                    color: framColor,
                                    hintText: "Surface",
                                    validator:
                                        controller.validator.validateSurface,
                                    textEditingController: controller.surface,
                                    keyboardType: TextInputType.number),
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
