import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_succes.dart';
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
                CustomButtonWithoutIcon(
                  width: MediaQuery.of(context).size.width * .25,
                  height: 50,
                  label: "Modifier",
                  btcolor: buttonColor,
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
                  btcolor: buttonColor,
                  function: () {
                    controller.image = null;
                    controller.image2 = null;
                    controller.updatecategoryToNull();
                    controller.updateSubcategoryToNull();
                    Get.find<LocController>().updatecitieAndTowen();
                    controller.citie = null;
                    controller.price.clear();
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
