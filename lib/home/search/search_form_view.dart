import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/search/search_form_view_controller.dart';
import 'package:afariat/model/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../config/utility.dart';
import '../../mywidget/autocomplete_search_field.dart';
import '../../networking/json/serach_suggestion.dart';

class SearchFormView extends GetWidget<SearchFormViewController> {
  const SearchFormView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.source =
        Get.parameters.containsKey('source') ? Get.parameters['source'] : null;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => AutocompleteSearchField<SearchSuggestionJson>(
            controller: controller.searchFiled,
            context: context,
            hintText: 'Que cherchez-vous ?',
            value: Filter.search.value,
            autofocus: true,
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
            onSuggestionSelected: (SearchSuggestionJson suggestionJson) {
              //set the filter
              controller.suggestionSelect(suggestionJson);
            },
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
              //
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
          padding: const EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 8),
          child: CustomScrollView(
            //controller: controller.scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: ListTile(
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
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 5,
                ),
              ),

              const SliverToBoxAdapter(
                child: Text(
                  'Mes recherches sauvegardées',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  //contentPadding: const EdgeInsets.all(8),
                  title: const Text(
                    'Toutes catégories',
                    style: TextStyle(fontSize: 16),
                  ),
                  leading: const Icon(Icons.all_inclusive_sharp),
                  onTap: () {
                    controller.allCategories();
                  },
                ),
              ),
              // _buildSavedSearchList(),
            ],
          ),
        )),
      ),
      bottomNavigationBar: SizedBox(
        child: Padding(
          padding:
              MediaQuery.of(context).viewInsets, //for floating over keyboard
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: OutlinedButton.icon(
              icon: const Icon(
                Icons.filter_alt_outlined,
              ),
              label: const Text('Plus de critères'),
              onPressed: () => Get.toNamed(AppRouting.filter, parameters: {
                'source':
                    controller.source != null ? controller.source : 'searchForm'
              }),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  _buildSavedSearchList() {}
}
