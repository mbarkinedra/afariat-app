import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../config/app_routing.dart';
import '../../../config/utility.dart';
import '../../../mywidget/custom_button_1.dart';
import '../../../mywidget/favorite_card_grid.dart';
import '../../../networking/json/favorite_json.dart';
import 'favorite_view_controller.dart';

class FavoriteView extends GetWidget<FavoriteViewController> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Mes annonces sauvegardées",
            style: TextStyle(color: blackcolore),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: framColor,
              ),
              onPressed: () {
                Get.back();
              }),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: _buildGrid(context)));
  }

  _buildGrid(BuildContext context) {
    return PagedGridView<int, FavoriteJson>(
      showNewPageProgressIndicatorAsGridChild: true,
      showNewPageErrorIndicatorAsGridChild: true,
      showNoMoreItemsIndicatorAsGridChild: true,
      pagingController: controller.pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 100 / 150,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
      ),
      builderDelegate: PagedChildBuilderDelegate<FavoriteJson>(
          itemBuilder: (context, item, index) => FavoriteCardGrid(
                favoriteJson: item,
                controller: controller,
                index: index,
              ),
          noItemsFoundIndicatorBuilder: (_) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Pas d\'annonces \n sauvegardées',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomButton1(
                        function: () async {
                          Get.toNamed(AppRouting.search);
                        },
                        labcolor: Colors.white,
                        height: 40,
                        width: context.mediaQuery.size.width * .8,
                        label: "Parcourir les annonces",
                        btcolor: buttonColor,
                        fontSize: 16,
                      ),
                    ),
                  ])),
    );
  }
}
