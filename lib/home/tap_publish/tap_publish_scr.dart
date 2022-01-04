import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_publish/publish_views/apercu_publich.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_image/publish_image_scr.dart';
import 'package:afariat/mywidget/custmbutton.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("Deposer une annonce ")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          padding: EdgeInsets.all(4),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<CategoryAndSubcategory>(builder: (logic) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<CategoryGroupedJson>(
                        isExpanded: true,
                        hint: Text("catÃ©gorie"),
                        value: logic.categoryGroupedJson,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: logic.updateCategorie,
                        items: logic.categoryGroupList
                            .map<DropdownMenuItem<CategoryGroupedJson>>(
                                (CategoryGroupedJson value) {
                              return DropdownMenuItem<CategoryGroupedJson>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<SubcategoryJson>(
                        isExpanded: true,
                        hint: Text("sub catÃ©gorie"),
                        value: logic.subcategories1,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: logic.updateSupCategorie,
                        items: logic.listSubcategories
                            .map<DropdownMenuItem<SubcategoryJson>>(
                                (SubcategoryJson value) {
                              return DropdownMenuItem<SubcategoryJson>(
                                value: value,
                                child: Text(value.name),
                              );
                            }).toList(),
                      ),
                    )
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Type d'annonce",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GetBuilder<TapPublishViewController>(builder: (logic) {
              return Column(
                children: logic.valus.map((e) {
                  return RadioListTile(
                      title: Text(e.name),
                      value: e.name,
                      groupValue: logic.advertType,
                      onChanged: logic.updateRadioButton);
                }).toList(),
              );
            }),
            //if (subcategories1 != null) getview(getOption),

            GetBuilder<TapPublishViewController>(builder: (logic) {
              return logic.getview != null
                  ? WidgetPublish(
                logic.getview.name,
              )
                  : SizedBox();
            }),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CustomTextFiled(
              color: framColor,
              hintText: "",
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
            CustomTextFiled(
              color: framColor,
              hintText: "description",
              textEditingController: controller.description,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "price",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: CustomTextFiled(
                    color: Colors.orange,
                    hintText: "price",
                    textEditingController: controller.price,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(0)),
                  child: Text(
                    "DT",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "City",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            GetBuilder<LocController>(builder: (logic) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<RefJson>(
                      isExpanded: true,
                      hint: Text("city"),
                      value: logic.citie,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updatecitie,
                      items: logic.cities
                          .map<DropdownMenuItem<RefJson>>((RefJson value) {
                        return DropdownMenuItem<RefJson>(
                          value: value,
                          child: Text(value.name),
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
                        "Town",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton<RefJson>(
                        isExpanded: true,
                        hint: Text("town"),
                        value: logic.town,
                        iconSize: 24,
                        elevation: 16,
                        onChanged: logic.updatetown,
                        items: logic.towns
                            .map<DropdownMenuItem<RefJson>>((RefJson value) {
                          return DropdownMenuItem<RefJson>(
                            value: value,
                            child: Text(value.name),
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
                  child: GetBuilder<TapPublishViewController>(builder: (logic) {
                    return ListTile(
                      title: const Text('Show phone number'),
                      trailing: CupertinoSwitch(
                        value: logic.lights,
                        activeColor: Colors.orange,
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
            // Visibility(visible: _lights,
            //   child: CustomTextField(
            //     lap: "Numero de telephone",
            //     function: (v) {
            //       print(v);
            //     },
            //   ),
            // ),
            GetBuilder<TapPublishViewController>(builder: (logic) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      width: MediaQuery.of(context).size.width * .35,
                      height: 50,
                      label: "Next",
                      btcolor: buttonColor,
                      function: () {
                        //postAdvert(cities1,town1,advertType,price,description,title,photo)
                        controller.myAdsview["price"] = controller.price.text;
                        controller.myAds["price"] = controller.price.text;

                        controller.myAdsview["title"] = controller.title.text;
                        controller.myAds["title"] = controller.title.text;

                        controller.myAdsview["description"] =
                            controller.description.text;
                        controller.myAds["description"] =
                            controller.description.text;
                        controller.myAds["showPhoneNumber"] =
                        controller.lights ? "yes" : "no";
                        controller.myAdsview["showPhoneNumber"] =
                        controller.lights ? "yes" : "no";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (
                                context,
                                ) =>
                                PublishImageScr()));
                      }),
                  if(logic.showvaled)CustomButton(
                      width: MediaQuery.of(context).size.width * .35,
                      height: 50,
                      label: "metre a jour",
                      btcolor: Colors.green,
                      function: () {
                        controller.myAdsview["price"] = controller.price.text;
                        controller.myAds["price"] = controller.price.text;

                        controller.myAdsview["title"] = controller.title.text;
                        controller.myAds["title"] = controller.title.text;

                        controller.myAdsview["description"] =
                            controller.description.text;
                        controller.myAds["description"] =
                            controller.description.text;
                        controller.myAds["showPhoneNumber"] =
                        controller.lights ? "yes" : "no";
                        controller.myAdsview["showPhoneNumber"] =
                        controller.lights ? "yes" : "no";
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (
                                context,
                                ) =>
                                ApercuPublich()));
                      }), ],
              );
            }
            ),
          ],
        ),
      ),
    );
  }
}