import 'package:flutter/material.dart';

class CustomButtonIcon extends StatelessWidget {
  final Color btcolor;
  final Color iconcolor;

  final double height;
  final double width;

  final Function function;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
              child: Icon(
            icon,
            color: Colors.white,
          )),
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: btcolor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomButtonIcon({
    @required this.btcolor,
    this.icon,
    @required this.function,
    @required this.height,
    @required this.width,
    this.iconcolor = Colors.white,
  });
}
