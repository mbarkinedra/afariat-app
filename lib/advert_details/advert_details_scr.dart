import 'package:afariat/advert_details/contact_email.dart';
import 'package:afariat/config/utilitie.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'title ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Prix ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.price.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Annonceur ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.price.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Catégorie ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.category.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Ville ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.city.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Adresse ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.region.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Nombre de piece ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.id.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'description ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                                text: logic.advert.description,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    btcolor: buttonColor,
                                    labcolor: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    function: () {},
                                    height: 40,
                                    width: _size.width * .2,
                                    label: "",
                                    icon: Icons.add_call,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              CustomButton(
                                btcolor: buttonColor,
                                labcolor: Colors.white,
                                fontWeight: FontWeight.bold,
                                function: () {},
                                height: 40,
                                width: _size.width * .2,
                                label: "",

                                icon: Icons.message,
                              ),
                              SizedBox(height: 5),
                              CustomButton(
                                btcolor: buttonColor,
                                labcolor: Colors.white,
                                fontWeight: FontWeight.bold,
                                function: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ContactEmail()),
                                  );
                                },
                                height: 40,
                                width: _size.width * .2,
                                label: "",
                                icon: Icons.markunread,
                              ),
                            ],
                          ),
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
