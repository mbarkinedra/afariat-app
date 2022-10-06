import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/Environment.dart';
import '../config/utility.dart';
import '../home/tap_profile/favorite/favorite_view_controller.dart';
import '../networking/json/advert_minimal_json.dart';
import '../storage/AccountInfoStorage.dart';
import 'asbtract_advert_card.dart';
import 'favorite_icon.dart';

class AdvertCardList extends AbstractAdvertCard {
  AdvertCardList({Key key, AdvertMinimalJson advert, String userInitials})
      : super(key: key, advert: advert, userInitials: userInitials);
  FavoriteViewController favController = Get.find<FavoriteViewController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            Get.toNamed('/adDetails', parameters: {'id': advert.id.toString()}),
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
                          ? CachedNetworkImage(
                              imageUrl: advert.photo,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const Align(
                                          alignment: Alignment.center,
                                          child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/common/no-image.jpg",
                                fit: BoxFit.fill,
                              ),
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
                                          advert.modifiedAt ?? advert.createdAt,
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
                                      Expanded(
                                          flex: 8,
                                          child: Align(
                                            child: AdvertFavoriteIcon(
                                              advertId: advert.id,
                                              isLoggedIn:
                                                  Get.find<AccountInfoStorage>()
                                                      .isLoggedIn(),
                                              onAdd: () => favController
                                                  .addAdvertToFavorites(
                                                      advert.id),
                                              onDelete: () => favController
                                                  .removeAdvertFromFavorite(
                                                      advert.id),
                                            ),
                                            alignment: Alignment.bottomRight,
                                          ))
                                    ]),
                                const SizedBox(
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
