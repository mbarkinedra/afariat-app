import 'package:afariat/config/settings_app.dart';
import 'package:afariat/config/utilitie.dart';
import 'package:afariat/controllers/category_and_subcategory.dart';
import 'package:afariat/home/tap_home/tap_home_viewcontroller.dart';

import 'package:afariat/networking/json/categories_grouped_json.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'custmbutton.dart';

class BottomSheetFilter extends StatefulWidget {
  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  String dropdownValue = 'One';

  final tap1ViewController = Get.find<TapHomeViewController>();

  // final categoryAndSubcategory = Get.find<CategoryAndSubcategory>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
            child: GetBuilder<CategoryAndSubcategory>(builder: (logic) {
              return Column(
                children: [
                  DropdownButton<CategoryGroupedJson>(
                    isExpanded: true,
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
                  DropdownButton<SubcategoryJson>(
                    isExpanded: true,
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
                  )
                ],
              );
            }),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Prix",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        GetBuilder<TapHomeViewController>(builder: (logic) {
          return SfRangeSlider(
            min: logic.minValue,
            max: logic.maxValue,
            values: logic.values,
            interval: 1,
            showTicks: false,
            showLabels: true,
            enableTooltip: true,
            tooltipTextFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return logic.prices[actualValue.toInt() - 1].name +
                  " " +
                  SettingsApp.moneySymbol;
            },
            labelFormatterCallback:
                (dynamic actualValue, String formattedText) {
              if (actualValue == 1 || actualValue == logic.prices.length) {
                return logic.prices[actualValue.toInt() - 1].name +
                    " " +
                    SettingsApp.moneySymbol;
              }
              return '';
            },
            onChanged: logic.updateslidval,
          );
        }),
        Row(
          children: [
            CustomButton(
              height: 50,
              width: _size.width * .4,
              function: () {},
              labcolor: textbuttonColor,
              label: "Appliquer",
              btcolor: buttonColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        )
      ],
    ));
  }
}
