import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/custom_apercu.dart';
import 'package:afariat/mywidget/custom_apercu_description.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/Environment.dart';

class ApercuPublich extends GetWidget<TapPublishViewController> {
  final categoryAndSubcategory = Get.find<CategoryAndSubcategory>();
  final locController = Get.find<LocController>();
  final numberFormat = NumberFormat("###,##0", Environment.locale);

  RxBool isCguAccepted = false.obs;
  RxBool error = false.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 130,
                ),
                SizedBox(height: 100),
                Expanded(
                    child: Text(
                  "Vérification",
                  style: TextStyle(
                      color: framColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20),
              child: Divider(
                color: Colors.black54,
                height: 3,
              ),
            ),
            SizedBox(height: 20),
            CustomApercu(
              label: "Titre:",
              data: controller.myAdsView["title"],
            ),
            CustomApercu(
              label: "Type d'annonce:",
              data: controller.myAdsView["advertType"],
            ),
            CustomApercu(
              label: "Catégorie:",
              data: controller.myAdsView["category"],
            ),
            CustomApercuDescription(
              label: "Description de l'annonce :",
              data: controller.myAdsView["description"],
            ),
            CustomApercu(
              label: Environment.townLabel + ":",
              data: controller.myAdsView["town"],
            ),
            CustomApercu(
              label: Environment.cityLabel + " :",
              data: controller.myAdsView["city"],
            ),
            ListTile(
              contentPadding: EdgeInsets.all(8),
              title: const Text(
                'Afficher N° Tél',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: CupertinoSwitch(
                value: controller.lights,
                activeColor: Colors.grey,
                onChanged: (v) {},
              ),
              onTap: () {},
            ),
            Column(
              children: controller.myAdsView.entries.map((entry) {
                if (entry.key == "category" ||
                    entry.key == "title" ||
                    entry.key == "advertType" ||
                    entry.key == "description" ||
                    entry.key == "town" ||
                    entry.key == "city" ||
                    entry.key == "prix" ||
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
            CustomApercu(
              label: "prix :",
              data: controller.myAdsView["prix"] +
                  ' ' +
                  Environment.currencySymbol,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GetBuilder<TapPublishViewController>(builder: (logic) {
                  List<Widget> list = controller.editAdsImages
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: framColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: size.width * .3,
                                  height: size.height * .2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      e,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                      onTap: () {
                                        controller.delEditImage(e);
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        size: 30,
                                        color: framColor,
                                      )),
                                ),
                              ],
                            ),
                          ))
                      .toList();
                  List<Widget> list2 = controller.images
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: framColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: size.width * .3,
                                  height: size.height * .2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      e,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: InkWell(
                                      onTap: () {
                                        controller.deleteImage(e);
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        size: 30,
                                        color: framColor,
                                      )),
                                ),
                              ],
                            ),
                          ))
                      .toList();
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [...list2, ...list]);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20),
              child: Divider(
                color: Colors.black54,
                height: 3,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Obx(
              () => CheckboxListTile(
                title: const Text(
                  "J'accepte les conditions générales de lecoinoccasion.fr",
                  style: TextStyle(fontSize: 18),
                ),
                value: isCguAccepted.value,
                onChanged: (bool value) {
                  isCguAccepted.value = value;
                  error.value = value == false;
                },
                controlAffinity: ListTileControlAffinity.leading,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              ),
            ),
            Obx(() => error.isTrue
                ? Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Veuillez accepter nos conditions générales pour publier votre annonce',
                      style: TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  )
                : const SizedBox()),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 40,
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        int count = 0;

                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          foregroundColor: Colors.black54),
                      icon: const Icon(Icons.edit),
                      //icon data for elevated button
                      label: Text("Modifier"), //label text
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
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
                        controller.energie = null;
                        controller.kilometrage = null;
                        controller.lights = false;
                        controller.motosBrand = null;
                        controller.vehiculebrands = null;
                        int count = 0;
                        Navigator.popUntil(context, (route) {
                          return count++ == 2;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                          foregroundColor: Colors.black54),
                      icon: const Icon(Icons.restore_from_trash_rounded),
                      //icon data for elevated button
                      label: Text("Supprimer"), //label text
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Obx(() {
                      return controller.buttonPublier.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              onPressed: () {
                                if (isCguAccepted.isFalse) {
                                  error.value = true;
                                } else {
                                  error.value = false;
                                  controller.context = context;
                                  Get.find<TapPublishViewController>()
                                      .modifAds
                                      .value = false;
                                  controller.postData(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  foregroundColor: Colors.white),
                              icon: const Icon(Icons.check_circle),
                              //icon data for elevated button
                              label: Text("Publier"), //label text
                            );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
