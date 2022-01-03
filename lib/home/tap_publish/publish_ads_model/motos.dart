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
            title:  Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange)
              ),
              child: DropdownButton<RefJson>(  underline: SizedBox(),isExpanded: true,
                value: logic.vehiculebrands,

                iconSize: 24,
                elevation: 16,


                onChanged: logic.updateMarque ,
                items: logic.motosBrands.map<DropdownMenuItem<RefJson>>((RefJson value) {
                  return DropdownMenuItem<RefJson>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          );
        }
        ),
        GetBuilder<TapPublishViewController>(builder: (logic) {

          return ListTile(
            leading: Text("Kilométrage"),
            title:  Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange)
              ),
              child: DropdownButton<RefJson>(underline: SizedBox(),isExpanded: true,
                value:logic. kilometrage,

                iconSize: 24,
                elevation: 16,

                onChanged: logic.updateKilomtrage,
                items:logic. meliages.map<DropdownMenuItem<RefJson>>((RefJson value) {
                  return DropdownMenuItem<RefJson>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          );
        }
        ),
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Année"),
            title:  Container(
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange)
              ),
              child: DropdownButton<RefJson>(underline: SizedBox(),isExpanded: true,
                value: logic.yearsmodele,

                iconSize: 24,
                elevation: 16,

                onChanged: logic.updateAnnee,
                items: logic.yersmodeles.map<DropdownMenuItem<RefJson>>((RefJson value) {
                  return DropdownMenuItem<RefJson>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              ),
            ),
          );
        }
        )
      ],
    );
  }
}