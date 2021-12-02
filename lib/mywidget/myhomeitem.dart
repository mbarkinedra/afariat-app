import 'package:afariat/networking/jsonfile/adverts_json.dart';
import 'package:flutter/material.dart';

class MyHomeItem extends StatelessWidget {
  final Size size;


  MyHomeItem({this.size, this.adverts});

  final Adverts adverts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: size.height * .3,
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container( height: size.height * .25,
              width: size.width * .4,
              child: Image.network(  adverts.photo,

                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(  width: size.width * .4,
                    child: Text( adverts.title ,
                      softWrap: true,
                      overflow: TextOverflow.fade,   ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( adverts.price.toString()

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( adverts.modifiedAt
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}