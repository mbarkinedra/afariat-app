import 'package:afariat/home/search/search_viewcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../config/utility.dart';
import '../../mywidget/advert_card_grid.dart';
import '../../mywidget/advert_card_list.dart';
import '../../networking/json/advert_minimal_json.dart';
import 'filter/filter_app_bar_view.dart';
import 'components/search_app_bar_view.dart';

class SearchView extends GetWidget<SearchViewController> {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // key: controller.key,
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Get.back();
          }
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              const SearchAppBarView(),
              const FilterAppBarView(),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500),
                      () async => await controller.swipeDown());
                },
              ),
              // Next, create a SliverList
              _buildGrid(context),
              SliverToBoxAdapter(
                child: Obx(() => controller.isLoadingMore.isTrue
                    ? const Center(child: CupertinoActivityIndicator())
                    : const SizedBox.shrink()),
              ),
              SliverToBoxAdapter(
                child: Obx(() => controller.noMoreResults.isTrue
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'Plus d\'annonces. Essayez de modifier vos critères de recherches',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: colorGrey),
                        ),
                      ))
                    : const SizedBox.shrink()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildGrid(context) {
    Size _size = MediaQuery.of(context).size;
    return Obx(() => controller.isGrid.value
        ? PagedSliverGrid<int, AdvertMinimalJson>(
            pagingController: controller.pagingController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 150,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              mainAxisExtent: 320,
            ),
            builderDelegate: PagedChildBuilderDelegate<AdvertMinimalJson>(
              animateTransitions: true,
              itemBuilder: (context, item, index) => AdvertCardGrid(
                advert: item,
                imageHeight: 150,
                imageWidth: 200,
              ),
            ),
          )
        : PagedSliverList<int, AdvertMinimalJson>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<AdvertMinimalJson>(
              animateTransitions: true,
              itemBuilder: (context, item, index) =>
                  AdvertCardList(advert: item, userInitials: 'LCO'),
            ),
          ));
  }
}
