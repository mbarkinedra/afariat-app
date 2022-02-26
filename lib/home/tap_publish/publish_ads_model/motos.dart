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
                      child:Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.deepOrange, width: 2),
                        ),
                        child: DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          value: logic.vehiculebrands,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateMarque,
                          items: logic.motosBrands
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
                return ListTile(
                  leading: Text("Marque"),
                  title: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepOrange, width: 2),
                    ),
                    child: DropdownButton<RefJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      value: logic.vehiculebrands,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateMarque,
                      items: logic.motosBrands
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text("Km")),
                    Expanded(
                      flex: 3,
                      child:Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.deepOrange, width: 2)),
                        child: DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          value: logic.kilometrage,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateKilometrage,
                          items: logic.mileages
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
                return ListTile(
                  leading: Text("Kilométrage"),
                  title: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepOrange, width: 2)),
                    child: DropdownButton<RefJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      value: logic.kilometrage,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateKilometrage,
                      items: logic.mileages
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<TapPublishViewController>(builder: (logic) {
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text("Année")),
                    Expanded(
                      flex: 3,
                      child:Container(
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.deepOrange, width: 2)),
                        child: DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          value: logic.yearsmodele,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateAnnee,
                          items: logic.yearsModels
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
                return ListTile(
                  leading: Text("Année"),
                  title: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepOrange, width: 2)),
                    child: DropdownButton<RefJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      value: logic.yearsmodele,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateAnnee,
                      items: logic.yearsModels
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
            )
          ],
        ),
      ],
    );
  }
}
