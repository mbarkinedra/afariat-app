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
  bool iconShadow;
  Color _offIconColor;
  Color _onIconColor = Colors.white;
  Color _onLikedIconColor = Colors.pink;

  double _iconSize;

  AdvertFavoriteIcon({
    Key key,
    this.advertId,
    this.isLoggedIn,
    this.onDelete,
    this.onAdd,
    this.iconShadow = true,
    Color offIconColor,
    Color onIconColor,
    Color onLikedIconColor,
    double iconSize,
  }) : super(key: key) {
    _offIconColor = offIconColor ?? Colors.grey;
    _onIconColor = onIconColor ?? Colors.white;
    _onLikedIconColor = onLikedIconColor ?? Colors.pink;
    _iconSize = iconSize ?? 36;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Ink(
        width: 30,
        height: 30,
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
              Popup.showAccessDenied(context,
                  'Vous devez être connecté pour ajouter cette annonce à vos favoris');
            }
          },
          customBorder: const CircleBorder(),
          splashColor: Colors.red[100],
          child: !isLoggedIn
              ? Icon(
                  Icons.favorite_outline_rounded,
                  color: _offIconColor,
                  size: _iconSize,
                  shadows: iconShadow
                      ? <Shadow>[Shadow(color: Colors.grey, blurRadius: 15.0)]
                      : null,
                )
              : Obx(
                  () => FavoriteList.has(advertId)
                      ? Icon(
                          Icons.favorite_sharp,
                          color: _onLikedIconColor,
                          size: _iconSize,
                          shadows: iconShadow
                              ? <Shadow>[
                                  Shadow(color: Colors.grey, blurRadius: 15.0)
                                ]
                              : null,
                        )
                      : Icon(
                          Icons.favorite_outline_rounded,
                          color: _onIconColor,
                          size: _iconSize,
                          shadows: iconShadow
                              ? <Shadow>[
                                  Shadow(color: Colors.grey, blurRadius: 15.0)
                                ]
                              : null,
                        ),
                ),
        ),
      ),
    );
  }
}
