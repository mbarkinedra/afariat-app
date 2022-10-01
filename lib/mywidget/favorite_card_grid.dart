import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../config/Environment.dart';
import '../config/utility.dart';
import '../home/tap_profile/favorite/favorite_view_controller.dart';
import '../networking/json/advert_minimal_json.dart';
import '../networking/json/favorite_json.dart';

class FavoriteCardGrid extends StatelessWidget {
  final FavoriteJson favoriteJson;
  AdvertMinimalJson advert;
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  final FavoriteViewController controller;
  final int index;

  FavoriteCardGrid({Key key, this.favoriteJson, this.controller, this.index})
      : super(key: key) {
    advert = favoriteJson.advert;
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            Get.toNamed('/adDetails', parameters: {'id': advert.id.toString()}),
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Container(
                  //height: size.height * .2,
                  child: advert.photo != null
                      ? CachedNetworkImage(
                          imageUrl: advert.photo,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => const Align(
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
              ListTile(
                minLeadingWidth: 10,
                title: Text(
                  advert.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
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
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
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
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              //const Divider(thickness: 0.5),
              Row(children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        numberFormat.format(advert.price) +
                            ' ' +
                            Environment.currencySymbol,
                        style: const TextStyle(
                            color: blackcolore,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )),
                ),
                Expanded(
                    flex: 2,
                    child: Obx(() => controller.isDeleting.isTrue
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              controller.removeFavoriteAdvert(
                                  favoriteJson, index);
                            },
                            child: const Icon(Icons.delete),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(3),
                              backgroundColor: Colors.red, // <-- Button color
                              foregroundColor: Colors.white, // <-- Splash color
                            ),
                          ))
                    //Icon(Icons.delete, color: Colors.red,)
                    )
              ]),
              const SizedBox(
                height: 10,
              ),
            ])));
  }
}
