import 'package:afariat/home/tap_home/search_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/utility.dart';
import '../../model/filter.dart';
import 'filter_app_bar_viewcontroller.dart';

class FilterAppBarView extends GetWidget<FilterAppBarViewController> {
  const FilterAppBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList _isSelected = <bool>[
      true,
      false,
    ].obs;
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 40.0,
              width: 110.0,
              child: OutlinedButton(
                onPressed: () {
                  Get.toNamed('/filter');
                },
                child: Row(
                  children: [
                    const Text('Filtres',
                        style: TextStyle(color: Colors.black87)),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(
                      () => Filter.rxParameters.value.count > 0
                          ? CircleAvatar(
                              backgroundColor: framColor,
                              radius: 14,
                              child: Text(
                                  Filter.rxParameters.value.count.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            )
                          : SizedBox(),
                    )
                  ],
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: 40.0,
              width: 160.0,
              child: OutlinedButton.icon(
                onPressed: () {
                  Get.toNamed('/filter/localization');
                },
                label: Obx(() => Text(controller.localizationLabel.value,
                    style: const TextStyle(color: Colors.black87))),
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black87,
                  size: 20.0,
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Obx(() => ToggleButtons(
                  children: const <Widget>[
                    Icon(Icons.list_outlined),
                    Icon(Icons.grid_view_outlined),
                  ],
                  isSelected: _isSelected.value,
                  onPressed: (int index) {
                    _isSelected.value =
                        _isSelected.value.map((e) => !e).toList();
                    Get.find<SearchViewController>().isGrid.value =
                        index == 1 ? true : false;
                  },
                )),
          ])),
      toolbarHeight: 60,
      //expandedHeight: 40,
      //collapsedHeight: 40,
      backgroundColor: backmenubackground,
      foregroundColor: framColor,
    );
  }
}
