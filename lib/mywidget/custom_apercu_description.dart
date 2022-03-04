import 'package:flutter/material.dart';

class CustomApercuDescription extends StatelessWidget {
final  String label;
final  String data;

  CustomApercuDescription({this.data, this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(padding: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Text(data),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
          )
        ],
      ),
    );
  }
}
