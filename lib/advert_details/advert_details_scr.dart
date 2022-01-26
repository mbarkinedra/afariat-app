import 'dart:math';

import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/model/error_register.dart';

import 'package:afariat/mywidget/custom_button_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:email_launcher/email_launcher.dart' as mail;
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';
import 'advert_details_viewcontroller.dart';
import 'package:photo_view/photo_view.dart';

class AdvertDetatilsScr extends GetView<AdvertDetailsViewcontroller> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Détails de l'annonce",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: GetBuilder<AdvertDetailsViewcontroller>(builder: (logic) {
        return logic.loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CarouselSlider(
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
                                    logic.displayDialog(context);
                                  },
                                  child: Image.network(
                                    item.path,
                                    height: _size.height * .25,
                                    width: _size.width * .8,
                                    fit: BoxFit.fill,
                                  ),
                                ))
                            .toList(),
                      ),
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
                      Text("${logic.advert.price} " + SettingsApp.moneySymbol,
                          style: TextStyle(
                              color: Colors.deepOrange,
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
                              "Modéle : ",
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
                      Text("Ajouter description",
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
                                  logic.showDialogue(context);
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
