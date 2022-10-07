import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../config/app_routing.dart';
import '../../../config/utility.dart';
import '../../../model/filter.dart';
import '../../../mywidget/search_field_appbar.dart';
import 'search_app_bar_viewcontroller.dart';

class SearchAppBarView extends GetWidget<SearchAppBarViewController> {
  const SearchAppBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Add the app bar to the CustomScrollView.
        SliverAppBar(
      // Provide a standard title.
      title: Column(children: <Widget>[
        Row(children: [
          Expanded(
            child: Obx(
              () => SearchFieldAppbar(
                onTaped: () => Get.toNamed(AppRouting.searchForm,
                    parameters: {'source': AppRouting.search}),
                value: Filter.search.value,
                hintText: 'Rechercher',
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
              // width: _size.width * .1,
              child: InkWell(
            onTap: () {
              //show sort popup
            },
            child: const Icon(
              Icons.more_vert,
              size: 30,
              color: colorGrey,
            ),
          ))
        ]),
      ]),
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            //color: framColor,
          ),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: backmenubackground,
      foregroundColor: framColor,
      // Allows the user to reveal the app bar if they begin scrolling
      // back up the list of items.
      floating: true,
      pinned: false,
      // Display a placeholder widget to visualize the shrinking size.
      //flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal.
      expandedHeight: 60,
    );
  }
}
