import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_home/favorite/favorite_viewController.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../config/Environment.dart';

class MyHomeItem extends StatelessWidget {
  final Size size;

  MyHomeItem({this.size, this.adverts});

  final AdvertJson adverts;

  final numberFormat = NumberFormat("###,##0", Environment.locale);

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
                child: adverts.photo != null
                    ? Image.network(
                        adverts.photo,
                        fit: BoxFit.fill,
                      )
                    : Image.asset("assets/images/common/no-image.jpg"),
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
                          Environment.currencySymbol,
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
                            if (Get.find<AccountInfoStorage>().isLoggedIn()) {
                              if (Get.find<TapHomeViewController>()
                                  .favorites
                                  .contains(adverts.id)) {
                                Get.find<FavoriteViewController>()
                                    .deleteFavoriteByAdvert(adverts.id);
                                Get.find<TapHomeViewController>()
                                    .deleteFromFavoritesList(adverts.id);
                              } else {
                                Get.find<FavoriteViewController>()
                                    .addToMyFavorite(adverts.id);
                                Get.find<TapHomeViewController>()
                                    .addToFavoritesList(adverts.id);
                              }
                            } else {
                              Get.snackbar("Connexion requise",
                                  "Veuillez vous connecter pour enregistrer cette annonce dans vos favoris",
                                  colorText: Colors.white,
                                  backgroundColor: buttonColor);
                            }
                          },
                          child: Icon(
                            Get.find<TapHomeViewController>()
                                        .favorites
                                        .contains(adverts.id) ||
                                    adverts.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline_rounded,
                            color:
                                Get.find<AccountInfoStorage>().isLoggedIn() ||
                                        Get.find<TapHomeViewController>()
                                            .favorites
                                            .contains(adverts.id) ||
                                        adverts.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
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
