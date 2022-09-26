import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/Environment.dart';
import '../config/utility.dart';
import '../networking/json/adverts_json.dart';
import 'asbtract_advert_card.dart';

class AdvertCardList extends AbstractAdvertCard {
  AdvertCardList({Key key, AdvertJson advert, String userInitials})
      : super(key: key, advert: advert, userInitials: userInitials);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.toNamed('/ad-details',parameters: {'id': advert.id.toString()}),
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      //height: size.height * .2,
                      child: advert.photo != null
                          ? Image.network(
                              advert.photo,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              "assets/images/common/no-image.jpg",
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: ListTile(
                                title: Text(
                                  advert.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                subtitle: Text(
                                  advert.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              )),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          advert.town.name,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          advert.modifiedAt,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        numberFormat.format(advert.price) +
                                            ' ' +
                                            Environment.currencySymbol,
                                        style: const TextStyle(
                                            color: framColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      )),
                                ]),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CircleAvatar(
                                          maxRadius: 12,
                                          backgroundColor:
                                              Colors.blueGrey.shade50,
                                          child: Text(
                                            userInitials,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Colors.blueGrey.shade900),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                          flex: 8,
                                          child: Align(
                                            child: Icon(
                                                Icons.favorite_outline_rounded),
                                            alignment: Alignment.bottomRight,
                                          ))
                                    ]),
                                SizedBox(
                                  height: 10,
                                )
                              ])),
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
