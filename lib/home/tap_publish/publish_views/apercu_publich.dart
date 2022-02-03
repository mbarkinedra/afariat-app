import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_apercu.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
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
          children: [
            Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Text(
                  "Vérification",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            CustomApercu(
              label: "Catégorie:",
              data: controller.myAdsView["category"],
            ),
            CustomApercu(
              label: "Type d'annonce:",
              data: controller.myAdsView["advertType"],
            ),
            CustomApercu(
              label: "Titre:",
              data: controller.myAdsView["title"],
            ),
            CustomApercu(
              label: "Texte de l'annonce:",
              data: controller.myAdsView["description"],
            ),
            CustomApercu(
              label: "Commune:",
              data: controller.myAdsView["town"],
            ),
            CustomApercu(
              label: "Gouvernorat :",
              data: controller.myAdsView["city"],
            ),
            CustomApercu(
              label: "Afficher N° Tél:",
              data: controller.myAdsView["showPhoneNumber"],
            ),
            Column(
              children: controller.myAdsView.entries.map((entry) {
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
                  children: controller.images
                      .map((e) => Container(
                            width: 100,
                            height: 100,
                            child: Image.file(
                              e,
                              fit: BoxFit.fill,
                            ),
                          ))
                      .toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithoutIcon(
                  width: MediaQuery.of(context).size.width * .25,
                  height: 50,
                  label: "Modifier",
                  labcolor: Colors.white,
                  btcolor: Colors.blue,
                  function: () {
                    int count = 0;

                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  },
                ),
                CustomButtonWithoutIcon(
                  width: MediaQuery.of(context).size.width * .25,
                  height: 50,
                  label: "Supprimer",
                  labcolor: Colors.white,
                  btcolor: Colors.red,
                  function: () {
                    controller.images.clear();

                    controller.updateCategoryToNull();
                    controller.updateSubcategoryToNull();
                    Get.find<LocController>().updateCityAndTown();
                    controller.citie = null;
                    controller.prix.clear();
                    controller.description.clear();
                    controller.title.clear();
                    controller.myAds = {};
                    controller.category = null;
                    controller.updateCategory(null);
                    controller.energies = [];
                    controller.energie = "";
                    controller.kilometrage = null;
                    controller.lights = false;
                    controller.motosBrand = null;
                    controller.vehiculebrands = null;

                    int count = 0;

                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });
                  },
                ),
                CustomButtonWithoutIcon(
                    width: MediaQuery.of(context).size.width * .25,
                    height: 50,
                    label: "Publier",
                    labcolor: Colors.white,
                    btcolor: Colors.green,
                    function: () {
                      controller.postdata();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
