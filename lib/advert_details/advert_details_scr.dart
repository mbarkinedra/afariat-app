import 'package:afariat/config/utilitie.dart';
import 'package:afariat/model/error_register.dart';

import 'package:afariat/mywidget/custom_button_icon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:email_launcher/email_launcher.dart'as mail;
import 'package:url_launcher/url_launcher.dart';
import 'advert_details_viewcontroller.dart';

class AdvertDetatilsScr extends GetView<AdvertDetailsViewcontroller> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    //
    return GetBuilder<AdvertDetailsViewcontroller>(builder: (logic) {
      return logic.loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(onTap: (){
                          Navigator.pop(context);
                        },child: Icon(Icons.arrow_back_ios,)),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Annonce détaillée",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      ],
                    ), SizedBox(height: 20),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: _size.height * .3,
                        viewportFraction: .7,
                        aspectRatio: 9 / 12,
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      items: logic.advert.photos
                          .map((item) => Container(
                                child: Center(
                                    child: Image.network(
                                  item.path,
                                  fit: BoxFit.cover,
                                  width: _size.width * .7,
                                  height: _size.height * .3,
                                )),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(width: _size.width*.5,
                          child: Text(logic.advert.title.toString(),overflow:   TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Spacer(),
                        Icon(Icons.add_location),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                            "${logic.advert.town.name} ${logic.advert.city.name}")
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${logic.advert.price} DT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Ajouter description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(
                      height: 8,
                    ),
                    Text(logic.advert.description,
                        style: TextStyle(fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (logic.havephonenumber())
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
                            if (logic.havephonenumber())
                              CustomButtonIcon(
                                btcolor: buttonColor,
                                function: () {
                                  logic.makesms(logic.advert.mobilePhoneNumber);
                                },
                                height: 40,
                                width: _size.width * .2,
                                icon: Icons.message,
                              ),
                            CustomButtonIcon(
                              btcolor: buttonColor,
                              function: ()async {


logic.showd(context);

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
    });
  }
}
