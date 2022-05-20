import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';

import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AdsItem extends StatelessWidget {
  final Size size;
  final Adverts adverts;
  final Function deleteAds;
  final Function editAds;
  final numberFormat = NumberFormat("###,##0", SettingsApp.locale);

  AdsItem({this.size, this.adverts, this.deleteAds, this.editAds});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: editAds,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: size.height * .28,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: adverts.photo != null
                    ? Image.network(
                        adverts.photo,
                        height: size.height * .25,
                        width: size.width * .4,
                        fit: BoxFit.fill,
                      )
                    : Image.asset("assets/images/no-image.jpg"),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        adverts.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          numberFormat.format(adverts.price) +
                              ' ' +
                              SettingsApp.moneySymbol,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: framColor,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        adverts.modifiedAt,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          InkWell(
                            onTap: deleteAds,
                            child: Icon(
                              Icons.delete,
                              color: framColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
