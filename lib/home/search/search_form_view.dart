import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/search/search_form_view_controller.dart';
import 'package:afariat/model/filter.dart';
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
    controller.source = Get.parameters.containsKey('source') ? Get.parameters['source'] : null;

    return Scaffold(
      appBar: AppBar(
        title: AutocompleteSearchField<SearchSuggestionJson>(
          controller: controller.searchFiled,
          context: context,
          hintText: 'Que cherchez-vous ?',
          value: Filter.get('search'),
          autofocus: true,
          suggestionsCallback: (query) async =>
              controller.getSuggestions(query),
          itemBuilder: (context, SearchSuggestionJson suggestionJson) {
            return ListTile(
              leading: const Icon(Icons.search),
              title: Text(suggestionJson.name),
            );
          },
          onSuggestionSelected: (SearchSuggestionJson suggestionJson) {
            //set the filter
            controller.suggestionSelect(suggestionJson);
          },
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
        child: CustomScrollView(
          //controller: controller.scrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            // _buildSavedSearchList(),
          ],
        ),
      ),
    );
  }

  _buildSavedSearchList() {}
}
