import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/remote_widget/ref_dropdown_viewcontroller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

abstract class RefDropdown<GetLifeCycleBase>
    extends GetWidget<RefDropdownViewController> {
  @override
  final RefDropdownViewController controller;

  final String label;

  final Function validator;

  RefDropdown(this.controller, this.label, this.validator, {Key key}) : super(key: key);

  //GetLifeCycleBase controller = RefDropdownViewController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RefListJson>(
        future: controller.fetchItems(),
        builder: (context, AsyncSnapshot<RefListJson> snapshot) {
          if (snapshot.hasData) {
            return DropdownSearch<RefJson>(
              mode: Mode.DIALOG,
              showSearchBox: true,
              items: controller.items.data,
              itemAsString: (RefJson r) => r.toString(),
              dropdownSearchDecoration: InputDecoration(
                labelText: label,
                border: InputBorder.none,
              ),
              onChanged: (element) => controller.selectedItem = element,
              selectedItem: controller.selectedItem,
              validator: validator,
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
