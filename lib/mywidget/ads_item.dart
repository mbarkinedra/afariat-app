import 'package:afariat/config/utility.dart';

import 'package:afariat/networking/json/my_ads_json.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../config/Environment.dart';

class AdsItem extends StatelessWidget {
  final Size size;
  final Adverts adverts;
  final Function deleteAds;
  final Function editAds;
  final numberFormat = NumberFormat("###,##0", Environment.locale);

  AdsItem({Key key, this.size, this.adverts, this.deleteAds, this.editAds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: editAds,
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
                    : Image.asset("assets/images/common/no-image.jpg"),
              ),
              const SizedBox(
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                     const Spacer(),
                     Container(
                           width: 140,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30.0)),
                              color: adverts.status == 0
                                  ? const Color(0xFFFFEBC2)
                                  : adverts.status == 1
                                  ? const Color(0xFFD0F0FB)
                                  : const Color(0xFFC7F5D9),
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Text(
                                  adverts.status == 0
                                      ? 'Incomplète'
                                      : adverts.status == 1
                                          ? 'En cours de validation'
                                          : 'Publiée',
                                  style: TextStyle(
                                    color:adverts.status == 0
                                        ? const Color(0xFF453008)
                                        : adverts.status == 1
                                        ? const Color(0xFF084154)
                                        : const Color(0xFF0B4121),
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                            ),
                          )
                     ,
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          numberFormat.format(adverts.price) +
                              ' ' +
                              Environment.currencySymbol,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: framColor,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        adverts.modifiedAt,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          InkWell(
                            onTap: deleteAds,
                            child: const Icon(
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
