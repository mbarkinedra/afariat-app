import 'package:afariat/mywidget/asbtract_advert_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/Environment.dart';
import '../config/app_routing.dart';
import '../config/utility.dart';
import '../home/search/similar_adverts_viewcontroller.dart';
import '../home/tap_profile/favorite/favorite_view_controller.dart';
import '../networking/json/advert_minimal_json.dart';
import '../storage/AccountInfoStorage.dart';
import 'favorite_icon.dart';

class AdvertCardGrid extends AbstractAdvertCard {
  AdvertCardGrid({Key key, AdvertMinimalJson advert, String userInitials})
      : super(key: key, advert: advert, userInitials: userInitials);
  FavoriteViewController favController = Get.find<FavoriteViewController>();

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRouting.adDetails, parameters: {'id': advert.id.toString()});
          //TODO: NOTE: dont remove this because we get a lot of shit oc scroll attached to multi views. Until now no way to resolve it without destroying the controller
          Get.delete<SimilarAdvertsViewController>();
        },
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
                leading: CircleAvatar(
                  maxRadius: 12,
                  backgroundColor: Colors.blueGrey.shade50,
                  child: Text(
                    userInitials,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade900),
                  ),
                ),
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
                            color: framColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )),
                ),
                Expanded(
                    flex: 2,
                    child: AdvertFavoriteIcon(
                      advertId: advert.id,
                      isLoggedIn: Get.find<AccountInfoStorage>().isLoggedIn(),
                      onAdd: () =>
                          favController.addAdvertToFavorites(advert.id),
                      onDelete: () =>
                          favController.removeAdvertFromFavorite(advert.id),
                    ))
              ]),
              const SizedBox(
                height: 10,
              ),
            ])));
  }
}
