import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/material.dart';

class MyHomeItem extends StatelessWidget {
  final Size size;

  MyHomeItem({this.size, this.adverts});

  final AdvertJson adverts;

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
            Expanded(
              flex: 1,
              child: Container(
                height: size.height * .25,
                child: Image.network(
                  adverts.photo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        adverts.title,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                     "${ adverts.price} DT" ,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),     Spacer(),
                    Row(
                      children: [Icon(Icons.add_location,color: Colors.grey,),
                        Container(width: size.width*.28,
                          child: Text(
                            "${ adverts.town.name } ${ adverts.city.name }" ,
                            softWrap: true,style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      adverts.modifiedAt,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
