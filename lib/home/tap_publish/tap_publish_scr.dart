import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_image/publish_image_scr.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/custom_text_filed2.dart';
import 'package:afariat/mywidget/widget_publish.dart';
import 'package:afariat/networking/api/ref_api.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tap_publish_viewcontroller.dart';

class TapPublishScr extends GetWidget<TapPublishViewController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.deepOrange,
        title: Text(
          "Déposer une annonce",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 25, left: 25, right: 25, top: 8),
          child: Form(
            key: controller.globalKey,
            child: ListView(
              //  padding: EdgeInsets.all(4),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GetBuilder<CategoryAndSubcategory>(builder: (logic) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Catégorie",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,


                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepOrange, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<CategoryGroupedJson>(
                            underline: SizedBox(),
                            isExpanded: true,
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text("Catégorie"),
                            ),
                            value: logic.categoryGroupedJson,
                            iconSize: 24,
                            elevation: 16,
                            onChanged: logic.updateCategorie,
                            items: logic.categoryGroupList
                                .map<DropdownMenuItem<CategoryGroupedJson>>(
                                    (CategoryGroupedJson value) {
                              return DropdownMenuItem<CategoryGroupedJson>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Text(value.name),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepOrange, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<SubcategoryJson>(
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text("Sous catégorie"),
                            ),
                            value: logic.subcategories1,
                            iconSize: 24,
                            elevation: 16,
                            onChanged: logic.updateSubCategorie,
                            items: logic.listeSubCategories
                                .map<DropdownMenuItem<SubcategoryJson>>(
                                    (SubcategoryJson value) {
                              return DropdownMenuItem<SubcategoryJson>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Text(value.name),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    );
                  }),
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Type d'annonce",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                GetBuilder<TapPublishViewController>(builder: (logic) {
                  return Column(
                    children: logic.values.map((e) {
                      return RadioListTile(
                          activeColor: Colors.deepOrange,
                          title: Text(e.name),
                          value: e,
                          groupValue: logic.advertType,
                          onChanged: logic.updateRadioButton);
                    }).toList(),
                  );
                }),
                GetBuilder<TapPublishViewController>(builder: (logic) {
                  return logic.getView != null
                      ? WidgetPublish(
                          logic.getView.name,
                        )
                      : SizedBox();
                }),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Titre de l'annonce",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextFiled(
                  color: framColor,
                  validator: controller.validator.validatetitle,
                  hintText: "Titre",
                  textEditingController: controller.title,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFiled(
                  maxLines: 5,
                  color: framColor,
                  validator: controller.validator.validateDescription,
                  hintText: "Description",
                  textEditingController: controller.description,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Prix",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * .82,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepOrange, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextFiled2(
                                color: Colors.deepOrange,
                                validator: controller.validator.validatePrice,
                                hintText: "Prix",
                                textEditingController: controller.prix,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text(
                              "DT",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Gouvernorat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                GetBuilder<LocController>(builder: (logic) {
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepOrange, width: 2),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<RefJson>(
                          isExpanded: true,
                          underline: SizedBox(),
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text("Gouvernorat"),
                            ),
                          ),
                          value: logic.city,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateCity,
                          items: logic.cities
                              .map<DropdownMenuItem<RefJson>>((RefJson value) {
                            return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Text(value.name),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Commune",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepOrange, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: DropdownButton<RefJson>(
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text("Commune"),
                            ),
                            value: logic.town,
                            iconSize: 24,
                            elevation: 16,
                            onChanged: logic.updatetown,
                            items: logic.towns.map<DropdownMenuItem<RefJson>>(
                                (RefJson value) {
                              return DropdownMenuItem<RefJson>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: Text(value.name),
                                ),
                              );
                            }).toList(),
                          ))
                    ],
                  );
                }),
                Row(
                  children: [
                    Icon(Icons.call),
                    Flexible(
                      flex: 1,
                      child: GetBuilder<TapPublishViewController>(
                          builder: (logic) {
                        return ListTile(
                          title: const Text('Afficher N° Tél'),
                          trailing: CupertinoSwitch(
                            value: logic.lights,
                            activeColor: Colors.deepOrange,
                            onChanged: logic.updateLight,
                          ),
                          onTap: () {
                            logic.lights = !logic.lights;
                          },
                        );
                      }),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 40, right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButtonWithoutIcon(
                          width: MediaQuery.of(context).size.width * .35,
                          height: 50,
                          label: "Suivant",
                          labColor: Colors.white,
                          btColor: buttonColor,
                          function: () {
                            //postAdvert(cities1,town1,advertType,price,description,title,photo)

                            if (controller.globalKey.currentState.validate() &&
                                controller.subCategories != null &&
                                controller.town != null) {
                              controller.myAdsView["prix"] =
                                  controller.prix.text +
                                      SettingsApp.moneySymbol;
                              controller.myAds["price"] = controller.prix.text;

                              controller.myAdsView["title"] =
                                  controller.title.text;
                              controller.myAds["title"] = controller.title.text;

                              controller.myAdsView["description"] =
                                  controller.description.text;
                              controller.myAds["description"] =
                                  controller.description.text;
                              controller.myAds["showPhoneNumber"] =
                                  controller.lights ? "yes" : "no";
                              controller.myAdsView["showPhoneNumber"] =
                                  controller.lights ? "Check" : "no";

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (
                                context,
                              ) =>
                                      PublishImageScr()));
                            } else {
                              Get.snackbar("Oups !",
                                  "Merci de corriger les erreurs ci-dessous.");
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
