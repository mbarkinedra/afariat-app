import 'package:afariat/home/tap_home/favorite/favorite_viewController.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/storage/AccountInfoStorage.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';

import 'package:afariat/mywidget/custom_button_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'advert_details_viewcontroller.dart';

class AdvertDetailsScr extends GetView<AdvertDetailsViewcontroller> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final numberFormat = NumberFormat("###,##0", SettingsApp.locale);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: framColor,
        title: Text(
          "Annonce détaillée",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: GetBuilder<AdvertDetailsViewcontroller>(builder: (logic) {
        //  logic.advert.userId

        /*if (!logic.loading) {
          print(logic.advert.photos.length);
          print(logic.advert.is_favorite);
        }*/

        return logic.loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 40, right: 8, left: 8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //   SizedBox(height: 20),
                      if (logic.advert.photos != null)
                        logic.advert.photos.length > 1
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  height: _size.height * .3,
                                  viewportFraction: .7,
                                  aspectRatio: 9 / 12,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                ),
                                items: logic.advert.photos
                                    .map((item) => InkWell(
                                          onTap: () {
                                            logic.displayDialogue(context);
                                          },
                                          child: Image.network(
                                            item.path,
                                            height: _size.height * .25,
                                            width: _size.width * .8,
                                            fit: BoxFit.fill,
                                          ),
                                        ))
                                    .toList(),
                              )
                            : logic.advert.photos.length > 0
                                ? InkWell(
                                    onTap: () {
                                      logic.displayDialogue(context);
                                    },
                                    child: Container(
                                      height: _size.height * .3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  logic.advert.photos[0].path),
                                              fit: BoxFit.fill)),
                                    ),
                                  )
                                : SizedBox(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: _size.width * .8,
                            child: Text(
                              logic.advert.title.toString(),
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if (Get.find<AccountInfoStorage>()
                                    .isLoggedIn()) {
                                  if (Get.find<TapHomeViewController>()
                                      .favorites
                                      .contains(logic.advert.id)) {
                                    Get.find<FavoriteViewController>()
                                        .deleteFavoriteByAdvert(
                                            logic.advert.id);
                                    Get.find<TapHomeViewController>()
                                        .deleteFromFavoritesList(
                                            logic.advert.id);

                                    Get.find<FavoriteViewController>()
                                        .getFavorite();
                                    controller.update();
                                  } else {
                                    Get.find<FavoriteViewController>()
                                        .addToMyFavorite(logic.advert.id);
                                    Get.find<TapHomeViewController>()
                                        .addToFavoritesList(logic.advert.id);
                                    controller.update();
                                    // controller.update();
                                  }
                                } else {
                                  Get.snackbar("",
                                      "Veuillez vous connecter pour rajouter cette annonce à vos favoris",
                                      colorText: Colors.white,
                                      backgroundColor: buttonColor);
                                }
                              },
                              child: Icon(
                                Get.find<TapHomeViewController>()
                                        .favorites
                                        .contains(logic.advert.id)
                                    ? Icons.favorite
                                    : Icons.favorite_outline_rounded,
                                color: Get.find<AccountInfoStorage>()
                                            .isLoggedIn() ||
                                        Get.find<TapHomeViewController>()
                                            .favorites
                                            .contains(logic.advert.id)
                                    ? Colors.red
                                    : Colors.grey,
                              ))
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${logic.advert.town.name}, ${logic.advert.city.name}",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                          numberFormat.format(logic.advert.price) +
                              ' ' +
                              SettingsApp.moneySymbol,
                          style: TextStyle(
                              color: framColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 29)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Catégorie",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: _size.width * .8,
                        child: Text(logic.advert.category.name,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                      if (logic.advert.roomsNumber != null)
                        Row(
                          children: [
                            Text(
                              "Nombre de chambre : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.roomsNumber.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.vehicleBrand != null)
                        Row(
                          children: [
                            Text(
                              "Marque : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.vehicleBrand.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.motoBrand != null)
                        Row(
                          children: [
                            Text(
                              "Marque : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.motoBrand.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.vehicleModel != null)
                        Row(
                          children: [
                            Text(
                              "Modèle : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.vehicleModel.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.yearModel != null)
                        Row(
                          children: [
                            Text(
                              "Année : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.yearModel.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.energy != null)
                        Row(
                          children: [
                            Text(
                              "Energie : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.energy.value}",
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      if (logic.advert.mileage != null)
                        Row(
                          children: [
                            Text(
                              "Kilométrage: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              "${logic.advert.mileage.value}",
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: _size.width * .8,
                        child: Text(logic.advert.description,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (logic.havePhoneNumber())
                                CustomButtonIcon(
                                  btcolor: buttonColor,
                                  function: () {
                                    logic.makePhoneCall(
                                        logic.advert.mobilePhoneNumber);
                                  },
                                  height: 40,
                                  width: _size.width * .2,
                                  icon: Icons.add_call,
                                ),
                              if (logic.havePhoneNumber())
                                CustomButtonIcon(
                                  btcolor: buttonColor,
                                  function: () {
                                    logic.makeSms(
                                        logic.advert.mobilePhoneNumber);
                                  },
                                  height: 40,
                                  width: _size.width * .2,
                                  icon: Icons.message,
                                ),
                              CustomButtonIcon(
                                btcolor: buttonColor,
                                function: () async {
                                  if (controller.advert.isRegistredUser &&
                                      Get.find<AccountInfoStorage>()
                                              .readUserId() !=
                                          null) {
                                    controller.showDialogue(context);
                                  }
                                },
                                height: 40,
                                width: _size.width * .2,
                                icon: Icons.markunread,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
