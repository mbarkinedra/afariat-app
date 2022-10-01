import 'package:afariat/config/utility.dart';
import 'package:afariat/networking/json/favorite_json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../config/Environment.dart';
import 'favorite_view_controller.dart';

class FavoriteView extends GetView<FavoriteViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          " Mes favoris",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: framColor,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      body: GetBuilder<FavoriteViewController>(builder: (logic) {
        return logic.favoriteJson == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : logic.favoriteJson.eEmbedded.favorites.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
  final numberFormat = NumberFormat("###,##0", Environment.locale);

  final Size size;
  final Favorites favorite;

  SingleAdvert({this.size, this.favorite});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* TODO: call the route instead
        Get.find<AdvertDetailsViewController>()
            .getAdvertDetails(favorite.advert.id);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdvertDetailsScr()));*/
      },
      child: Container(
        margin: const EdgeInsets.all(5),
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
                /*Get.find<TapHomeViewController>()
                    .favorites
                    .remove(favorite.advert.id);*/
                //Get.find<TapHomeViewController>().update();
                Get.find<FavoriteViewController>().idItemDelete =
                    favorite.advertLink.id;
                Get.find<FavoriteViewController>().deleteFavorite(favorite.id);
              },
              child: Container(
                alignment: Alignment.topRight,
                child: Get.find<FavoriteViewController>().idItemDelete ==
                        favorite.advertLink.id
                    ? const CircularProgressIndicator()
                    : const Icon(
                        Icons.delete,
                        color: framColor,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: favorite.advertLink.photo != null
                    ? CachedNetworkImage(
                        imageUrl: favorite.advertLink.photo,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => const Align(
                                alignment: Alignment.center,
                                child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/common/no-image.jpg",
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.asset("assets/images/common/no-image.jpg"),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: Text(
                favorite.advertLink.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Row(
              children: [
                Text(
                  numberFormat.format(favorite.advertLink.price) +
                      ' ' +
                      Environment.currencySymbol,
                  style: const TextStyle(
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
