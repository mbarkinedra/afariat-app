import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomeItem extends StatelessWidget {
  final Size size;

  MyHomeItem({this.size, this.adverts});

  final AdvertJson adverts;

  final numberFormat = NumberFormat("###,##0", SettingsApp.locale);
  bool isFavorite = false;

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
        height: size.height * .26,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: size.height * .2,
                child:adverts.photo!=null? Image.network(

                  adverts.photo,
                  fit: BoxFit.fill,
                ):   Image.asset("assets/images/no-image.jpg"),
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
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      numberFormat.format(adverts.price) +
                          ' ' +
                          SettingsApp.moneySymbol,
                      style: TextStyle(
                          color: framColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 18,
                        ),
                        Container(
                          width: size.width * .28,
                          child: Text(
                            "${adverts.town.name}, ${adverts.city.name}",
                            softWrap: true,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          adverts.modifiedAt,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        InkWell(
                          onTap: () {
                            print("ajouter favoris");
                            isFavorite != isFavorite;
                          },
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_outline_rounded
                                : Icons.favorite,
                            color: Colors.redAccent,
                          ),
                        )
                      ],
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
