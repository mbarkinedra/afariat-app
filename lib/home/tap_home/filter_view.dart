import 'package:afariat/config/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../model/filter.dart';
import '../../mywidget/custom_button_1.dart';
import '../../mywidget/search_field_appbar.dart';
import '../../networking/json/localization_json.dart';
import '../../remote_widget/price_range_slider_view.dart';
import 'filter_viewcontroller.dart';
import '../../config/utility.dart';

class FilterView extends GetWidget<FilterViewController> {
  const FilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: controller.key,
      appBar: AppBar(
        title: SearchFieldAppbar(),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: framColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Catégorie",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 0.5, color: colorGrey),
                    )),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: buttonColor,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 0, left: 0),
                      ),
                      onPressed: () {
                        Get.toNamed('/filter/category');
                      },
                      child: Row(
                        children: [
                          Expanded(
                              flex: 9,
                              child: Obx(() => Text(
                                    controller.categoryLabel.value,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ))),
                          const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: colorGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Localisation",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _buildLocalizationChips(context),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Prix",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: PriceRangeSlider(
                        controller: controller.priceRangeSliderViewController,
                        onChange: (SfRangeValues values) {
                          controller.priceRangeSliderViewController.values
                              .value = values;
                          Filter.set(
                              "minPrice", values.start.toInt().toString());
                          Filter.set("maxPrice", values.end.toInt().toString());
                        }),
                  )
                ],
              ),
            )),
      ),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Row(children: [
            Expanded(
              flex: 3,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  controller.clear();
                },
                child: const Text(
                  'Effacer',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    shadows: [
                      Shadow(color: Colors.black, offset: Offset(0, -3))
                    ],
                    color: Colors.transparent,
                    decorationColor: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: CustomButton1(
                function: () async {
                  //TODO: save the filter and refresh the results
                },
                labcolor: Colors.white,
                height: 40,
                width: _size.width * .8,
                label: "Rechercher",
                btcolor: buttonColor,
                icon: Icons.search,
                iconcolor: Colors.white,
              ),
            ),
          ])),
    );
  }

  Widget _buildLocalizationChips(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<Rx<LocalizationListJson>> snapshot) {
        if (snapshot.hasData) {
          return Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 9,
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List<Widget>.generate(
                      controller.localizationsJsonList.value.count(),
                      (int index) {
                        return Chip(
                          label: Text(
                            controller.localizationsJsonList.value
                                .toList()[index]
                                .toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.grey[300],
                        );
                      },
                    ).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    tooltip: 'Mettre à jour les localisations',
                    onPressed: () {
                      Get.toNamed('/filter/localization');
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: controller.initLocalizationsFromStorageIfEmpty(),
    );
  }
}
