import 'package:afariat/advert_details/advert_details_scr.dart';
import 'package:afariat/advert_details/advert_details_viewcontroller.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/networking/api/get_salt_api.dart';
import 'package:afariat/networking/json/adverts_json.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'favorite_viewController.dart';

class Favorite extends GetView<FavoriteViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Mes favoris",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: framColor,
        leading: IconButton(
            icon: Icon(
              //
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: GetBuilder<FavoriteViewController>(builder: (logic) {
        return logic.favoriteJson == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : logic.favoriteJson.eEmbedded.favorites.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 175,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text("Vous n'avez encore d'annonces favoris.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    itemCount:
                        logic.favoriteJson.eEmbedded.favorites.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return SingleAdvert(
                        favorite: logic.favoriteJson.eEmbedded.favorites[index],
                      );
                    });
      }),
    );
  }
}

class SingleAdvert extends StatelessWidget {
  final numberFormat = NumberFormat("###,##0", SettingsApp.locale);

  final Size size;
  final Favorites favorite;

  SingleAdvert({this.size, this.favorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<AdvertDetailsViewcontroller>()
            .getAdvertDetails(favorite.advert.id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdvertDetatilsScr()));
      },
      child: new Container(
        margin: EdgeInsets.all(5),
        //   height: 400.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () {
                print("delete favorite");
                Get.find<TapHomeViewController>()
                    .favorites
                    .remove(favorite.advert.id);
                Get.find<TapHomeViewController>().update();
                Get.find<FavoriteViewController>().idItemDelete =
                    favorite.advert.id;
                Get.find<FavoriteViewController>().deleteFavorite(favorite.id);
              },
              child: Container(
                alignment: Alignment.topRight,
                child: Get.find<FavoriteViewController>().idItemDelete ==
                        favorite.advert.id
                    ? CircularProgressIndicator()
                    : Icon(
                        Icons.delete,
                        color: framColor,
                      ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: favorite.advert.photo != null
                    ? Image.network(
                        favorite.advert.photo,
                        fit: BoxFit.fill,
                      )
                    : Image.asset("assets/images/no-image.jpg"),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: new Text(
                favorite.advert.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Row(
              children: [
                Text(
                  numberFormat.format(favorite.advert.price) +
                      ' ' +
                      SettingsApp.moneySymbol,
                  style: TextStyle(
                      color: framColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                // Expanded(child: Text("")),
                // Text("1"/*adverts.id.toString()*/),
                // Icon(Icons.star_border, color: Colors.yellow)
              ],
            )
          ],
        ),
      ),
    );
  }
}
