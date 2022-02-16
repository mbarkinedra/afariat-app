import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/json/ref_json.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleBrands extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Marque"),
            title: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2)),
              child: DropdownButton<RefJson>(
                underline: SizedBox(),
                isExpanded: true,
                value: logic.vehiculebrands,
                iconSize: 24,
                elevation: 16,
                onChanged: logic.updateMarque,
                items: logic.vehiculeBrands
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
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Modèle"),
            title: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.deepOrangeAccent)),
              child: DropdownButton<RefJson>(
                underline: SizedBox(),
                isExpanded: true,
                value: logic.vehiculeModel,
                iconSize: 24,
                elevation: 16,
                onChanged: logic.updateModel,
                items: logic.vehiculeModels
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
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Energie"),
            title: Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.deepOrangeAccent, width: 2)),
              child: DropdownButton<RefJson>(
                underline: SizedBox(),
                isExpanded: true,
                value: logic.energie,
                iconSize: 24,
                elevation: 16,
                onChanged: logic.updateEnergie,
                items: logic.energies
                    .map<DropdownMenuItem<RefJson>>((RefJson value) {
                  print(value);
                  return DropdownMenuItem<RefJson>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          );
        }),
        GetBuilder<TapPublishViewController>(builder: (logic) {
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
        GetBuilder<TapPublishViewController>(builder: (logic) {
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
        })
      ],
    );
  }
}
