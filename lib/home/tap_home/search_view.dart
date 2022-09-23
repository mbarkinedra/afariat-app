import 'package:afariat/home/tap_home/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../config/utility.dart';
import 'filter_app_bar_view.dart';
import 'search_app_bar_view.dart';

class SearchView extends GetWidget<SearchViewController> {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SearchAppBarView(),
            const FilterAppBarView(),
            // Next, create a SliverList
            SliverList(
              // Use a delegate to build items as they're scrolled on screen.
              delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) => ListTile(title: Text('Item #$index')),
                // Builds 1000 ListTiles
                childCount: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
