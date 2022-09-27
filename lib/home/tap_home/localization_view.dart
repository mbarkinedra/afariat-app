import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../config/utility.dart';
import '../../networking/json/localization_json.dart';
import 'localization_viewcontroller.dart';

class LocalizationView extends GetWidget<LocalizationViewController> {
  const LocalizationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //key: controller.key,
      appBar: AppBar(
        title: const Text(
          " Où cherchez-vous ?",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              //
              Icons.arrow_back_ios,
              color: framColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 0, right: 16, left: 16),
        child: Column(
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: colorGrey,
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: TypeAheadField<LocalizationJson>(
                    hideSuggestionsOnKeyboardHide: false,
                    debounceDuration: const Duration(milliseconds: 500),
                    getImmediateSuggestions: false,
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      constraints: BoxConstraints(maxHeight: _size.height * .3),
                    ),
                    autoFlipDirection: true,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: controller.searchFiled,
                      maxLines: 1,
                      autofocus: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        hintText: 'Rechercher une localisation',
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.clear_outlined),
                            onPressed: () {
                              controller.clearSearchField();
                            }),
                      ),
                    ),
                    suggestionsCallback: (query) async {
                      return await controller.getSuggestions(query);
                    },
                    itemBuilder: (context, localizationJson) {
                      return ListTile(
                        leading: const Icon(Icons.location_on),
                        title: Text(localizationJson.name),
                        subtitle: Text(localizationJson.typeLabel),
                      );
                    },
                    onSuggestionSelected: (localizationJson) {
                      controller.addLocalization(localizationJson);
                    },
                    noItemsFoundBuilder: (context) => const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Pas de résultat',
                            style: TextStyle(fontSize: 16, color: colorGrey))),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            _buildLocalizationChips(context),
          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CustomButton1(
          function: () async {
            await controller.save(context);
          },
          labcolor: Colors.white,
          height: 40,
          width: _size.width * .8,
          label: "Valider la localisation",
          btcolor: buttonColor,
          icon: Icons.check_circle,
          iconcolor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLocalizationChips(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<Rx<LocalizationListJson>> snapshot) {
        if (snapshot.hasData) {
          return Obx(() => Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: controller.localizationsJsonList.value.count(),
                itemBuilder: (BuildContext context, int index) {
                  return Align(
                      alignment: Alignment.centerLeft,
                      child: InputChip(
                        label: Obx(() => Text(controller
                            .localizationsJsonList.value
                            .toList()[index]
                            .toString())),
                        onDeleted: () {
                          controller.localizationsJsonList.value
                              .removeAt(index);
                          controller.localizationsJsonList.refresh();
                        },
                      ));
                },
              )));
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: controller.loadLocalizationsFromStorage(),
    );
  }
}
