import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Motos extends GetView<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Marque"),
            title: DropdownButton<RefJson>(
              value: logic.dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: logic.updateMarque,
              items: logic.motosBrands
                  .map<DropdownMenuItem<RefJson>>((RefJson value) {
                return DropdownMenuItem<RefJson>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          );
        }),
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Kilométrage"),
            title: DropdownButton<RefJson>(
              value: logic.meliage,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: logic.updateKilomtrage,
              items: logic.meliages
                  .map<DropdownMenuItem<RefJson>>((RefJson value) {
                return DropdownMenuItem<RefJson>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          );
        }),
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Année"),
            title: DropdownButton<RefJson>(
              value: logic.yersmodele,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: logic.updateAnnee,
              items: logic.yersmodeles
                  .map<DropdownMenuItem<RefJson>>((RefJson value) {
                return DropdownMenuItem<RefJson>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
          );
        })
      ],
    );
  }
}
