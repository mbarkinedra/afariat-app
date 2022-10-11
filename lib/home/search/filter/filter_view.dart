import 'package:afariat/config/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../config/Environment.dart';
import '../../../model/filter.dart';
import '../../../mywidget/autocomplete_search_field.dart';
import '../../../mywidget/custom_button_1.dart';
import '../../../networking/json/localization_json.dart';
import '../../../networking/json/serach_suggestion.dart';
import '../../../remote_widget/price_range_slider_view.dart';
import 'filter_viewcontroller.dart';

class FilterView extends GetWidget<FilterViewController> {
  const FilterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    controller.source =
        Get.parameters.containsKey('source') ? Get.parameters['source'] : null;
    return Scaffold(
      //key: controller.key,
      appBar: AppBar(
        title: Obx(
          () => AutocompleteSearchField<SearchSuggestionJson>(
            controller: controller.searchFiled,
            context: context,
            hintText: 'Que cherchez-vous ?',
            value: Filter.search.value,
            autofocus: false,
            suggestionsCallback: (query) async =>
                controller.getSuggestions(query),
            itemBuilder: (context, SearchSuggestionJson suggestionJson) {
              return ListTile(
                leading: const Icon(Icons.search),
                title: (suggestionJson.categoryId != null &&
                        suggestionJson.categoryId != 0)
                    ? Row(
                        children: [
                          Text(suggestionJson.text),
                          const Text(
                            ' dans ',
                            style: TextStyle(color: colorGrey),
                          ),
                          Text(
                            suggestionJson.categoryName,
                            style: const TextStyle(color: framColor),
                          )
                        ],
                      )
                    : Text(suggestionJson.text),
              );
            },
            onSuggestionSelected: (SearchSuggestionJson suggestionJson) =>
                controller.suggestionSelect(suggestionJson),
            noItemsFoundBuilder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.isLoadingSuggestions.isFalse
                  ? Text('Pas de résultat',
                      style: TextStyle(fontSize: 16, color: colorGrey))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Recherche...',
                          style: TextStyle(fontSize: 16, color: colorGrey),
                        ),
                        CupertinoActivityIndicator()
                      ],
                    ),
            ),
            onClearText: () => Filter.search.value = null,
          ),
        ),
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
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Get.back();
          }
        },
        child: SafeArea(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 0.5, color: colorGrey),
                      )),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: buttonColor,
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
                                      (Filter.category.value != null &&
                                              Filter.category.value.id != null)
                                          ? Filter.category.value.name
                                          : ((Filter.categoryGroup.value !=
                                                      null &&
                                                  Filter.categoryGroup.value
                                                          .id !=
                                                      null)
                                              ? Filter.categoryGroup.value.name
                                              : 'Toutes les catégories'),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: PriceRangeSlider(
                          controller: controller.priceRangeSliderViewController,
                          onChange: (SfRangeValues values) {
                            Filter.minPrice.value = values.start.toInt();
                            Filter.maxPrice.value = values.end.toInt();
                            //print(Filter.maxPrice.value);
                          }),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      title: const Text(
                        'Uniquement avec photos',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: Obx(
                        () => CupertinoSwitch(
                          value: Filter.onlyPhoto.value,
                          activeColor: framColor,
                          onChanged: (v) {
                            Filter.onlyPhoto.value = v;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
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
                  controller.clear(context);
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
                  controller.search(context);
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
                  child: Filter.localization.value.count() > 0
                      ? Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: List<Widget>.generate(
                            Filter.localization.value.count(),
                            (int index) {
                              return Chip(
                                label: Text(
                                  Filter.localization.value
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
                        )
                      : InkWell(
                          onTap: () => Get.toNamed('/filter/localization'),
                          child: Text(Environment.allCountryLabel),
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
