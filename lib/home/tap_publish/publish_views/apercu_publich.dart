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
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [

                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Text(
                  "Vérification",
                  style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold, fontSize: 25),
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
              data: controller.myAdsview["category"],
            ),
            CustomApercu(
              label: "Type d'annonce:",
              data: controller.myAdsview["advertType"],
            ),
            CustomApercu(
              label: "Titre:",
              data: controller.myAdsview["title"],
            ),
            CustomApercu(
              label: "Texte de l'annonce:",
              data: controller.myAdsview["description"],
            ),
            CustomApercu(
              label: "Commune:",
              data: controller.myAdsview["town"],
            ),
            CustomApercu(
              label: "Gouvernorat :",
              data: controller.myAdsview["city"],
            ),
            CustomApercu(
              label: "Téléphone:",
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
                  children:controller.images.map((e) =>  Container(
                    width: 100,
                    height: 100,
                    child: Image.file(
                    e,
                      fit: BoxFit.fill,
                    ),
                  )).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithoutIcon(
                  width: MediaQuery.of(context).size.width * .25,
                  height: 50,
                  label: "Modifier",
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
                  btcolor: Colors.red,
                  function: () {
                    controller.images.clear();

                    controller.updatecategoryToNull();
                    controller.updateSubcategoryToNull();
                    Get.find<LocController>().updatecitieAndTowen();
                    controller.citie = null;
                    controller.prix.clear();
                    controller.description.clear();
                    controller.title.clear();
                    controller.myAds = {};
                    controller.category = null;
                    controller.updatecategory(null);
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
                    btcolor: Colors.green,
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
