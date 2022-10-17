import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  double width;
  double height;
  String message;
  Color foregroundColor;
  Color backgroundColor;
  Widget extraMessageWidget;
  IconData iconData;

  InformationWidget({
    Key key,
    this.width,
    this.height,
    this.message,
    this.extraMessageWidget,
    this.foregroundColor,
    this.backgroundColor,
    this.iconData,
  }) : super(key: key) {
    foregroundColor ??= Colors.white;
    backgroundColor ??= Colors.cyan;
    iconData ??= Icons.info;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 1,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      iconData,
                      color: foregroundColor,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: foregroundColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              extraMessageWidget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
