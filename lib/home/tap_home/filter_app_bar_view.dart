import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../config/utility.dart';
import '../../model/filter.dart';
import 'filter_app_bar_viewcontroller.dart';

class FilterAppBarView extends GetWidget<FilterAppBarViewController> {
  const FilterAppBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _isSelected = <bool>[
      true,
      false,
    ];
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
                onPressed: () {},
                child: Row(
                  children: [
                    const Text('Filtres',
                        style: TextStyle(color: Colors.black87)),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                        backgroundColor: framColor,
                        radius: 14,
                        child: Obx(
                          () => Text(
                              //Filter.count().toString(),
                              Filter.rxParameters.value.count.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        )),
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
            ToggleButtons(
              children: const <Widget>[
                Icon(Icons.list_outlined),
                Icon(Icons.grid_view_outlined),
              ],
              isSelected: _isSelected,
              onPressed: (int index) {
                //setState(() {
                _isSelected[index] = !_isSelected[index];
                //});
              },
            ),
          ])),
      toolbarHeight: 60,
      //expandedHeight: 40,
      //collapsedHeight: 40,
      backgroundColor: backmenubackground,
      foregroundColor: framColor,
    );
  }
}
