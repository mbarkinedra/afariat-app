import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Common/popup.dart';
import '../config/utility.dart';
import '../model/favorite_list.dart';

///A clickable favorite icon
class AdvertFavoriteIcon extends StatelessWidget {
  final int advertId;
  final bool isLoggedIn;
  final Function onDelete;
  final Function onAdd;

  const AdvertFavoriteIcon(
      {Key key, this.advertId, this.isLoggedIn, this.onDelete, this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Ink(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: () {
            if (isLoggedIn) {
              if (FavoriteList.has(advertId)) {
                onDelete();
              } else {
                onAdd();
              }
            } else {
              Popup.showAccessDenied(context, 'Vous devez être connecté pour ajouter cette annonce à vos favoris');
            }
          },
          customBorder: const CircleBorder(),
          splashColor: Colors.red[100],
          child: !isLoggedIn
              ? const Icon(Icons.favorite_outline_rounded, color: Colors.grey)
              : Obx(() => FavoriteList.has(advertId)
                  ? const Icon(
                      Icons.favorite_sharp,
                      color: Colors.pink,
                    )
                  : const Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.black87,
                    )),
        ),
      ),
    );
  }
}
