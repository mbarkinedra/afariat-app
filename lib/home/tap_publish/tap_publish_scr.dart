import 'package:afariat/config/Environment.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_image_scr.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/custom_text_filed2.dart';
import 'package:afariat/mywidget/widget_publish.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../networking/network.dart';
import '../main_view_controller.dart';
import 'tap_publish_viewcontroller.dart';

class TapPublishScr extends GetWidget<TapPublishViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.formKey = formKey;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            leading: Obx(() => controller.modifAds.value
                ? InkWell(
                    onTap: () {
                      //Get.find<MainViewController>().changeItemFilter(1);
                    },
                    child: const Icon(Icons.arrow_back))
                : const SizedBox()),
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: framColor,
            title: Obx(
              () => Text(
                controller.modifAds.value
                    ? "Mettre à jour l'annonce"
                    : "Déposer une annonce",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        body: Obx(
          () => Column(
            children: [
              Network.status.value == false
                  ? const SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                      height: 50,
                      width: 50,
                    )
                  : const SizedBox(),
              Network.status.value
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 25, left: 25, right: 25, top: 8),
                        child: Form(
                          onWillPop: controller.function,
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetBuilder<CategoryAndSubcategory>(
                                      builder: (logic) {
                                    return logic.categoryGroupList.isEmpty
                                        ? const CircularProgressIndicator()
                                        : Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Catégorie",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: framColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child:
                                                      DropdownButtonFormField<
                                                          CategoryGroupedJson>(
                                                    isExpanded: true,
                                                    hint: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                      child: Text("Catégorie"),
                                                    ),
                                                    validator:
                                                        (CategoryGroupedJson) {
                                                      return controller
                                                          .validator
                                                          .validateCategory(
                                                              CategoryGroupedJson);
                                                    },
                                                    value: logic
                                                        .categoryGroupedJson,
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    decoration:
                                                        const InputDecoration
                                                                .collapsed(
                                                            hintText: ''),
                                                    onChanged:
                                                        logic.updateCategory,
                                                    items: logic
                                                        .categoryGroupList
                                                        .where((element) =>
                                                            element.name != "")
                                                        .map<
                                                                DropdownMenuItem<
                                                                    CategoryGroupedJson>>(
                                                            (CategoryGroupedJson
                                                                value) {
                                                      return DropdownMenuItem<
                                                          CategoryGroupedJson>(
                                                        value: value,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8),
                                                          child:
                                                              Text(value.name),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: framColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child:
                                                      DropdownButtonFormField<
                                                          SubCategoryJson>(
                                                    isExpanded: true,
                                                    //   underline: SizedBox(),
                                                    hint: const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                      child: Text(
                                                          "Sous catégorie"),
                                                    ),
                                                    validator:
                                                        (SubCategoryJson) {
                                                      return controller
                                                          .validator
                                                          .validateCategory(
                                                              SubCategoryJson);
                                                    },
                                                    value: logic.subcategories1,
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    decoration:
                                                        const InputDecoration
                                                                .collapsed(
                                                            hintText: ''),
                                                    onChanged:
                                                        logic.updateSubCategory,
                                                    items: logic
                                                        .listSubCategories
                                                        .where((element) =>
                                                            element.name != "")
                                                        .map<
                                                                DropdownMenuItem<
                                                                    SubCategoryJson>>(
                                                            (SubCategoryJson
                                                                value) {
                                                      return DropdownMenuItem<
                                                          SubCategoryJson>(
                                                        value: value,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8),
                                                          child:
                                                              Text(value.name),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  }),
                                ),
                                Row(
                                  children: const [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Type d'annonce",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GetBuilder<TapPublishViewController>(
                                    builder: (logic) {
                                  return Column(
                                    children: logic.values.map((e) {
                                      return RadioListTile(
                                          activeColor: framColor,
                                          title: Text(e.name),
                                          value: e,
                                          groupValue: logic.advertType,
                                          onChanged: logic.updateRadioButton);
                                    }).toList(),
                                  );
                                }),
                                GetBuilder<TapPublishViewController>(
                                    builder: (logic) {
                                  return logic.getView != null
                                      ? WidgetPublish(
                                          logic.getView.name,
                                        )
                                      : SizedBox();
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Titre de l'annonce",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: CustomTextFiled(
                                    width: size.width * .9,
                                    color: framColor,
                                    validator:
                                        controller.validator.validateTitle,
                                    hintText: "Titre",
                                    textEditingController: controller.title,
                                    maxLines: 1,
                                    maxLength: 65,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: CustomTextFiled(
                                    maxLines: 5,
                                    maxLength: 65000,
                                    color: framColor,
                                    width: size.width * .9,
                                    validator: controller
                                        .validator.validateDescription,
                                    hintText: "Description",
                                    textEditingController:
                                        controller.description,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Prix",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          // width: size.width * .87,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: framColor, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: CustomTextFiled2(
                                                      color: framColor,
                                                      validator: controller
                                                          .validator
                                                          .validatePrice,
                                                      hintText: "Prix",
                                                      textEditingController:
                                                          controller.prix,
                                                      keyboardType:
                                                          TextInputType.number),
                                                ),
                                                Text(
                                                  Environment.currencySymbol,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Localisation",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: GetBuilder<LocController>(
                                      builder: (logic) {
                                    return logic.cities.isEmpty
                                        ? const CircularProgressIndicator()
                                        : logic.getCity
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : logic.cities != null
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    framColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child:
                                                              DropdownButtonFormField<
                                                                  RefJson>(
                                                            isExpanded: true,
                                                            //underline: SizedBox(),
                                                            hint: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right: 8),
                                                              child: Text(
                                                                  Environment
                                                                      .cityLabel),
                                                            ),
                                                            validator:
                                                                (RefJson) {
                                                              return controller
                                                                  .validator
                                                                  .validateCity(
                                                                      RefJson);
                                                            },

                                                            value: logic.city,
                                                            iconSize: 24,
                                                            elevation: 16,
                                                            decoration:
                                                                const InputDecoration
                                                                        .collapsed(
                                                                    hintText:
                                                                        ''),
                                                            onChanged: logic
                                                                .updateCity,
                                                            items: logic.cities
                                                                .where((element) =>
                                                                    element
                                                                        .name !=
                                                                    "")
                                                                .map<
                                                                    DropdownMenuItem<
                                                                        RefJson>>((RefJson
                                                                    value) {
                                                              return DropdownMenuItem<
                                                                  RefJson>(
                                                                value: value,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right: 8),
                                                                  child: Text(
                                                                      value
                                                                          .name),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        height: 60,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    framColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Center(
                                                          child:
                                                              DropdownButtonFormField<
                                                                  RefJson>(
                                                            isExpanded: true,
                                                            //underline: SizedBox(),
                                                            hint: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                  Environment
                                                                      .townLabel),
                                                            ),
                                                            validator:
                                                                (RefJson) {
                                                              return controller
                                                                  .validator
                                                                  .validateTown(
                                                                      RefJson);
                                                            },
                                                            value: logic.town,
                                                            iconSize: 24,
                                                            elevation: 16,
                                                            decoration:
                                                                const InputDecoration
                                                                        .collapsed(
                                                                    hintText:
                                                                        ''),
                                                            onChanged: logic
                                                                .updateTown,
                                                            items: logic.towns
                                                                .where((element) =>
                                                                    element
                                                                        .name !=
                                                                    "")
                                                                .map<
                                                                    DropdownMenuItem<
                                                                        RefJson>>((RefJson
                                                                    value) {
                                                              return DropdownMenuItem<
                                                                  RefJson>(
                                                                value: value,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 8.0,
                                                                      right: 8),
                                                                  child: Text(
                                                                      value
                                                                          .name),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                  }),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.call),
                                    Flexible(
                                      flex: 1,
                                      child:
                                          GetBuilder<TapPublishViewController>(
                                              builder: (logic) {
                                        return ListTile(
                                          title: const Text('Afficher N° Tél'),
                                          trailing: CupertinoSwitch(
                                            value: logic.lights,
                                            activeColor: framColor,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomButtonWithoutIcon(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          height: 50,
                                          label: "Suivant",
                                          labColor: Colors.white,
                                          btColor: buttonColor,
                                          function: () {
                                            /*controller.surface.text.replaceAll("-", "") + " " + "m²";
                                            controller.myAds["area"] = controller.surface.text;*/
                                            controller.validator
                                                .validationType = false;
                                            if (!controller.formKey.currentState
                                                .validate()) {
                                              //if client validations fails
                                              //show a snackbar to fix the client errors.
                                              Get.snackbar("Oups !",
                                                  "Merci de corriger les erreurs ci-dessous.");
                                              return;
                                            }
                                            controller.defaultOptions();

                                            //   controller.validator.validationType = true;
                                            //send data to server and get errors
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (
                                              context,
                                            ) =>
                                                        PublishImageScr()));
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 80,
                          color: framColor,
                        ),
                        Text(
                          "Pas de connexion internet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                      ],
                    )))
            ],
          ),
        ));
  }
}
