import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/network_controller.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_publish/publish_views/publish_image/publish_image_scr.dart';
import 'package:afariat/mywidget/custom_button_without_icon.dart';
import 'package:afariat/mywidget/custom_text_filed.dart';
import 'package:afariat/mywidget/custom_text_filed2.dart';
import 'package:afariat/mywidget/widget_publish.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_view_controller.dart';
import 'tap_publish_viewcontroller.dart';

class TapPublishScr extends GetWidget<TapPublishViewController> {
  // int p = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    controller.globalKey = globalKey;
    return Scaffold(
        appBar: AppBar(
            leading: Obx(() => controller.modifAds.value
                ? InkWell(
                    onTap: () {
                      Get.find<HomeViwController>().changeItemFilter(1);
                    },
                    child: Icon(Icons.arrow_back))
                : SizedBox()),
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: framColor,
            title: Obx(
              () => Text(
                controller.modifAds.value
                    ? "Mettre à jour l'annonce"
                    : "Déposer une annonce",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        body: Container(
          child: Obx(
            () => Column(
              children: [
                Get.find<NetWorkController>().connectionStatus.value == false
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                        height: 50,
                        width: 50,
                      )
                    : SizedBox(),
                Get.find<NetWorkController>().connectionStatus.value
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 25, left: 25, right: 25, top: 8),
                          child: Form(
                            onWillPop: controller.function,
                            key: globalKey,
                            child: ListView(
                              //  padding: EdgeInsets.all(4),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GetBuilder<CategoryAndSubcategory>(
                                      builder: (logic) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Catégorie",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: framColor, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: DropdownButton<
                                              CategoryGroupedJson>(
                                            underline: SizedBox(),
                                            isExpanded: true,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: Text("Catégorie"),
                                            ),
                                            value: logic.categoryGroupedJson,
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: logic.updateCategory,
                                            items: logic.categoryGroupList
                                                .where((element) =>
                                                    element.name != "")
                                                .map<DropdownMenuItem<CategoryGroupedJson>>(
                                                    (CategoryGroupedJson
                                                        value) {
                                              return DropdownMenuItem<
                                                  CategoryGroupedJson>(
                                                value: value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text(value.name),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Obx(() => Text(
                                                    controller
                                                        .validateCategory.value,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: framColor, width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:
                                              DropdownButton<SubcategoryJson>(
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8),
                                              child: Text("Sous catégorie"),
                                            ),
                                            value: logic.subcategories1,
                                            iconSize: 24,
                                            elevation: 16,
                                            onChanged: logic.updateSubCategory,
                                            items: logic.listSubCategories
                                                .where((element) =>
                                                    element.name != "")
                                                .map<
                                                        DropdownMenuItem<
                                                            SubcategoryJson>>(
                                                    (SubcategoryJson value) {
                                              return DropdownMenuItem<
                                                  SubcategoryJson>(
                                                value: value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text(value.name),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Obx(() => Text(
                                                    controller
                                                        .validateSousCatgory
                                                        .value,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  )),
                                            ))
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                    width: size.width * .8,
                                    color: framColor,
                                    validator:
                                        controller.validator.validateTitle,
                                    hintText: "Titre",
                                    textEditingController: controller.title,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                    color: framColor,
                                    width: size.width * .8,
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
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
                                                  "DT",
                                                  style: TextStyle(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Gouvernorat",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: GetBuilder<LocController>(
                                      builder: (logic) {
                                    return logic.getCity
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: framColor,
                                                        width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: DropdownButton<RefJson>(
                                                  isExpanded: true,
                                                  underline: SizedBox(),
                                                  hint: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            right: 8),
                                                    child: Text("Gouvernorat"),
                                                  ),
                                                  value: logic.city,
                                                  iconSize: 24,
                                                  elevation: 16,
                                                  onChanged: logic.updateCity,
                                                  items: logic.cities
                                                      .where((element) =>
                                                          element.name != "")
                                                      .map<
                                                              DropdownMenuItem<
                                                                  RefJson>>(
                                                          (RefJson value) {
                                                    return DropdownMenuItem<
                                                        RefJson>(
                                                      value: value,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                right: 8),
                                                        child: Text(value.name),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Obx(() => Text(
                                                          controller
                                                              .validateCity
                                                              .value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  )),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, bottom: 8),
                                                  child: Text(
                                                    "Commune",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: framColor,
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child:
                                                      DropdownButton<RefJson>(
                                                    isExpanded: true,
                                                    underline: SizedBox(),
                                                    hint: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 10),
                                                      child: Text("Commune"),
                                                    ),
                                                    value: logic.town,
                                                    iconSize: 24,
                                                    elevation: 16,
                                                    onChanged: logic.updateTown,
                                                    items: logic.towns
                                                        .where((element) =>
                                                            element.name != "")
                                                        .map<
                                                                DropdownMenuItem<
                                                                    RefJson>>(
                                                            (RefJson value) {
                                                      return DropdownMenuItem<
                                                          RefJson>(
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
                                                  )),
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Obx(() => Text(
                                                          controller
                                                              .validateTown
                                                              .value,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ))
                                            ],
                                          );
                                  }),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.call),
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
                                            validateDefaultOptions(context);
                                            validateGetView(context);
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                        )),
                      ))
              ],
            ),
          ),
        )
        //})
        );
  }

  void validateDefaultOptions(context) {
    if (controller.globalKey.currentState.validate()) {
      controller.myAdsView["prix"] =
          controller.prix.text + " " + SettingsApp.moneySymbol;
      controller.myAds["price"] = controller.prix.text;
      controller.myAdsView["title"] = controller.title.text;
      controller.myAds["title"] = controller.title.text;
      controller.myAdsView["description"] = controller.description.text;
      controller.myAds["description"] = controller.description.text;
      controller.myAds["showPhoneNumber"] = controller.lights ? "yes" : "no";
      controller.myAdsView["showPhoneNumber"] =
          controller.lights ? "Check" : "no";

      Navigator.of(context).push(MaterialPageRoute(
          builder: (
        context,
      ) =>
              PublishImageScr()));
    } else {
      Get.snackbar("Oups !", "Merci de corriger les erreurs ci-dessous.");
    }
  }

  void clearValidateOption() {
    controller.validateTown.value = "";
    controller.validateCity.value = "";
  //  controller.validateCategory.value = "";
   // controller.validateSousCatgory.value = "";
    controller.validatePiece.value = "";
    controller.validateMarque.value = "";
    controller.validateModele.value = "";
    controller.validateEnergie.value = "";
    controller.validateYears.value = " ";
    controller.validateKm.value = "";
  }

  void validateGetView(context) {
    if (controller.category == null) {
      controller.validateCategory.value = " Catégorie est obligatoire";
    } else {
      controller.validateCategory.value = "";
    }
    if (controller.subCategories == null) {
      controller.validateSousCatgory.value = "SousCatégorie est obligatoire";
    } else {
     controller.validateCategory.value = "";
    }
    if (controller.town == null) {
      controller.validateTown.value = " commune est obligatoire";
    } else {
      controller.validateTown.value = "";
    }
    if (controller.citie == null) {
      controller.validateCity.value = " ville est obligatoire";
    } else {
      controller.validateCity.value = "";
    }

    if (controller.nombrePiece == null) {
      controller.validatePiece.value = " Nombre des pieces sont obligatoires ";
    } else {
      controller.validatePiece.value = "";
    }
    if (controller.vehiculebrands == null) {
      controller.validateMarque.value = " la marque est obligatoire";
    } else {
      controller.validateMarque.value = "";
    }
    if (controller.vehiculeModel == null) {
      controller.validateModele.value = " Le modele est obligatoire";
    } else {
      controller.validateModele.value = "";
    }
    if (controller.energie == null) {
      controller.validateEnergie.value = "L'energie st obligatoire";
    } else {
      controller.validateEnergie.value = "";
    }
    if (controller.yearsModele == null) {
      controller.validateYears.value = " L'année est obligatoire";
    } else {
      controller.validateYears.value = " ";
    }

    if (controller.kilometrage == null) {
      controller.validateKm.value = "Kilometrage est obligatoire";
    } else {
      controller.validateKm.value = "";
    }

    if (controller.subCategories != null &&
        controller.category != null &&
        controller.town != null &&
        controller.citie != null) {
      if (controller.subCategories.name == "Voitures" ||
          controller.subCategories.name == "Voitures professionnelles") {
        if (controller.vehiculebrands != null &&
            controller.vehiculeModel != null &&
            controller.energie != null &&
            controller.kilometrage != null &&
            controller.yearsModele != null) {
          validateDefaultOptions(context);
        } else {
          Get.snackbar("Oups !",
              "merci de bien vouloir compléter les champs ci dessous.");
        }
      } else if (controller.subCategories.name == "Motos") {
        if (controller.motosBrand != null &&
            controller.kilometrage != null &&
            controller.yearsModele != null) {
          validateDefaultOptions(context);
        } else {
          Get.snackbar("Oups !",
              "merci de bien vouloir compléter les champs ci dessous.");
        }
      } else if (controller.subCategories.name == "Appartements" ||
          controller.subCategories.name == "Maison" ||
          controller.subCategories.name == "Bureaux et locaux commerciaux") {
        if (controller.nombrePieces != null && controller.surface != null) {
          controller.myAdsView["Superficie"] =
              controller.surface.text.replaceAll("-", "") + " " + "m²";
          controller.myAds["area"] = controller.surface.text;

          validateDefaultOptions(context);
        } else {
          Get.snackbar("Oups !",
              "merci de bien vouloir compléter les champs ci dessous.");
        }
      } else {
        validateDefaultOptions(context);
      }
    } else {
      Get.snackbar(
          "Oups !", "merci de bien vouloir compléter les champs ci dessous.");
    }
  }
}
