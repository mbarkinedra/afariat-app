import 'package:flutter/material.dart';

class CustomApercu extends StatelessWidget {
  String label;
  String data;

  CustomApercu({this.label, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )),
          Expanded(
            child: Text(data),
          )
        ],
      ),
    );
  }
}
