import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Motos extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text("Marque")),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: framColor, width: 2),
                        ),
                        child: DropdownButtonFormField<RefJson>(
                          isExpanded: true,
                          value: logic.motosBrand,
                          validator: (RefJson) {
                            return controller.validator.validateMarque(RefJson);
                          },
                          iconSize: 24,
                          elevation: 16,
                          onChanged: controller.updateMarqueMoto,
                          items: controller.motosBrands
                              .map<DropdownMenuItem<RefJson>>((RefJson value) {
                            return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text("Km")),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: framColor, width: 2)),
                        child: DropdownButtonFormField<RefJson>(
                          isExpanded: true,
                          value: logic.kilometrage,
                          validator: (RefJson) {
                            return controller.validator.validateKm(RefJson);
                          },
                          iconSize: 24,
                          elevation: 16,
                          onChanged: controller.updateKilometrage,
                          items: controller.mileages
                              .map<DropdownMenuItem<RefJson>>((RefJson value) {
                            return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text("Année")),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: framColor, width: 2)),
                        child: DropdownButtonFormField<RefJson>(
                          isExpanded: true,
                          value: logic.yearsModele,
                          validator: (RefJson) {
                            return controller.validator.validateYears(RefJson);
                          },
                          iconSize: 24,
                          elevation: 16,
                          onChanged: controller.updateAnnee,
                          items: controller.yearsModels
                              .map<DropdownMenuItem<RefJson>>((RefJson value) {
                            return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
