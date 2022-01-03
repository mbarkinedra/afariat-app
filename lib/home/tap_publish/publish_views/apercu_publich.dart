import 'package:afariat/config/utilitie.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_succes.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_apercu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApercuPublich extends GetWidget<TapPublishViewController> {
  final categoryAndSubcategory = Get.find<CategoryAndSubcategory>();
  final locController = Get.find<LocController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.menu),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Text(
                  "Apercu",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ],
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            CustomApercu(
              label: "Category",
              data: controller.myAdsview["category"],
            ),
            CustomApercu(
              label: "AdvertType",
              data: controller.myAdsview["advertType"],
            ),
            CustomApercu(
              label: "title",
              data: controller.myAdsview["title"],
            ),
            CustomApercu(
              label: "description",
              data: controller.myAdsview["description"],
            ),
            CustomApercu(
              label: "Town",
              data: controller.myAdsview["town"],
            ),
            CustomApercu(
              label: "city",
              data: controller.myAdsview["city"],
            ),
            CustomApercu(
              label: "showphonenumber",
              data: controller.myAdsview["showPhoneNumber"],
            ),
            Column(
              children: controller.myAdsview.entries.map((entry) {
                if (entry.key == "category" ||
                    entry.key == "title" ||
                    entry.key == "advertType" ||
                    entry.key == "description" ||
                    entry.key == "town" ||
                    entry.key == "city" ||
                    entry.key == "showPhoneNumber") {
                  return SizedBox();
                } else {
                  return CustomApercu(
                    label: entry.key,
                    data: entry.value.toString(),
                  );
                }
              }).toList(),
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (controller.image != null)
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.file(
                          controller.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    if (controller.image2 != null)
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.file(
                          controller.image2,
                          fit: BoxFit.fill,
                        ),
                      ),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  width: MediaQuery.of(context).size.width * .4,
                  height: 50,
                  label: "Edit",
                  btcolor: buttonColor,
                  function: () {},
                ),
                CustomButton(
                    width: MediaQuery.of(context).size.width * .4,
                    height: 50,
                    label: "Publish",
                    btcolor: buttonColor,
                    function: () {
                      controller.postdata();
                    }

                    //Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (
                    // context,
                    //    ) =>
                    //   PublishSucces())
                    //  );

                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//
// CustomApercu(
// label: "Catégorie",
// data: controller.category.name,
// ),
// CustomApercu(
// label: "Subcategorie",
// data: controller.subcategories.name,
// ),
// CustomApercu(
// label: "Type d'annonce",
// data: controller.advertType,
// ),
// CustomApercu(
// label: "Marque",
// data: controller.vehiculebrands.name,
// ),
// CustomApercu(
// label: "Modéle",
// data: controller.vehiculeModel.name,
// ),
// if (controller.motosBrand != null)
// CustomApercu(
// label: "Marque",
// data: controller.motosBrand.name,
// ),
// CustomApercu(
// label: "Kilométrage",
// data: controller.kelometrage.name,
// ),
// CustomApercu(
// label: "Année",
// data: controller.yersmodele.name,
// ),
// if (controller.pieces != null)
// CustomApercu(
// label: "Nombre de piéce",
// data: controller.pieces,
// ),
// if (controller.surface.text.isNotEmpty)
// CustomApercu(
// label: "Surface",
// data: controller.surface.text,
// ),
// CustomApercu(
// label: "Prix",
// data: controller.price.text,
// ),
// CustomApercu(
// label: "Gouvernorat",
// data: locController.citie.name,
// ),
// CustomApercu(
// label: "Ville",
// data: locController.town.name,
// ),
// CustomApercu(
// label: "Title",
// data: controller.title.text,
// ),
// CustomApercu(
// label: "Description",
// data: controller.description.text,
// ),
// CustomApercu(
// label: "Afficher Tel",
// data: controller.lights ? "Yes" : "No",
// ),
