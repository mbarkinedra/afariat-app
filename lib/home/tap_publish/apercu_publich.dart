import 'package:afariat/config/utilitie.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/publish_succes.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_apercu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApercuPublich extends GetWidget<TapPublishViewController> {
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
              label: "Catégorie",
              data: Get.find<CategoryAndSubcategory>().categoryGroupedJson.name,
            ),
            CustomApercu(
              label: "Subcategorie",
              data: Get.find<CategoryAndSubcategory>().subcategories1.name,
            ),
            CustomApercu(
              label: "Type d'annonce",
              data: controller.advertType,
            ),
            CustomApercu(
              label: "Marque",
              data: controller.vehiculebrands.name,
            ),
            CustomApercu(
              label: "Modéle",
              data: controller.vehiculeModel.name,
            ),
            if (controller.motosBrand != null)
              CustomApercu(
                label: "Marque",
                data: controller.motosBrand.name,
              ),
            CustomApercu(
              label: "Kilométrage",
              data: controller.kelometrage.name,
            ),
            CustomApercu(
              label: "Année",
              data: controller.yersmodele.name,
            ),
            if (controller.pieces != null)
              CustomApercu(
                label: "Nombre de piéce",
                data: controller.pieces,
              ),
            if (Get.find<TapPublishViewController>().surface.text.isNotEmpty)
              CustomApercu(
                label: "Surface",
                data: Get.find<TapPublishViewController>().surface.text,
              ),
            CustomApercu(
              label: "Prix",
              data: Get.find<TapPublishViewController>().price.text,
            ),
            CustomApercu(
              label: "Gouvernorat",
              data: Get.find<LocController>().citie.name,
            ),
            CustomApercu(
              label: "Ville",
              data: Get.find<LocController>().town.name,
            ),
            CustomApercu(
              label: "Title",
              data: controller.title.text,
            ),
            CustomApercu(
              label: "Description",
              data: controller.description.text,
            ),
            CustomApercu(
              label: "Afficher Tel",
              data: Get.find<TapPublishViewController>().lights ? "Yes" : "No",
            ),
            Divider(
              color: Colors.black,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  function: () {
                  },
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width * .4,
                  height: 50,
                  label: "Publish",
                  btcolor: buttonColor,
                  function: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (
                            context,
                            ) =>
                            PublishSucces()));
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
