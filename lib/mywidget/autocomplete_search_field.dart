import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../config/utility.dart';

class AutocompleteSearchField<T> extends StatelessWidget {
  final TextEditingController controller;
  final Function onSuggestionSelected;
  final Function suggestionsCallback;
  final Function itemBuilder;
  final Function onClearText;
  final String value;
  final BuildContext context;
  final String hintText;
  final bool autofocus;

  AutocompleteSearchField(
      {Key key,
      this.controller,
      this.onSuggestionSelected,
      this.value,
      this.context,
      this.suggestionsCallback,
      this.itemBuilder,
      this.hintText,
      this.autofocus = false,
      this.onClearText})
      : super(key: key) {
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
          child: TypeAheadField<T>(
            hideSuggestionsOnKeyboardHide: false,
            debounceDuration: const Duration(milliseconds: 500),
            getImmediateSuggestions: false,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              constraints: BoxConstraints(maxHeight: _size.height * .3),
            ),
            autoFlipDirection: true,
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller,
              maxLines: 1,
              autofocus: autofocus,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: InputBorder.none,
                hintText: hintText ?? 'Rechercher',
                suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_outlined),
                    onPressed: () {
                      controller.clear();
                      onClearText();
                    }),
              ),
            ),
            suggestionsCallback: suggestionsCallback,
            itemBuilder: itemBuilder,
            onSuggestionSelected: onSuggestionSelected,
            noItemsFoundBuilder: (context) => const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Pas de résultat',
                    style: TextStyle(fontSize: 16, color: colorGrey))),
          ),
        ));
  }
}
