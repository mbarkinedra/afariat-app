import 'package:afariat/model/filter.dart';
import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/controllers/loc_controller.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';
import 'package:afariat/home/tap_publish/tap_publish_viewcontroller.dart';
import 'package:afariat/mywidget/widget_publish.dart';
import 'package:afariat/networking/json/categories_grouped_json.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'custom_button_1.dart';

class BottomSheetFilter extends StatefulWidget {
  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Catégorie",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<CategoryAndSubcategory>(builder: (logic) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: framColor, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<CategoryGroupedJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Text("Catégorie"),
                      ),
                      value: logic.categoryGroupedJson,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateCategory,
                      items: logic.categoryGroupList
                          .map<DropdownMenuItem<CategoryGroupedJson>>(
                              (CategoryGroupedJson value) {
                        return DropdownMenuItem<CategoryGroupedJson>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text(value.name),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: framColor, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<SubCategoryJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Text("Sous Catégories"),
                      ),
                      value: logic.subcategories1,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateSubCategory,
                      items: logic.listSubCategories
                          .map<DropdownMenuItem<SubCategoryJson>>(
                              (SubCategoryJson value) {
                        return DropdownMenuItem<SubCategoryJson>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text(value.name),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }),
          ),
          GetBuilder<TapPublishViewController>(builder: (logic) {
            logic.isFilterContext = true;
            return logic.getView != null
                ? WidgetPublish(
                    logic.getView.name,
                  )
                : SizedBox();
          }),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Prix",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          GetBuilder<TapHomeViewController>(builder: (logic) {
            return logic.loadPrice
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SfRangeSlider(
                        min: logic.minValuePrice,
                        max: logic.maxValuePrice,
                        activeColor: framColor,
                        values: logic.values,
                        interval: 1,
                        showTicks: false,
                        showLabels: false,
                        enableTooltip: true,
                        tooltipTextFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          return logic.prices[actualValue.toInt() - 1].name +
                              " " +
                              SettingsApp.moneySymbol;
                        },
                        labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          if (actualValue == 1 ||
                              actualValue == logic.prices.length) {
                            return logic.prices[actualValue.toInt() - 1].name +
                                " " +
                                SettingsApp.moneySymbol;
                          }
                          return ' ';
                        },
                        labelPlacement: LabelPlacement.onTicks,
                        onChanged: logic.updateSlideValue,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(logic.prices[logic.values.start.toInt() - 1]
                                    .name +
                                " " +
                                SettingsApp.moneySymbol),
                            Text(logic
                                    .prices[logic.values.end.toInt() - 1].name +
                                " " +
                                SettingsApp.moneySymbol)
                          ],
                        ),
                      )
                    ],
                  );
          }),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Localisation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          GetBuilder<LocController>(builder: (logic) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: framColor, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton<RefJson>(
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Text("Gouvernorat"),
                    ),
                    value: logic.city,
                    iconSize: 24,
                    elevation: 16,
                    onChanged: logic.updateCity,
                    items: logic.cities
                        .asMap()
                        .entries
                        .map<DropdownMenuItem<RefJson>>((value) {
                      return DropdownMenuItem<RefJson>(
                        value: value.value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text(value.value.name),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: framColor, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<RefJson>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Text("Ville"),
                      ),
                      value: logic.town,
                      iconSize: 24,
                      elevation: 16,
                      onChanged: logic.updateTown,
                      items: logic.towns
                          .map<DropdownMenuItem<RefJson>>((RefJson value) {
                        return DropdownMenuItem<RefJson>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text(value.name),
                          ),
                        );
                      }).toList(),
                    ))
              ],
            );
          }),
          Align(
            alignment: Alignment.center,
            child: CustomButton1(
              height: 50,
              width: _size.width * .4,
              function: () {
                //Filter.data.clear();
                /*Filter.data.forEach((key, value) {
                  ///add filter values to URL parameters
                  Filter.data[key] = value;
                });*/
                Get.find<TapHomeViewController>().filterUpdate();
                Navigator.pop(context);
              },
              labcolor: textbuttonColor,
              label: "Rechercher",
              btcolor: buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    ));
  }
}
