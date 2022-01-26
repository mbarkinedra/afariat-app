import 'package:afariat/home/tap_myads/tap_myads_viewcontroller.dart';
import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AdsItem extends StatelessWidget {
  final Size size;
  Adverts adverts;
  Function deleteAds;
  Function EditAds;

  AdsItem({this.size, this.adverts, this.deleteAds, this.EditAds});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        height: size.height * .35,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                adverts.photo,
                height: size.height * .35,
                width: size.width * .4,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      adverts.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      adverts.description,
                      maxLines: 6,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "${adverts.price} DT",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<TapMyadsViewController>(builder: (logic) {
                          return logic.deleteData
                              ? CircularProgressIndicator()
                              : InkWell(
                                  onTap: deleteAds,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.deepOrange,
                                  ));
                        }),
                        InkWell(
                          onTap: EditAds,
                          child: Icon(
                            Icons.edit,
                            color: Colors.deepOrange,
                          ),
                        )
                      ],
                    ),
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
