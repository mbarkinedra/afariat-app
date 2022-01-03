import 'package:flutter/material.dart';

class CustomApercu extends StatelessWidget {
  String label;
  String data;


  CustomApercu({this.label, this.data});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Text(label,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
          Expanded(
            child: Text(data),
          )
        ],
      ),
    );
  }
}
