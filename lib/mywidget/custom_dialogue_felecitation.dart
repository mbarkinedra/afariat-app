import 'package:flutter/material.dart';

class CustomDialogueFelecitation extends StatelessWidget {
  final String title, description, buttonText, text2;
  final Image image;
  final Function function;
  final bool phone;

  CustomDialogueFelecitation({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    // @required this.buttonText2,
    @required this.function,
    this.text2,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        Container(
          width: MediaQuery.of(context).size.width * .9,
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 24.0),
              SizedBox(height: 24.0),
            ],
          ),
        ),

        Positioned(
          bottom: 10,
          right: MediaQuery.of(context).size.width * .25,
          left: MediaQuery.of(context).size.width * .25,
          child: GestureDetector(
            onTap: function,
            child: Container(
              width: 70,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.teal, width: 2),
//border corner radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
              ),
              child: Center(child: Text(buttonText)),
            ),
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.teal,
            //  backgroundImage: AssetImage('assets/images/alert.png'),
            radius: Consts.avatarRadius,
            child: Center(
              child: Container(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              )),
            ),
          ),
        ),
        //...top circlular image part,
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 40.0;
}
