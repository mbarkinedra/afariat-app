import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
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
        GetBuilder<TapPublishViewController>(builder: (logic) {
          return ListTile(
            leading: Text("Nombre de pièces"),
            title: DropdownButton<String>(
              value: logic.pieces,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: logic.updateNombredepieces,
              items: logic.Nombredepices.map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          );
        }),

        TextFormField(
          decoration: InputDecoration(
            labelText: "surface",
            hintText: "Enter your Title",
          ),
        )
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
