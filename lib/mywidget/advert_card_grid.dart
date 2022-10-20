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
  AdvertCardGrid(
      {Key key,
      AdvertMinimalJson advert,
      double imageHeight,
      double imageWidth})
      : super(
          key: key,
          advert: advert,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
        );
  FavoriteViewController favController = Get.find<FavoriteViewController>();

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRouting.adDetails,
            parameters: {'id': advert.id.toString()});
        //TODO: NOTE: dont remove this because we get a lot of shit oc scroll attached to multi views. Until now no way to resolve it without destroying the controller
        Get.delete<SimilarAdvertsViewController>();
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: imageHeight,
                  width: imageWidth,
                  child: (advert.photo != null)
                      ? CachedNetworkImage(
                          imageUrl: advert.photo,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => const Align(
                            alignment: Alignment.center,
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/common/no-image.jpg",
                            fit: BoxFit.cover,
                          ),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/common/no-image.jpg",
                          fit: BoxFit.fill,
                        ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: AdvertFavoriteIcon(
                    advertId: advert.id,
                    isLoggedIn: Get.find<AccountInfoStorage>().isLoggedIn(),
                    onAdd: () => favController.addAdvertToFavorites(advert.id),
                    onDelete: () =>
                        favController.removeAdvertFromFavorite(advert.id),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, right: 5, bottom: 0, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    advert.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            advert.town.name +
                                (advert.town.zipCode != null
                                    ? ' ' + advert.town.zipCode
                                    : ''),
                            softWrap: true,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
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
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
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
                  Text(
                    numberFormat.format(advert.price) +
                        ' ' +
                        Environment.currencySymbol,
                    style: const TextStyle(
                        color: framColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
